import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// Liste tous les établissements
export const getEtablissements = async (req, res) => {
  try {
    const etablissements = await prisma.etablissement.findMany({
      include: { user: true, missions: true },
    });
    res.json(etablissements);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Récupère un établissement par ID
export const getEtablissementById = async (req, res) => {
  try {
    const etablissement = await prisma.etablissement.findUnique({
      where: { id: parseInt(req.params.id) },
      include: { user: true, missions: true },
    });
    if (!etablissement) return res.status(404).json({ message: "Etablissement non trouvé" });
    res.json(etablissement);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
