// ==================== Navigation Active Link ====================
document.addEventListener('DOMContentLoaded', function() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-links a');
    
    navLinks.forEach(link => {
        const linkHref = link.getAttribute('href');
        
        // Ne pas appliquer 'active' au bouton CV (qui a download attribute)
        if (link.hasAttribute('download')) {
            return;
        }
        
        // Pour les pages principales
        if (linkHref === currentPage) {
            link.classList.add('active');
        }
        
        // Gestion spéciale pour la page d'accueil
        if (currentPage === 'index.html' && linkHref === 'index.html') {
            link.classList.add('active');
        }
    });
});
