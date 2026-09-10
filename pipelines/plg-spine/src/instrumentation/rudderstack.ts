import RudderAnalytics from "@rudderstack/rudder-sdk-node";

export type RudderStackConfig = Readonly<{
  writeKey: string;
  dataPlaneUrl: string;
}>;

export type EASBuildSucceededInput = Readonly<{
  userId: string;
  email: string;
  orgId: string;
  projectId: string;
  platform: "ios" | "android";
  isFirstSuccess: boolean;
}>;

type IdentifyMessage = Readonly<{ userId: string; traits: Record<string, string> }>;
type TrackMessage = Readonly<{
  userId: string;
  event: "EAS Build Succeeded";
  properties: Readonly<{ orgId: string; projectId: string; platform: "ios" | "android"; isFirstSuccess: boolean }>;
}>;

export type RudderStackClient = Readonly<{
  identify(message: IdentifyMessage): unknown;
  track(message: TrackMessage): unknown;
  flush(callback: (error?: Error) => void): unknown;
}>;

function required(value: string | undefined, name: string): string {
  if (!value?.trim()) throw new Error(`${name} must be set.`);
  return value.trim();
}

export function rudderStackConfigFromEnv(env: NodeJS.ProcessEnv = process.env): RudderStackConfig {
  const dataPlaneUrl = required(env.DATA_PLANE_URL, "DATA_PLANE_URL").replace(/\/$/, "");
  const parsed = new URL(dataPlaneUrl);
  if (parsed.protocol !== "https:") throw new Error("DATA_PLANE_URL must use HTTPS.");
  return { writeKey: required(env.WRITE_KEY, "WRITE_KEY"), dataPlaneUrl };
}

export function createRudderStackClient(config: RudderStackConfig): RudderStackClient {
  return new RudderAnalytics(config.writeKey, { dataPlaneUrl: config.dataPlaneUrl });
}

function flush(client: RudderStackClient): Promise<void> {
  return new Promise((resolve, reject) => {
    client.flush((error) => (error ? reject(error) : resolve()));
  });
}

/** Emits the person and product action through the official RudderStack Node SDK. */
export async function sendEASBuildSucceeded(
  client: RudderStackClient,
  input: EASBuildSucceededInput,
): Promise<void> {
  client.identify({
    userId: input.userId,
    traits: { email: input.email, orgId: input.orgId, plan: "free" },
  });
  client.track({
    userId: input.userId,
    event: "EAS Build Succeeded",
    properties: {
      orgId: input.orgId,
      projectId: input.projectId,
      platform: input.platform,
      isFirstSuccess: input.isFirstSuccess,
    },
  });
  await flush(client);
}
