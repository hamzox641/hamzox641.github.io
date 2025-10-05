// ==================== Navigation Active Link ====================
document.addEventListener('DOMContentLoaded', function() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-links a');
    
    navLinks.forEach(link => {
        const linkHref = link.getAttribute('href');
        
        // Ignorer complètement le bouton CV
        if (link.classList.contains('btn-primary') || link.hasAttribute('download')) {
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

// ==================== Smooth Scroll ====================
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

// ==================== Scroll Animations ====================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe all cards
document.addEventListener('DOMContentLoaded', () => {
    const cards = document.querySelectorAll('.card, .project-card');
    cards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
});

// ==================== Form Validation (Contact Page) ====================
const contactForm = document.getElementById('contactForm');
if (contactForm) {
    contactForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const name = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const subject = document.getElementById('subject').value.trim() || 'Contact depuis le portfolio';
        const message = document.getElementById('message').value.trim();

        if (!name || !email || !message) {
            alert('Veuillez remplir tous les champs obligatoires');
            return;
        }

        if (!isValidEmail(email)) {
            alert('Veuillez entrer une adresse email valide');
            return;
        }

        // Désactiver le bouton pendant l'envoi
        const submitBtn = contactForm.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Envoi en cours...';
        submitBtn.disabled = true;

        // Essayer d'ouvrir le client mail
        const mailtoLink = `mailto:hamzanadif73@gmail.com?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(`Nom: ${name}\nEmail: ${email}\n\nMessage:\n${message}`)}`;
        
        // Vérifier si on est sur mobile
        const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
        
        if (!isMobile) {
            // Sur desktop, utiliser mailto directement
            try {
                window.location.href = mailtoLink;
                setTimeout(() => {
                    contactForm.reset();
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    alert('✅ Client email ouvert ! Votre message est prêt à être envoyé.');
                }, 1000);
            } catch (err) {
                fallbackToAlert(name, email, subject, message, submitBtn, originalText);
            }
        } else {
            // Sur mobile, utiliser la méthode alert
            fallbackToAlert(name, email, subject, message, submitBtn, originalText);
        }
    });
}

function fallbackToAlert(name, email, subject, message, submitBtn, originalText) {
    alert(`✅ Message prêt à être envoyé !\n\nNom: ${name}\nEmail: ${email}\nSujet: ${subject}\n\nMessage: ${message}\n\nJe vous répondrai dans les plus brefs délais.`);
    contactForm.reset();
    submitBtn.innerHTML = originalText;
    submitBtn.disabled = false;
}

function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// ==================== Typing Effect for Hero ====================
function typeEffect(element, text, speed = 100) {
    let i = 0;
    element.textContent = '';
    
    const type = () => {
        if (i < text.length) {
            element.textContent += text.charAt(i);
            i++;
            setTimeout(type, speed);
        }
    };
    
    type();
}

// Apply typing effect on hero subtitle if exists
document.addEventListener('DOMContentLoaded', () => {
    const heroSubtitle = document.querySelector('.hero-content h2');
    if (heroSubtitle && heroSubtitle.textContent.trim() !== '') {
        const originalText = heroSubtitle.textContent;
        heroSubtitle.textContent = '';
        setTimeout(() => {
            typeEffect(heroSubtitle, originalText, 80);
        }, 500);
    }
});

// ==================== Mobile Menu Toggle ====================
const createMobileMenu = () => {
    const navLinks = document.querySelector('.nav-links');
    
    if (window.innerWidth <= 768 && !document.querySelector('.menu-toggle')) {
        // Créer le bouton menu
        const menuToggle = document.createElement('button');
        menuToggle.className = 'menu-toggle';
        menuToggle.innerHTML = '☰';
        menuToggle.style.cssText = `
            background: none;
            border: none;
            color: var(--text);
            font-size: 1.5rem;
            cursor: pointer;
            display: block;
            padding: 0.5rem;
        `;
        
        // Ajouter au conteneur de navigation
        const navContainer = document.querySelector('.nav-container');
        navContainer.appendChild(menuToggle);
        
        // Style initial du menu mobile
        navLinks.style.cssText = `
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background: rgba(15, 23, 42, 0.98);
            backdrop-filter: blur(10px);
            flex-direction: column;
            padding: 1rem;
            gap: 0.5rem;
            display: none;
            border-top: 1px solid var(--border);
            z-index: 1000;
        `;
        
        // Gestion du clic
        menuToggle.addEventListener('click', () => {
            const isActive = navLinks.style.display === 'flex';
            navLinks.style.display = isActive ? 'none' : 'flex';
            menuToggle.innerHTML = isActive ? '☰' : '✕';
        });
        
        // Fermer le menu en cliquant sur un lien
        navLinks.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                if (window.innerWidth <= 768) {
                    navLinks.style.display = 'none';
                    menuToggle.innerHTML = '☰';
                }
            });
        });
    }
};

// Handle mobile menu on resize
window.addEventListener('resize', () => {
    const navLinks = document.querySelector('.nav-links');
    const menuToggle = document.querySelector('.menu-toggle');
    
    if (window.innerWidth > 768) {
        // Desktop - reset styles
        navLinks.style.cssText = '';
        if (menuToggle) {
            menuToggle.remove();
        }
    } else {
        // Mobile - create menu if not exists
        if (!menuToggle) {
            createMobileMenu();
        }
    }
});

// Initialize mobile menu if needed
if (window.innerWidth <= 768) {
    createMobileMenu();
}

// ==================== Project Filters (Projects Page) ====================
const projectFilters = document.querySelectorAll('.project-filter');
if (projectFilters.length > 0) {
    projectFilters.forEach(filter => {
        filter.addEventListener('click', () => {
            const category = filter.dataset.category;
            
            // Update active filter
            projectFilters.forEach(f => f.classList.remove('active'));
            filter.classList.add('active');
            
            // Filter projects
            const projects = document.querySelectorAll('.project-card');
            projects.forEach(project => {
                if (category === 'all' || project.dataset.category === category) {
                    project.style.display = 'block';
                    setTimeout(() => {
                        project.style.opacity = '1';
                        project.style.transform = 'translateY(0)';
                    }, 10);
                } else {
                    project.style.opacity = '0';
                    project.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        project.style.display = 'none';
                    }, 300);
                }
            });
        });
    });
}

// ==================== Copy Email to Clipboard ====================
const emailLinks = document.querySelectorAll('[data-copy-email]');
emailLinks.forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        const email = link.textContent;
        navigator.clipboard.writeText(email).then(() => {
            const originalText = link.textContent;
            link.textContent = 'Email copié!';
            setTimeout(() => {
                link.textContent = originalText;
            }, 2000);
        }).catch(() => {
            alert('Impossible de copier l\'email. Veuillez le copier manuellement: ' + email);
        });
    });
});

// ==================== Gallery Image Scroll Smooth ====================
document.addEventListener('DOMContentLoaded', () => {
    const galleries = document.querySelectorAll('.gallery-images-scroll');
    
    galleries.forEach(gallery => {
        let isDown = false;
        let startX;
        let scrollLeft;

        gallery.addEventListener('mousedown', (e) => {
            isDown = true;
            gallery.style.cursor = 'grabbing';
            startX = e.pageX - gallery.offsetLeft;
            scrollLeft = gallery.scrollLeft;
        });

        gallery.addEventListener('mouseleave', () => {
            isDown = false;
            gallery.style.cursor = 'grab';
        });

        gallery.addEventListener('mouseup', () => {
            isDown = false;
            gallery.style.cursor = 'grab';
        });

        gallery.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - gallery.offsetLeft;
            const walk = (x - startX) * 2;
            gallery.scrollLeft = scrollLeft - walk;
        });

        // Support tactile pour mobile
        gallery.addEventListener('touchstart', (e) => {
            isDown = true;
            startX = e.touches[0].pageX - gallery.offsetLeft;
            scrollLeft = gallery.scrollLeft;
        });

        gallery.addEventListener('touchend', () => {
            isDown = false;
        });

        gallery.addEventListener('touchmove', (e) => {
            if (!isDown) return;
            const x = e.touches[0].pageX - gallery.offsetLeft;
            const walk = (x - startX) * 2;
            gallery.scrollLeft = scrollLeft - walk;
        });
    });
});

// ==================== Stats Counter Animation ====================
function animateCounter(element, target, duration = 2000) {
    let start = 0;
    const increment = target / (duration / 16);
    
    const timer = setInterval(() => {
        start += increment;
        if (start >= target) {
            element.textContent = target;
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(start);
        }
    }, 16);
}

// Animate counters when they come into view
const counters = document.querySelectorAll('[data-count]');
if (counters.length > 0) {
    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !entry.target.classList.contains('counted')) {
                const target = parseInt(entry.target.dataset.count);
                animateCounter(entry.target, target);
                entry.target.classList.add('counted');
            }
        });
    }, { threshold: 0.5 });
    
    counters.forEach(counter => counterObserver.observe(counter));
}

// ==================== Page Load Animations ====================
document.addEventListener('DOMContentLoaded', () => {
    // Animation d'entrée pour le hero
    const heroContent = document.querySelector('.hero-content');
    if (heroContent) {
        heroContent.style.opacity = '0';
        heroContent.style.transform = 'translateY(30px)';
        heroContent.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
        
        setTimeout(() => {
            heroContent.style.opacity = '1';
            heroContent.style.transform = 'translateY(0)';
        }, 300);
    }
});
