import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import pool from "../db.js";

export const register = async (req, res) => {
  try {
    const { email, password, fullName } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO "User" (email, password_hash, full_name, role, email_verified)
       VALUES ($1, $2, $3, 'user', false)
       RETURNING id, email, full_name, role, email_verified`,
      [email, hashedPassword, fullName]
    );

    res.json({ user: result.rows[0] });
  } catch (err) {
    console.error("❌ Register error:", err);
    res.status(500).json({ error: "Erreur serveur", details: err.message });
  }
};

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const result = await pool.query(`SELECT * FROM "User" WHERE email=$1`, [email]);
    if (result.rows.length === 0) {
      return res.status(401).json({ error: "Utilisateur non trouvé" });
    }

    const user = result.rows[0];
    const isPasswordValid = await bcrypt.compare(password, user.password_hash);
    if (!isPasswordValid) {
      return res.status(401).json({ error: "Mot de passe incorrect" });
    }

    console.log("🔑 [LOGIN] JWT_SECRET utilisé:", process.env.JWT_SECRET);

    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.full_name,
        role: user.role,
        emailVerified: user.email_verified,
      },
    });
  } catch (err) {
    console.error("❌ Login error:", err);
    res.status(500).json({ error: "Erreur serveur", details: err.message });
  }
};
