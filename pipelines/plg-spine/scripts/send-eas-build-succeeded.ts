import { createRudderStackClient, rudderStackConfigFromEnv, sendEASBuildSucceeded } from "../src/instrumentation/rudderstack.js";

const required = (name: string): string => {
  const value = process.env[name]?.trim();
  if (!value) throw new Error(`${name} must be set.`);
  return value;
};

const platform = required("EAS_BUILD_PLATFORM");
if (platform !== "ios" && platform !== "android") {
  throw new Error("EAS_BUILD_PLATFORM must be ios or android.");
}
if (process.env.EAS_BUILD_IS_FIRST_SUCCESS !== "true") {
  throw new Error("This guard only sends a first success; set EAS_BUILD_IS_FIRST_SUCCESS=true.");
}

const client = createRudderStackClient(rudderStackConfigFromEnv());
await sendEASBuildSucceeded(client, {
  userId: required("EAS_BUILD_USER_ID"),
  email: required("EAS_BUILD_USER_EMAIL"),
  orgId: required("EAS_BUILD_ORG_ID"),
  projectId: required("EAS_BUILD_PROJECT_ID"),
  platform,
  isFirstSuccess: true,
});

console.log("Flushed to RudderStack: identify + EAS Build Succeeded track.");
