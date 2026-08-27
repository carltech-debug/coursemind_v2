import {onRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

export const helloCourseMind = onRequest((request, response) => {
  logger.info("CourseMind Functions is running.", {
    structuredData: true,
  });

  response.send("CourseMind backend is running.");
});
