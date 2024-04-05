import express from 'express';
const router = express.Router();
import {pool} from '../../server.js';

router.post('', async (req, res) => {
    const { id } = req.body;

    if (!req.session.isLoggedIn || req.session.category !== 'admin') {
      res.status(403).json({error: 'Accès refusé'});
      return;
    }

    //update transactioncontent
    await pool.query(
      'UPDATE transactionContent SET product_id = 0 WHERE product_id=?',
      [id],
      (err) => {
        if (err) {
          console.error('Impossible de mettre à jour le contenu de la transaction :', err);
          res.status(500).json({error: 'Impossible de mettre à jour le contenu de la transaction'});
          return;
        }
      }
    );

    //delete productsize
    await pool.query(
      'DELETE FROM product_size WHERE product_id=?',
      [id],
      (err) => {
        if (err) {
          console.error('Impossible de supprimer la taille du produit :', err);
          res.status(500).json({error: 'Impossible de supprimer la taille du produit'});
          return;
        }
      }
    );

    //delete productcolor
    await pool.query(
      'DELETE FROM product_color WHERE product_id=?',
      [id],
      (err) => {
        if (err) {
          console.error('Impossible de supprimer la couleur du produit :', err);
          res.status(500).json({error: 'Impossible de supprimer la couleur du produit'});
          return;
        }
      }
    );

    //delete product
    await pool.query(
      'DELETE FROM product WHERE id=?',
      [id],
      (err) => {
        if (err) {
          console.error('Impossible de supprimer le produit :', err);
          res.status(500).json({error: 'Impossible de supprimer le produit'});
          return;
        }
      }
    );

    res.status(200).json({success: true});
  });

  export default router;