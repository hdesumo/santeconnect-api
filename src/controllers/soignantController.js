import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// Liste tous les soignants
export const getSoignants = async (req, res) => {
  try {
    const soignants = await prisma.soignant.findMany({
      include: { user: true },
    });
    res.json(soignants);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Récupère un soignant par ID
export const getSoignantById = async (req, res) => {
  try {
    const soignant = await prisma.soignant.findUnique({
      where: { id: parseInt(req.params.id) },
      include: { user: true },
    });
    if (!soignant) return res.status(404).json({ message: "Soignant non trouvé" });
    res.json(soignant);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
