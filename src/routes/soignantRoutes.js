import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { getSoignants, getSoignantById } from "../controllers/soignantController.js";

const router = express.Router();

// Tous les soignants
router.get("/", authMiddleware, getSoignants);

// Un soignant par ID
router.get("/:id", authMiddleware, getSoignantById);

export default router;
