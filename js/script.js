// Animation au défilement
document.addEventListener('DOMContentLoaded', function() {
    // Animation des éléments au scroll
    const animateOnScroll = function() {
        const elements = document.querySelectorAll('.card, .skill-item, .contact-info');
        
        elements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const windowHeight = window.innerHeight;
            
            if (elementTop < windowHeight - 100) {
                element.classList.add('fade-in-up');
            }
        });
    };

    // Initial animation
    animateOnScroll();
    
    // Animation on scroll
    window.addEventListener('scroll', animateOnScroll);

    // Gestion du formulaire de contact
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simulation d'envoi
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            
            submitBtn.textContent = 'Envoi en cours...';
            submitBtn.disabled = true;
            
            setTimeout(() => {
                alert('Message envoyé avec succès ! Je vous répondrai dans les plus brefs délais.');
                contactForm.reset();
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            }, 2000);
        });
    }

    // Smooth scroll pour les ancres
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});