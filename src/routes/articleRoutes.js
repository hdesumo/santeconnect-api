import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { 
  getArticles, 
  getArticleById, 
  createArticle 
} from "../controllers/articleController.js";

const router = express.Router();

// Tous les articles
router.get("/", getArticles);

// Article par ID
router.get("/:id", getArticleById);

// Créer un article (protégé, par ex admin ou auteur connecté)
router.post("/", authMiddleware, createArticle);

export default router;
