import jwt from "jsonwebtoken";
import pool from "../config/db.js";

export const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  if (!token) return res.sendStatus(401);

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const { rows } = await pool.query("SELECT id, email FROM users WHERE id=$1", [decoded.id]);
    if (rows.length === 0) return res.sendStatus(403);

    req.user = rows[0];
    next();
  } catch (err) {
    return res.sendStatus(403);
  }
};
