import pool from "../config/db.js";

export const getArticles = async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM "Article"');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getArticleById = async (req, res) => {
  try {
    const { id } = req.params;
    const { rows } = await pool.query('SELECT * FROM "Article" WHERE id=$1', [id]);
    if (rows.length === 0) return res.status(404).json({ error: "Article non trouvé" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const createArticle = async (req, res) => {
  try {
    const { title, content, authorId } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO "Article" (title, content, "authorId") VALUES ($1, $2, $3) RETURNING *',
      [title, content, authorId]
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
