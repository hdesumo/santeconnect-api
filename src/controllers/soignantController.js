import pool from "../config/db.js";

export const getSoignants = async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM "Soignant"');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getSoignantById = async (req, res) => {
  try {
    const { id } = req.params;
    const { rows } = await pool.query('SELECT * FROM "Soignant" WHERE id=$1', [id]);
    if (rows.length === 0) return res.status(404).json({ error: "Soignant non trouvé" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
