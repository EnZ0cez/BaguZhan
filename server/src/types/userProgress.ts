export type UserAnswer = {
  id: string;
  userId: string;
  questionId: string;
  selectedOptionId: string;
  isCorrect: boolean;
  answerTimeMs?: number;
  answeredAt: string;
};

export type WrongBookItem = {
  id: string;
  userId: string;
  questionId: string;
  question?: {
    id: string;
    content: string;
    topic: string;
    difficulty: string;
    explanation?: string | null;
    mnemonic?: string | null;
    scenario?: string | null;
  };
  wrongCount: number;
  lastWrongAt: string;
  isMastered: boolean;
  masteredAt?: string | null;
};

export type LearningProgress = {
  id: string;
  userId: string;
  totalAnswered: number;
  totalCorrect: number;
  accuracyRate: number;
  currentStreak: number;
  longestStreak: number;
  lastAnsweredAt?: string | null;
};

export type AnswerFilters = {
  userId: string;
  limit?: number;
  offset?: number;
};

export type WrongBookFilters = {
  userId: string;
  isMastered?: boolean;
};

export type CreateAnswerInput = {
  userId: string;
  questionId: string;
  selectedOptionId: string;
  isCorrect: boolean;
  answerTimeMs?: number;
};

export type CreateWrongBookInput = {
  userId: string;
  questionId: string;
};
