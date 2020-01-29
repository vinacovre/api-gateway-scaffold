import { STATUS_CODES } from "http";

export class HttpError extends Error {
  constructor({ statusCode = 500 } = {}) {
    super(STATUS_CODES[statusCode]);
    this.statusCode = statusCode;
  }
}
