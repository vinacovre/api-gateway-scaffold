import { Router } from "express";
import { HealthController } from "../../controllers";

const healthController = new HealthController();

export default Router()
  .get("/", (req, res) => {
    console.info("[route] GET /health on v2");

    healthController.healthCheck(req, res);
  });
