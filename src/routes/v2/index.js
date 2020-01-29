import { Router } from "express";
import health from "./health";

export default Router()
  .use("/health", health);
