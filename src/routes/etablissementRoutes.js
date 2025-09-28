import express from "express";
import { getEtablissements, getEtablissementById } from "../controllers/etablissementController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getEtablissements);
router.get("/:id", authMiddleware, getEtablissementById);

export default router;
