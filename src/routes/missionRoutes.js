import express from "express";
import { createMission, getMissions } from "../controllers/missionController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/", authMiddleware, createMission);
router.get("/", getMissions);

export default router;
