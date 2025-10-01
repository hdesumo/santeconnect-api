// check-env.js
import dotenv from "dotenv";
import pkg from "pg";

dotenv.config();

const { Pool } = pkg;

// Vérifie que la variable est bien lue
console.log("DEBUG DATABASE_URL =", process.env.DATABASE_URL);

if (!process.env.DATABASE_URL) {
  console.error("❌ DATABASE_URL est undefined. Vérifie ton .env");
  process.exit(1);
}

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
});

async function testDB() {
  try {
    const result = await pool.query("SELECT NOW()");
    console.log("✅ Connexion DB réussie:", result.rows[0]);
  } catch (err) {
    console.error("❌ Erreur connexion DB:", err.message);
  } finally {
    await pool.end();
  }
}

testDB();
