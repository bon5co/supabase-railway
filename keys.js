// Derives the two legacy HS256 API keys Supabase clients use (anon + service_role)
// from the project's JWT secret, so a deployer never has to mint them by hand.
// Output is shell-evaluable: eval "$(node keys.js "$JWT_SECRET")"
const crypto = require('crypto');
const secret = process.argv[2];
if (!secret || secret.length < 32) {
  console.error('keys.js: JWT secret missing or shorter than 32 characters');
  process.exit(1);
}
const b64 = (o) => Buffer.from(JSON.stringify(o)).toString('base64url');
const sign = (role) => {
  const head = b64({ alg: 'HS256', typ: 'JWT' });
  const body = b64({ role, iss: 'supabase', iat: 1700000000, exp: 4102444800 });
  const sig = crypto.createHmac('sha256', secret).update(`${head}.${body}`).digest('base64url');
  return `${head}.${body}.${sig}`;
};
console.log(`export ANON_KEY=${sign('anon')}`);
console.log(`export SERVICE_ROLE_KEY=${sign('service_role')}`);
