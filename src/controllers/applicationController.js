import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const applyToMission = async (req, res) => {
  try {
    const { id } = req.params;

    const application = await prisma.application.create({
      data: {
        missionId: parseInt(id),
        soignantId: req.user.id, // simplifié, à améliorer
      },
    });

    res.status(201).json(application);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
