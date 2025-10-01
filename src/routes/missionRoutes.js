import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { getMissions, createMission } from "../controllers/missionController.js";

const router = express.Router();

// Toutes les missions (offres)
router.get("/", authMiddleware, getMissions);

// Créer une mission (offre)
router.post("/", authMiddleware, createMission);

export default router;
