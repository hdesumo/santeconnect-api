import jwt from "jsonwebtoken";

export function authMiddleware(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res.status(401).json({ error: "Accès refusé. Token manquant" });
  }

  try {
    console.log("🔑 Token reçu:", token.substring(0, 30) + "..."); 
    console.log("🔐 JWT_SECRET utilisé:", process.env.JWT_SECRET);

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log("✅ Décodé:", decoded);

    req.user = decoded;
    next();
  } catch (err) {
    console.error("❌ Erreur validation token:", err.message);
    return res.status(403).json({ error: "Token invalide ou expiré", details: err.message });
  }
}
