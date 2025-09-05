// Ideally don't hardcode ports

const MICROSERVICES = {
  MS1: { url: "http://ms1:8000", allowedEndpoints: ["hello", "call-ms2"] },
  MS2: { url: "http://ms2:8001", allowedEndpoints: ["hello", "call-ms1"] },
};

export async function hitMicroservice(ms: "MS1" | "MS2", endpoint: string) {
  const service = MICROSERVICES[ms];
  if (!service.allowedEndpoints.includes(endpoint)) {
    return "Endpoint doesn't exist, check caller";
  }

  try {
    const rsp = await fetch(`${service.url}/${endpoint}`);
    const data = await rsp.json();
    return JSON.stringify(data);
  } catch (error) {
    return `Error: ${error}`
  }
}