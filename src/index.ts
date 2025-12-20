import ExpoDynamicAppIconModule from "./ExpoDynamicAppIconModule";

export function setAppIcon(name: string | null | undefined): string | false {
  return ExpoDynamicAppIconModule.setAppIcon(name);
}

export function getAppIcon(): string {
  return ExpoDynamicAppIconModule.getAppIcon();
}
