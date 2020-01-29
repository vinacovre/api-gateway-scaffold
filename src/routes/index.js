import { Router } from "express";
import v1 from "./v1";
import v2 from "./v2";

export default Router()
  .use("/v1", v1)
  .use("/v2", v2);
