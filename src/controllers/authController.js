import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const prisma = new PrismaClient();

/**
 * Inscription d’un nouvel utilisateur
 */
export const register = async (req, res) => {
  try {
    const { full_name, email, password, role, phone } = req.body;

    // Vérifier si l’email existe déjà
    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ error: "Email déjà utilisé" });
    }

    // Hachage du mot de passe
    const hashedPassword = await bcrypt.hash(password, 10);

    // Création de l’utilisateur
    const newUser = await prisma.user.create({
      data: {
        full_name,
        email,
        phone,
        password_hash: hashedPassword,
        role: role || "soignant",
      },
    });

    // Génération du token
    const token = jwt.sign(
      { id: newUser.id, role: newUser.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.status(201).json({ token, user: { id: newUser.id, email: newUser.email, role: newUser.role } });
  } catch (error) {
    console.error("Erreur register:", error);
    res.status(500).json({ error: "Erreur serveur" });
  }
};

/**
 * Connexion d’un utilisateur existant
 */
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Vérifier l’existence de l’utilisateur
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return res.status(401).json({ error: "Utilisateur non trouvé" });
    }

    // Vérifier le mot de passe
    const isPasswordValid = await bcrypt.compare(password, user.password_hash);
    if (!isPasswordValid) {
      return res.status(401).json({ error: "Mot de passe incorrect" });
    }

    // Générer un JWT
    const token = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ token, user: { id: user.id, email: user.email, role: user.role } });
  } catch (error) {
    console.error("Erreur login:", error);
    res.status(500).json({ error: "Erreur serveur" });
  }
};
