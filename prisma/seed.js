import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcrypt'

const prisma = new PrismaClient()

async function main() {
  const password = "admin123"
  const hashedPassword = await bcrypt.hash(password, 10)

  await prisma.user.upsert({
    where: { email: "admin@santeconnect.live" },
    update: {},
    create: {
      full_name: "Admin SantéConnect",
      email: "admin@santeconnect.live",
      password_hash: hashedPassword,
      role: "admin",
    },
  })

  console.log("✅ Admin seed inséré avec succès !")
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })
