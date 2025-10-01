import pool from "../config/db.js";

export const getTransactions = async (req, res) => {
  try {
    const userId = req.user?.id;
    const { rows } = await pool.query('SELECT * FROM "Transaction" WHERE user_id=$1', [userId]);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const createTransaction = async (req, res) => {
  try {
    const { userId, montant, type, status } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO "Transaction" (user_id, montant, type, status) VALUES ($1, $2, $3, $4) RETURNING *',
      [userId, montant, type, status]
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
