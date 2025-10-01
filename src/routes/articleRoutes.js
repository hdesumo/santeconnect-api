import express from "express";
import { getArticles, getArticleById, createArticle } from "../controllers/articleController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

// Liste des articles (public)
router.get("/", getArticles);

// Article par ID (public)
router.get("/:id", getArticleById);

// Création article (protégé)
router.post("/", authMiddleware, createArticle);

export default router;
