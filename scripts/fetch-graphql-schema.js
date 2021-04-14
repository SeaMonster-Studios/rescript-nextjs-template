let fs = require('fs');
let dotenv = require("dotenv");

console.log("Dotenv loading .env");
dotenv.config()

let envPath = process.env.NODE_ENV == "production" ? ".env.production" : ".env.development";
console.log(`Dotenv loading ${envPath}`)
dotenv.config({ path: envPath });

let localEnvPath = ".env.local";

try {
  if (fs.existsSync(localEnvPath)) {
    console.log(`Dotenv loading ${localEnvPath}`)
    dotenv.config(localEnvPath)
  } else {
    console.log(`${localEnvPath} not found. Ignoring.`)
  }
} catch (err) {
  console.error(err)
}

let { execSync } = require('child_process');
let graphqlApiUrl = process.env.NEXT_PUBLIC_API_ENDPOINT

console.log(`Fetching graphql schema from ${graphqlApiUrl}`)

execSync(`npx get-graphql-schema --json --header 'Authorization=Bearer ${process.env.NEXT_PUBLIC_API_ACCESS_TOKEN}' ${graphqlApiUrl} > ./graphql_schema.json`);

