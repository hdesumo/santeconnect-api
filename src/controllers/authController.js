import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import pool from "../config/db.js";

// 🔹 Register
export const register = async (req, res) => {
  try {
    const { email, password, fullName } = req.body;
    if (!email || !password || !fullName) {
      return res.status(400).json({ error: "Champs requis : email, password, fullName" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const { rows } = await pool.query(
      'INSERT INTO "User" (email, password, "fullName") VALUES ($1, $2, $3) RETURNING id, email, "fullName"',
      [email, hashedPassword, fullName]
    );

    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// 🔹 Login
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const { rows } = await pool.query(
      'SELECT * FROM "User" WHERE email = $1',
      [email]
    );
    const user = rows[0];
    if (!user) return res.status(401).json({ error: "Utilisateur introuvable" });

    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ error: "Mot de passe incorrect" });

    const token = jwt.sign(
      { id: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ token, user: { id: user.id, email: user.email, fullName: user.fullName } });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
