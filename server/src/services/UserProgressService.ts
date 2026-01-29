import type { UserProgressRepository } from '../repositories/UserProgressRepository';
import type {
  UserAnswer,
  WrongBookItem,
  LearningProgress,
  AnswerFilters,
  WrongBookFilters,
  CreateAnswerInput,
} from '../types/userProgress';

export class UserProgressService {
  constructor(private readonly repository: UserProgressRepository) {}

  // User Answers
  async recordAnswer(input: CreateAnswerInput): Promise<UserAnswer> {
    // Record the answer
    const answer = await this.repository.createAnswer(input);

    // Update learning progress
    await this.repository.updateProgress(input.userId, input.isCorrect);

    // If wrong answer, add to wrong book
    if (!input.isCorrect) {
      await this.repository.addToWrongBook({
        userId: input.userId,
        questionId: input.questionId,
      });
    }

    return answer;
  }

  async getAnswerHistory(filters: AnswerFilters): Promise<{
    answers: UserAnswer[];
    total: number;
  }> {
    const [answers, total] = await Promise.all([
      this.repository.getAnswers(filters),
      this.repository.getAnswerCount(filters.userId),
    ]);
    return { answers, total };
  }

  // Wrong Book
  async getWrongBooks(filters: WrongBookFilters): Promise<WrongBookItem[]> {
    return this.repository.getWrongBooks(filters);
  }

  async markWrongBookAsMastered(id: string): Promise<WrongBookItem | null> {
    return this.repository.markAsMastered(id);
  }

  async deleteWrongBook(id: string): Promise<boolean> {
    return this.repository.deleteWrongBook(id);
  }

  async getWrongBookStats(userId: string): Promise<{
    total: number;
    unmastered: number;
    mastered: number;
  }> {
    const [total, mastered] = await Promise.all([
      this.repository.getWrongBookCount(userId),
      this.repository.getWrongBookCount(userId, true),
    ]);
    return {
      total,
      mastered,
      unmastered: total - mastered,
    };
  }

  // Learning Progress
  async getProgress(userId: string): Promise<LearningProgress> {
    return this.repository.getOrCreateProgress(userId);
  }

  async getDetailedStats(userId: string): Promise<{
    progress: LearningProgress;
    wrongBookStats: {
      total: number;
      unmastered: number;
      mastered: number;
    };
  }> {
    const [progress, wrongBookStats] = await Promise.all([
      this.getProgress(userId),
      this.getWrongBookStats(userId),
    ]);
    return { progress, wrongBookStats };
  }
}
