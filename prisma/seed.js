import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

async function main() {
  // --- Admin ---
  const adminPassword = await bcrypt.hash("admin123", 10);
  const admin = await prisma.user.create({
    data: {
      full_name: "Admin SantéConnect",
      email: "admin@santeconnect.live",
      passwordHash: adminPassword,
      role: "admin",
    },
  });

  // --- Établissement ---
  const etabPassword = await bcrypt.hash("etab123", 10);
  const etabUser = await prisma.user.create({
    data: {
      full_name: "Clinique Saint-Michel",
      email: "contact@clinique-saintmichel.fr",
      passwordHash: etabPassword,
      role: "etablissement",
      Etablissement: {
        create: {
          name: "Clinique Saint-Michel",
          address: "12 Rue de la Santé",
          city: "Nantes",
          postalCode: "44000",
          type: "Clinique",
          description: "Établissement privé pluridisciplinaire.",
        },
      },
    },
    include: { Etablissement: true },
  });

  // --- Soignant ---
  const soignantPassword = await bcrypt.hash("soignant123", 10);
  const soignantUser = await prisma.user.create({
    data: {
      full_name: "Jean Dupont",
      email: "jean.dupont@example.com",
      passwordHash: soignantPassword,
      role: "soignant",
      Soignant: {
        create: {
          speciality: "Infirmier",
          diploma: "Diplôme d'État Infirmier",
          experienceYears: 5,
          location: "Rennes",
          bio: "Infirmier avec 5 ans d’expérience en soins intensifs.",
          verified: true,
        },
      },
    },
    include: { Soignant: true },
  });

  // --- Mission ---
  await prisma.mission.create({
    data: {
      etablissementId: etabUser.Etablissement.id,
      title: "Remplacement infirmier de nuit",
      description: "Besoin urgent d’un infirmier pour 3 nuits en service réanimation.",
      specialityRequired: "Infirmier",
      startDate: new Date("2025-10-01"),
      endDate: new Date("2025-10-03"),
    },
  });

  console.log("✅ Seed exécuté avec succès !");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
