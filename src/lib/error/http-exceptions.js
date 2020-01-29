import { HttpError } from "./http-error";

export class HttpExceptions {
  static exceptions() {
    return {
      BAD_REQUEST: new HttpError({ statusCode: 400 }),
      NOT_FOUND: new HttpError({ statusCode: 404 }),
      UNPROCESSABLE_ENTITY: new HttpError({ statusCode: 422 }),
      INTERNAL_SERVER_ERROR: new HttpError({ statusCode: 500 }),
    };
  }
}
