// src/db.js
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // ton URL Railway
  ssl: { rejectUnauthorized: false }, // utile avec Railway/Heroku
});

module.exports = pool;
