import express from "express";
import { getSoignants, getSoignantById } from "../controllers/soignantController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getSoignants);
router.get("/:id", authMiddleware, getSoignantById);

export default router;
