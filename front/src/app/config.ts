// Configuration API - détecte automatiquement l'environnement
const isProduction = window.location.hostname !== 'localhost';
export const API_BASE_URL = isProduction ? "" : "http://localhost:8080";