import { Config } from "../lib/config";
import { App } from "../app";

const { port } = Config.general;

App.start()
  .listen(port, () => console.info(`Listening on port ${port}...`));
