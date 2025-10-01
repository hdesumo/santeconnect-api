import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { getTransactions, createTransaction } from "../controllers/transactionController.js";

const router = express.Router();

// Transactions de l'utilisateur connecté
router.get("/", authMiddleware, getTransactions);

// Créer une transaction
router.post("/", authMiddleware, createTransaction);

export default router;
