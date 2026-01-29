import type { DbClient } from '../database/connection';
import type {
  UserAnswer,
  WrongBookItem,
  LearningProgress,
  AnswerFilters,
  WrongBookFilters,
  CreateAnswerInput,
  CreateWrongBookInput,
} from '../types/userProgress';

type UserAnswerRow = {
  id: string;
  user_id: string;
  question_id: string;
  selected_option_id: string;
  is_correct: number;
  answer_time_ms: number | null;
  answered_at: string;
};

type WrongBookRow = {
  id: string;
  user_id: string;
  question_id: string;
  wrong_count: number;
  last_wrong_at: string;
  is_mastered: number;
  mastered_at: string | null;
  question_content: string | null;
  question_topic: string | null;
  question_difficulty: string | null;
  question_explanation: string | null;
  question_mnemonic: string | null;
  question_scenario: string | null;
};

type LearningProgressRow = {
  id: string;
  user_id: string;
  total_answered: number;
  total_correct: number;
  current_streak: number;
  longest_streak: number;
  last_answered_at: string | null;
};

export class UserProgressRepository {
  constructor(private readonly db: DbClient) {}

  // User Answers
  async createAnswer(input: CreateAnswerInput): Promise<UserAnswer> {
    const id = crypto.randomUUID();
    const sql = `
      INSERT INTO user_answers (id, user_id, question_id, selected_option_id, is_correct, answer_time_ms)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    await this.db.run(sql, [
      id,
      input.userId,
      input.questionId,
      input.selectedOptionId,
      input.isCorrect ? 1 : 0,
      input.answerTimeMs ?? null,
    ]);

    return {
      id,
      userId: input.userId,
      questionId: input.questionId,
      selectedOptionId: input.selectedOptionId,
      isCorrect: input.isCorrect,
      answerTimeMs: input.answerTimeMs,
      answeredAt: new Date().toISOString(),
    };
  }

  async getAnswers(filters: AnswerFilters): Promise<UserAnswer[]> {
    const { userId, limit = 20, offset = 0 } = filters;
    const sql = `
      SELECT * FROM user_answers
      WHERE user_id = ?
      ORDER BY answered_at DESC
      LIMIT ? OFFSET ?
    `;
    const rows = await this.db.all<UserAnswerRow>(sql, [userId, limit, offset]);
    return rows.map(this.mapAnswerRow);
  }

  async getAnswerCount(userId: string): Promise<number> {
    const sql = `SELECT COUNT(*) as count FROM user_answers WHERE user_id = ?`;
    const result = await this.db.get<{ count: number }>(sql, [userId]);
    return result?.count ?? 0;
  }

  // Wrong Book
  async addToWrongBook(input: CreateWrongBookInput): Promise<WrongBookItem> {
    // Check if already exists
    const existingSql = `
      SELECT * FROM wrong_book WHERE user_id = ? AND question_id = ?
    `;
    const existing = await this.db.get<WrongBookRow>(existingSql, [
      input.userId,
      input.questionId,
    ]);

    if (existing) {
      // Update wrong count and last_wrong_at
      const updateSql = `
        UPDATE wrong_book
        SET wrong_count = wrong_count + 1, last_wrong_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `;
      await this.db.run(updateSql, [existing.id]);

      return {
        id: existing.id,
        userId: existing.user_id,
        questionId: existing.question_id,
        wrongCount: existing.wrong_count + 1,
        lastWrongAt: new Date().toISOString(),
        isMastered: Boolean(existing.is_mastered),
        masteredAt: existing.mastered_at,
      };
    }

    // Create new wrong book entry
    const id = crypto.randomUUID();
    const insertSql = `
      INSERT INTO wrong_book (id, user_id, question_id)
      VALUES (?, ?, ?)
    `;
    await this.db.run(insertSql, [id, input.userId, input.questionId]);

    return {
      id,
      userId: input.userId,
      questionId: input.questionId,
      wrongCount: 1,
      lastWrongAt: new Date().toISOString(),
      isMastered: false,
      masteredAt: null,
    };
  }

  async getWrongBooks(filters: WrongBookFilters): Promise<WrongBookItem[]> {
    const { userId, isMastered } = filters;
    let sql = `
      SELECT 
        wb.*,
        q.content as question_content,
        q.topic as question_topic,
        q.difficulty as question_difficulty,
        q.explanation as question_explanation,
        q.mnemonic as question_mnemonic,
        q.scenario as question_scenario
      FROM wrong_book wb
      LEFT JOIN questions q ON q.id = wb.question_id
      WHERE wb.user_id = ?
    `;
    const params: (string | number)[] = [userId];

    if (typeof isMastered === 'boolean') {
      sql += ` AND wb.is_mastered = ?`;
      params.push(isMastered ? 1 : 0);
    }

    sql += ` ORDER BY wb.last_wrong_at DESC`;

    const rows = await this.db.all<WrongBookRow>(sql, params);
    return rows.map(this.mapWrongBookRow);
  }

  async markAsMastered(id: string): Promise<WrongBookItem | null> {
    const sql = `
      UPDATE wrong_book
      SET is_mastered = 1, mastered_at = CURRENT_TIMESTAMP
      WHERE id = ?
    `;
    await this.db.run(sql, [id]);

    // Return updated item
    const selectSql = `
      SELECT 
        wb.*,
        q.content as question_content,
        q.topic as question_topic,
        q.difficulty as question_difficulty,
        q.explanation as question_explanation,
        q.mnemonic as question_mnemonic,
        q.scenario as question_scenario
      FROM wrong_book wb
      LEFT JOIN questions q ON q.id = wb.question_id
      WHERE wb.id = ?
    `;
    const row = await this.db.get<WrongBookRow>(selectSql, [id]);
    return row ? this.mapWrongBookRow(row) : null;
  }

  async deleteWrongBook(id: string): Promise<boolean> {
    const sql = `DELETE FROM wrong_book WHERE id = ?`;
    await this.db.run(sql, [id]);
    return true;
  }

  async getWrongBookCount(userId: string, isMastered?: boolean): Promise<number> {
    let sql = `SELECT COUNT(*) as count FROM wrong_book WHERE user_id = ?`;
    const params: (string | number)[] = [userId];

    if (typeof isMastered === 'boolean') {
      sql += ` AND is_mastered = ?`;
      params.push(isMastered ? 1 : 0);
    }

    const result = await this.db.get<{ count: number }>(sql, params);
    return result?.count ?? 0;
  }

  // Learning Progress
  async getOrCreateProgress(userId: string): Promise<LearningProgress> {
    const selectSql = `SELECT * FROM learning_progress WHERE user_id = ?`;
    const existing = await this.db.get<LearningProgressRow>(selectSql, [userId]);

    if (existing) {
      return this.mapProgressRow(existing);
    }

    // Create new progress record
    const id = crypto.randomUUID();
    const insertSql = `
      INSERT INTO learning_progress (id, user_id)
      VALUES (?, ?)
    `;
    await this.db.run(insertSql, [id, userId]);

    return {
      id,
      userId,
      totalAnswered: 0,
      totalCorrect: 0,
      accuracyRate: 0,
      currentStreak: 0,
      longestStreak: 0,
      lastAnsweredAt: null,
    };
  }

  async updateProgress(
    userId: string,
    isCorrect: boolean
  ): Promise<LearningProgress> {
    const progress = await this.getOrCreateProgress(userId);

    const newTotalAnswered = progress.totalAnswered + 1;
    const newTotalCorrect = progress.totalCorrect + (isCorrect ? 1 : 0);
    const newAccuracyRate = newTotalCorrect / newTotalAnswered;

    // Calculate streak
    let newCurrentStreak = progress.currentStreak;
    let newLongestStreak = progress.longestStreak;

    if (progress.lastAnsweredAt) {
      const lastDate = new Date(progress.lastAnsweredAt);
      const today = new Date();
      const diffDays = Math.floor(
        (today.getTime() - lastDate.getTime()) / (1000 * 60 * 60 * 24)
      );

      if (diffDays === 1) {
        newCurrentStreak += 1;
        if (newCurrentStreak > newLongestStreak) {
          newLongestStreak = newCurrentStreak;
        }
      } else if (diffDays > 1) {
        newCurrentStreak = 1;
      }
    } else {
      newCurrentStreak = 1;
    }

    const sql = `
      UPDATE learning_progress
      SET 
        total_answered = ?,
        total_correct = ?,
        current_streak = ?,
        longest_streak = ?,
        last_answered_at = CURRENT_TIMESTAMP,
        updated_at = CURRENT_TIMESTAMP
      WHERE user_id = ?
    `;
    await this.db.run(sql, [
      newTotalAnswered,
      newTotalCorrect,
      newCurrentStreak,
      newLongestStreak,
      userId,
    ]);

    return {
      ...progress,
      totalAnswered: newTotalAnswered,
      totalCorrect: newTotalCorrect,
      accuracyRate: newAccuracyRate,
      currentStreak: newCurrentStreak,
      longestStreak: newLongestStreak,
      lastAnsweredAt: new Date().toISOString(),
    };
  }

  // Helper methods
  private mapAnswerRow(row: UserAnswerRow): UserAnswer {
    return {
      id: row.id,
      userId: row.user_id,
      questionId: row.question_id,
      selectedOptionId: row.selected_option_id,
      isCorrect: Boolean(row.is_correct),
      answerTimeMs: row.answer_time_ms ?? undefined,
      answeredAt: row.answered_at,
    };
  }

  private mapWrongBookRow(row: WrongBookRow): WrongBookItem {
    return {
      id: row.id,
      userId: row.user_id,
      questionId: row.question_id,
      question: row.question_content
        ? {
            id: row.question_id,
            content: row.question_content,
            topic: row.question_topic ?? '',
            difficulty: row.question_difficulty ?? '',
            explanation: row.question_explanation,
            mnemonic: row.question_mnemonic,
            scenario: row.question_scenario,
          }
        : undefined,
      wrongCount: row.wrong_count,
      lastWrongAt: row.last_wrong_at,
      isMastered: Boolean(row.is_mastered),
      masteredAt: row.mastered_at,
    };
  }

  private mapProgressRow(row: LearningProgressRow): LearningProgress {
    const totalAnswered = row.total_answered;
    const totalCorrect = row.total_correct;
    return {
      id: row.id,
      userId: row.user_id,
      totalAnswered,
      totalCorrect,
      accuracyRate: totalAnswered > 0 ? totalCorrect / totalAnswered : 0,
      currentStreak: row.current_streak,
      longestStreak: row.longest_streak,
      lastAnsweredAt: row.last_answered_at,
    };
  }
}
