import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { getCandidatures, applyToOffre } from "../controllers/applicationController.js";

const router = express.Router();

// Toutes les candidatures
router.get("/", authMiddleware, getCandidatures);

// Postuler à une offre
router.post("/", authMiddleware, applyToOffre);

export default router;
