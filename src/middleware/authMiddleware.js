import jwt from "jsonwebtoken";
import pool from "../config/db.js";

export const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) return res.status(401).json({ error: "Token manquant" });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Vérifier si l’utilisateur existe encore en DB
    const { rows } = await pool.query("SELECT id, email FROM users WHERE id = $1", [decoded.id]);
    if (rows.length === 0) return res.status(403).json({ error: "Utilisateur non trouvé" });

    req.user = rows[0];
    next();
  } catch (err) {
    return res.status(403).json({ error: "Token invalide ou expiré" });
  }
};
