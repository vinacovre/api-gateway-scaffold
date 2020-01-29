import getEnv from "getenv";
import { config as dotenvConfig } from "dotenv";

dotenvConfig();

export class Config {
  static get general() {
    return {
      env: getEnv.string("ENVIRONMENT", "test"),
      port: getEnv.int("PORT", 3000),
      latestVersion: getEnv.int("LATEST_VERSION", 2),
    };
  }

  static get aws() {
    return {
      key: getEnv.string("AWS_KEY"),
      secret: getEnv.string("AWS_SECRET"),
      region: getEnv.string("AWS_REGION"),
    };
  }
}
