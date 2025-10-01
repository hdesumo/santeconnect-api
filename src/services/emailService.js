// src/services/emailService.js
import { Resend } from "resend";
import pool from "../config/db.js";
import crypto from "crypto";

const resend = new Resend(process.env.RESEND_API_KEY);

export const sendVerificationEmail = async (userId, email) => {
  const token = crypto.randomBytes(32).toString("hex");
  await pool.query(
    "INSERT INTO EmailVerificationToken (user_id, token, created_at) VALUES ($1, $2, NOW())",
    [userId, token]
  );

  const verificationUrl = `https://santeconnect.live/verify?token=${token}`;

  await resend.emails.send({
    from: process.env.EMAIL_FROM,
    to: email,
    subject: "Vérifiez votre adresse email",
    html: `
      <p>Bienvenue sur SantéConnect !</p>
      <p>Cliquez ici pour confirmer votre adresse email :</p>
      <a href="${verificationUrl}">${verificationUrl}</a>
    `,
  });
};
