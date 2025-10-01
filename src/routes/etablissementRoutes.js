import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { 
  getEtablissements, 
  getEtablissementById, 
  createEtablissement 
} from "../controllers/etablissementController.js";

const router = express.Router();

// Tous les établissements
router.get("/", authMiddleware, getEtablissements);

// Un établissement par ID
router.get("/:id", authMiddleware, getEtablissementById);

// Créer un établissement
router.post("/", authMiddleware, createEtablissement);

export default router;
