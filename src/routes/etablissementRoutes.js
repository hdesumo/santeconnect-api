import express from "express";
import { getEtablissements, getEtablissementById } from "../controllers/etablissementController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

// Liste des établissements
router.get("/", authMiddleware, getEtablissements);

// Détails d’un établissement par ID
router.get("/:id", authMiddleware, getEtablissementById);

export default router;
