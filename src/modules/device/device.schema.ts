import { z } from "zod";
import { buildJsonSchemas } from "fastify-zod";

export const deviceSchema = z.object({
  name: z.string(),
  status: z.string(),
});

// For connecting a device to a room
export const deviceRoomSchema = z.object({
  deviceId: z.string(),
  roomId: z.string(),
});

export type DeviceInput = z.infer<typeof deviceSchema>;
export type DeviceRoomInput = z.infer<typeof deviceRoomSchema>;

export const { schemas: deviceSchemas, $ref } = buildJsonSchemas(
  {
    deviceSchema,
    deviceRoomSchema,
  },
  {
    $id: "deviceSchema",
  }
);
