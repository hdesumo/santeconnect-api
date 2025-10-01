import pool from "../config/db.js";

export const getCandidatures = async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM "Candidature"');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const applyToOffre = async (req, res) => {
  try {
    const { soignantId, offreId } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO "Candidature" (soignant_id, offre_id) VALUES ($1, $2) RETURNING *',
      [soignantId, offreId]
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
