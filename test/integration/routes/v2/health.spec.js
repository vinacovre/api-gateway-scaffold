import request from "supertest";
import { strict as assert } from "assert";
import { App } from "../../../../src/app";

describe("GET /health on v2", () => {
  describe("Successful scenario", () => {
    context("with valid API version", () => {
      it("should respond 200", async () => {
        const res = await request(App.start())
          .get("/health")
          .set("x-api-version", 2);

        assert.strictEqual(res.statusCode, 200);
        assert.strictEqual(res.ok, true);
        assert.equal(res.body, "All good with v2");
      });
    });
  });

  describe("Failure scenario", () => {
    context("with invalid API version", () => {
      it("should respond 404", async () => {
        const res = await request(App.start())
          .get("/health")
          .set("x-api-version", "INVALID API VERSION");

        assert.strictEqual(res.statusCode, 404);
        assert.strictEqual(res.ok, false);
      });
    });
  });
});
