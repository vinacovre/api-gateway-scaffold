/* eslint-disable no-unused-vars */

export const httpError = (error, req, res, next) => {
  const status = error.statusCode || 500;
  console.error(`[middleware] HTTP error: ${status} ${error.message}`);

  return res.sendStatus(status);
};
