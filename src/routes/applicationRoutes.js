import express from "express";
import { applyToMission } from "../controllers/applicationController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/:id/apply", authMiddleware, applyToMission);

export default router;
