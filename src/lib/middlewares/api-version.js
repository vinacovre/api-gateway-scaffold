import { Config } from "../config";
import { HttpExceptions } from "../error";

const { NOT_FOUND } = HttpExceptions.exceptions();
const { latestVersion } = Config.general;

export const apiVersion = (req, res, next) => {
  console.debug("[middleware] Building URL according to version header");

  let versionHeader = req.headers["x-api-version"];

  if (typeof versionHeader === "undefined") {
    console.info("[middleware] Did not receive API version header");
    console.info(`[middleware] Considering latest version: ${latestVersion}`);
    versionHeader = latestVersion;
  }

  const versionNumber = Number(versionHeader);

  if (versionNumber > 0 && versionNumber <= latestVersion) {
    console.info(`[middleware] API version: ${versionNumber}`);
    req.url = `/v${versionNumber}${req.url}`;
    return next();
  }

  console.error(`[middleware] Invalid API version header: ${versionHeader}`);
  return next(NOT_FOUND);
};
