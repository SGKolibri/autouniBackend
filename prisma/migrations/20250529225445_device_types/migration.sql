-- CreateEnum
CREATE TYPE "DEVICETYPE" AS ENUM ('LIGHT', 'THERMOSTAT', 'SENSOR', 'SWITCH', 'CAMERA', 'PLUG', 'PRINTER', 'FAN', 'OUTLET', 'OTHER');

-- AlterTable
ALTER TABLE "Device" ADD COLUMN     "type" "DEVICETYPE" NOT NULL DEFAULT 'OTHER';
