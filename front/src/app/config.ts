// En dev Angular (ng serve sur :4200), on cible le backend local :8080.
// En image Docker/Caddy (port 80), on reste en meme origine et Caddy proxy vers le backend.
const isAngularDevServer = window.location.port === "4200";
export const API_BASE_URL = isAngularDevServer ? "http://localhost:8080" : "";