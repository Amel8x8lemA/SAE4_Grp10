import express from 'express';
const router = express.Router();
import { pool, sendEmail, forgotten_passcodes } from '../../server.js';

router.post('', async (req, res) => {
  const { email } = req.body;

  // Si un utilisateur est connecté, vérifiez si l'email entré est celui de la session en cours
  if (req.session.isLoggedIn && !(req.session.email === email)) {
    // L'utilisateur est connecté et l'email entré n'est pas celui de la session en cours
    res.status(408).json({ error: "L'adresse email entrée n'est pas la même" });
    return;
  }

  // Vérifiez si l'email existe déjà dans la base de données
  const [exists] = await pool.query('SELECT * FROM user WHERE email = ?', [email]);

  if (exists.length === 0) {
    // L'email n'existe pas dans la base de données
    res.status(409).json({ error: 'Email non utilisée' });
    return;
  }

  // L'email existe dans la base de données, envoyez le code de vérification
  console.log('Sending forgotten password passcode email to ' + email + '...');
  const passcode = Math.floor(Math.random() * 1000000);

  // Ajouter le code de vérification à l'objet forgotten_passcodes
  forgotten_passcodes[email] = passcode;

  // Stockez l'email dans la session
  req.session.email = email;

  // Envoyer l'email avec le code de vérification
  await sendEmail(
    email,
    "Vérification de réinitialisation de votre mot de passe de l'ADIIL",
    passcode,
    'réinitialisation de mot de passe'
  );

  res.status(200).json({ success: true });
});

export default router;