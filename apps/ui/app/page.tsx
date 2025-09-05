"use client";

import { hitMicroservice } from "@/functions/microservices";
import { useState } from "react";
import styles from "./page.module.css";

const MICROSERVICES = {
  MS1: ["hello", "call-ms2"],
  MS2: ["hello", "call-ms1"],
};

export default function Home() {
  const [selectedMS, setSelectedMS] = useState<"MS1" | "MS2">("MS1");
  const [selectedEndpoint, setSelectedEndpoint] = useState("hello");
  const [response, setResponse] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleClick = async () => {
    setIsLoading(true);
    console.log(selectedMS, selectedEndpoint);
    const result = await hitMicroservice(selectedMS, selectedEndpoint);
    setIsLoading(false);
    setResponse(result);
  };

  return (
    <main className={styles.main}>
      <h1 className={styles.headText}>Istio Mesh Response Visualizer</h1>
      <div className={styles.mainContainer}>
        <div className={styles.outputContainer}>
          <p>{isLoading ? "Loading..." : response}</p>
        </div>
        <div className={styles.selectorContainer}>
          <select
            value={selectedMS}
            onChange={(e) => {
              const ms = e.target.value as "MS1" | "MS2";
              setSelectedMS(ms);
              setSelectedEndpoint(MICROSERVICES[ms][0]);
            }}
          >
            {Object.keys(MICROSERVICES).map((ms) => (
              <option key={ms} value={ms}>
                {ms}
              </option>
            ))}
          </select>

          <select
            className={styles.select}
            value={selectedEndpoint}
            onChange={(e) => setSelectedEndpoint(e.target.value)}
          >
            {MICROSERVICES[selectedMS].map((endpoint) => (
              <option key={endpoint} value={endpoint}>
                {endpoint}
              </option>
            ))}
          </select>

          <button
            className={styles.button}
            onClick={handleClick}
            disabled={isLoading}
          >
            Hit
          </button>
        </div>
      </div>
    </main>
  );
}
