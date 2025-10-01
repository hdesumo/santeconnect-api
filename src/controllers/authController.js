import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import pool from "../db.js";
import dotenv from "dotenv";

dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET || "secret";

// === Register ===
export async function register(req, res) {
  try {
    const { email, password, fullName, role } = req.body;

    if (!email || !password || !fullName) {
      return res.status(400).json({ error: "Champs manquants" });
    }

    // Vérifie si l'email existe déjà
    const existing = await pool.query('SELECT * FROM "User" WHERE email = $1', [email]);
    if (existing.rows.length > 0) {
      return res.status(400).json({ error: "Email déjà utilisé" });
    }

    // Hash du mot de passe
    const hashed = await bcrypt.hash(password, 10);

    // ⚡ INSERT corrigé
    const result = await pool.query(
      'INSERT INTO "User"(email, password_hash, full_name, role) VALUES($1,$2,$3,$4) RETURNING id, email, full_name, role, email_verified',
      [email, hashed, fullName, role || "user"]
    );

    return res.json({ user: result.rows[0] });
  } catch (err) {
    console.error("❌ Register error:", err);
    res.status(500).json({ error: "Erreur serveur", details: err.message });
  }
}

// === Login ===
export async function login(req, res) {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: "Champs manquants" });
    }

    // Récupère l'utilisateur
    const result = await pool.query('SELECT * FROM "User" WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(400).json({ error: "Utilisateur introuvable" });
    }
    const user = result.rows[0];

    // Vérifie mot de passe (⚡ utilise password_hash)
    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) {
      return res.status(400).json({ error: "Mot de passe invalide" });
    }

    // Génère token
    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      JWT_SECRET,
      { expiresIn: "1h" }
    );

    return res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.full_name,
        role: user.role,
        emailVerified: user.email_verified
      }
    });
  } catch (err) {
    console.error("❌ Login error:", err);
    res.status(500).json({ error: "Erreur serveur", details: err.message });
  }
}
