const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccount.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function backfill() {
  const snapshot = await db.collection("lists").get();
  console.log(`Found ${snapshot.docs.length} documents`);

  for (const doc of snapshot.docs) {
    await doc.ref.update({ _backfill: true });
    console.log(`Triggered: ${doc.id}`);
  }
  console.log("Done!");
}

backfill();