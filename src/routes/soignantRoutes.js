import express from "express";
import { getSoignants, getSoignantById } from "../controllers/soignantController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

// Liste des soignants (protégée par authMiddleware)
router.get("/", authMiddleware, getSoignants);

// Détails d’un soignant par ID (protégée aussi)
router.get("/:id", authMiddleware, getSoignantById);

export default router;
