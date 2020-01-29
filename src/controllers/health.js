import { Config } from "../lib/config";

const { latestVersion } = Config.general;

export class HealthController {
  healthCheck(req, res) {
    const version = req.headers["x-api-version"] || latestVersion;

    return res.json(`All good with v${version}`);
  }
}
