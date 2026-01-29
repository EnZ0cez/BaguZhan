import { Router } from 'express';
import type { UserProgressService } from '../services/UserProgressService';
import { asyncHandler } from '../middlewares/asyncHandler';

export const createUserProgressRouter = (
  service: UserProgressService
): Router => {
  const router = Router();

  // Record an answer
  router.post(
    '/answers',
    asyncHandler(async (req, res) => {
      const { userId, questionId, selectedOptionId, isCorrect, answerTimeMs } =
        req.body;

      if (!userId || !questionId || !selectedOptionId || typeof isCorrect !== 'boolean') {
        res.status(400).json({ error: 'Missing required fields' });
        return;
      }

      const answer = await service.recordAnswer({
        userId,
        questionId,
        selectedOptionId,
        isCorrect,
        answerTimeMs,
      });

      res.status(201).json(answer);
    })
  );

  // Get answer history
  router.get(
    '/answers',
    asyncHandler(async (req, res) => {
      const { userId, limit = '20', offset = '0' } = req.query;

      if (!userId || typeof userId !== 'string') {
        res.status(400).json({ error: 'userId is required' });
        return;
      }

      const result = await service.getAnswerHistory({
        userId,
        limit: parseInt(limit as string, 10),
        offset: parseInt(offset as string, 10),
      });

      res.json(result);
    })
  );

  // Get wrong book
  router.get(
    '/wrong-book',
    asyncHandler(async (req, res) => {
      const { userId, isMastered } = req.query;

      if (!userId || typeof userId !== 'string') {
        res.status(400).json({ error: 'userId is required' });
        return;
      }

      const wrongBooks = await service.getWrongBooks({
        userId,
        isMastered:
          isMastered === 'true' ? true : isMastered === 'false' ? false : undefined,
      });

      res.json(wrongBooks);
    })
  );

  // Mark wrong book as mastered
  router.patch(
    '/wrong-book/:id/master',
    asyncHandler(async (req, res) => {
      const { id } = req.params;
      const updated = await service.markWrongBookAsMastered(id);

      if (!updated) {
        res.status(404).json({ error: 'Wrong book item not found' });
        return;
      }

      res.json(updated);
    })
  );

  // Delete wrong book item
  router.delete(
    '/wrong-book/:id',
    asyncHandler(async (req, res) => {
      const { id } = req.params;
      await service.deleteWrongBook(id);
      res.status(204).send();
    })
  );

  // Get learning progress
  router.get(
    '/progress',
    asyncHandler(async (req, res) => {
      const { userId } = req.query;

      if (!userId || typeof userId !== 'string') {
        res.status(400).json({ error: 'userId is required' });
        return;
      }

      const progress = await service.getProgress(userId);
      res.json(progress);
    })
  );

  // Get detailed stats
  router.get(
    '/progress/stats',
    asyncHandler(async (req, res) => {
      const { userId } = req.query;

      if (!userId || typeof userId !== 'string') {
        res.status(400).json({ error: 'userId is required' });
        return;
      }

      const stats = await service.getDetailedStats(userId);
      res.json(stats);
    })
  );

  return router;
};
