import pool from "../config/db.js";

export const getMissions = async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM "Offre"');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const createMission = async (req, res) => {
  try {
    const { title, description, etablissementId } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO "Offre" (title, description, etablissement_id) VALUES ($1, $2, $3) RETURNING *',
      [title, description, etablissementId]
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
