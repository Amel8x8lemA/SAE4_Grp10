function confirmDelete(productId) {
    if (confirm("Êtes-vous sûr de vouloir supprimer ce produit ?")) {
      deleteProduct(productId);
    }
  }
  
  async function deleteProduct(productId) {
    try {
      const response = await fetch(`/api/products/${productId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        }
      });
  
      const data = await response.json();
      if (response.ok) {
        // Le produit a été supprimé avec succès
        alert(data.message);
        // Recharger la page ou effectuer d'autres actions nécessaires
      } else {
        // Il y a eu une erreur lors de la suppression du produit
        alert(data.message);
      }
    } catch (error) {
      // Gérer les erreurs
      console.error('Erreur lors de la suppression du produit :', error);
      alert('Une erreur est survenue lors de la suppression du produit');
    }
  }
  