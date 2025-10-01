import express from "express";
import cors from "cors";
import dotenv from "dotenv";

import authRoutes from "./routes/authRoutes.js";
import soignantRoutes from "./routes/soignantRoutes.js";
import etablissementRoutes from "./routes/etablissementRoutes.js";
import missionRoutes from "./routes/missionRoutes.js";
import applicationRoutes from "./routes/applicationRoutes.js";
import transactionRoutes from "./routes/transactionRoutes.js";
import articleRoutes from "./routes/articleRoutes.js";

import pool from "./config/db.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Routes principales
app.use("/api/auth", authRoutes);
app.use("/api/soignants", soignantRoutes);
app.use("/api/etablissements", etablissementRoutes);
app.use("/api/missions", missionRoutes);
app.use("/api/candidatures", applicationRoutes);
app.use("/api/transactions", transactionRoutes);
app.use("/api/articles", articleRoutes);

// Healthcheck API simple
app.get("/health", (req, res) => {
  res.json({ status: "ok", message: "API SantéConnect en ligne 🚀" });
});

// Healthcheck DB
app.get("/health/db", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");
    res.json({ status: "ok", db: result.rows[0] });
  } catch (err) {
    console.error("❌ DB Error:", err.message);
    res.status(500).json({ status: "error", error: err.message });
  }
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`✅ API running on port ${PORT}`);
});
