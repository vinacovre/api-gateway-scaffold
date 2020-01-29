import express from "express";
import routes from "./routes";
import { httpError, apiVersion } from "./lib/middlewares";

export class App {
  static start() {
    return express()
      .use(express.json())
      .use(express.urlencoded({ extended: false }))
      .use(apiVersion)
      .use("/", routes)
      .use(httpError);
  }
}
