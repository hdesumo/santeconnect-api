import pool from "../config/db.js";

export const getEtablissements = async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM "Etablissement"');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getEtablissementById = async (req, res) => {
  try {
    const { id } = req.params;
    const { rows } = await pool.query('SELECT * FROM "Etablissement" WHERE id=$1', [id]);
    if (rows.length === 0) return res.status(404).json({ error: "Établissement non trouvé" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const createEtablissement = async (req, res) => {
  try {
    const { name, address } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO "Etablissement" (name, address) VALUES ($1, $2) RETURNING *',
      [name, address]
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
