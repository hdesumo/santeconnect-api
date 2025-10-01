// src/server.js
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

import pool from "./db.js"; // utilisation du pool stable (comme check-env.js)

dotenv.config();

const app = express();
const PORT = process.env.PORT || 8080;

// Middlewares
app.use(cors());
app.use(express.json());

// === Health checks ===
app.get("/health", (req, res) => {
  res.json({ status: "ok", message: "API SantéConnect en ligne 🚀" });
});

app.get("/health/db", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");
    res.json({ status: "ok", db: result.rows[0] });
  } catch (err) {
    console.error("❌ DB Error:", err.message);
    res.status(500).json({ error: "Erreur connexion DB", details: err.message });
  }
});

// === Routes principales ===
app.use("/api/auth", authRoutes);
app.use("/api/soignants", soignantRoutes);
app.use("/api/etablissements", etablissementRoutes);
app.use("/api/missions", missionRoutes);
app.use("/api/candidatures", applicationRoutes);
app.use("/api/transactions", transactionRoutes);
app.use("/api/articles", articleRoutes);

// Lancement serveur
app.listen(PORT, () => {
  console.log(`✅ API running on port ${PORT}`);
});
