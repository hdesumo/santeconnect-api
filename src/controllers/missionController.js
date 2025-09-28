import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const createMission = async (req, res) => {
  try {
    const { title, description, specialityRequired, startDate, endDate } = req.body;

    const mission = await prisma.mission.create({
      data: {
        title,
        description,
        specialityRequired,
        startDate: new Date(startDate),
        endDate: new Date(endDate),
        etablissementId: req.user.id, // simplifié, à améliorer
      },
    });

    res.status(201).json(mission);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

export const getMissions = async (req, res) => {
  try {
    const missions = await prisma.mission.findMany();
    res.json(missions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
