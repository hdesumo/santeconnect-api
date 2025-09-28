import express from "express";
import dotenv from "dotenv";
import cors from "cors";

import authRoutes from "./routes/authRoutes.js";
import missionRoutes from "./routes/missionRoutes.js";
import applicationRoutes from "./routes/applicationRoutes.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);
app.use("/api/missions", missionRoutes);
app.use("/api/applications", applicationRoutes);

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`✅ API running on port ${PORT}`));
