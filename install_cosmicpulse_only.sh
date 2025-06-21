#!/bin/bash

# Colori per l'output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Funzione per stampare messaggi
print_message() {
    echo -e "${GREEN}[CosmicPulse] $1${NC}"
}

# Funzione per gestire errori
handle_error() {
    echo -e "${RED}[Errore] $1${NC}"
    exit 1
}

print_message "Inizio della configurazione del tema CosmicPulse per Pterodactyl..."

# Verifica Pterodactyl
print_message "Verifica dell'installazione di Pterodactyl..."
if [ ! -d "/var/www/pterodactyl" ]; then
    handle_error "Pterodactyl non trovato in /var/www/pterodactyl. Installalo prima seguendo la guida su pterodactyl.io."
fi
cd /var/www/pterodactyl || handle_error "Impossibile accedere alla directory di Pterodactyl."
php artisan --version || handle_error "Pterodactyl non sembra essere installato correttamente."

# Crea l'estensione CosmicPulse
print_message "Creazione dell'estensione CosmicPulse..."
blueprint -create CosmicPulse || handle_error "Impossibile creare l'estensione CosmicPulse."

# Configura extension.yml
print_message "Configurazione del file extension.yml..."
cat > /var/www/pterodactyl/blueprint/extensions/CosmicPulse/extension.yml << 'EOL'
name: CosmicPulse
version: 1.0.0
description: A futuristic Pterodactyl theme with animations and intergalactic design.
author: TuoNome
website: https://tuo-sito.com
enabled: true
assets:
  css:
    - assets/styles.css
  js:
    - assets/intro.js
    - assets/server.js
  html:
    - assets/intro.html
EOL

# Crea la directory assets
print_message "Creazione della directory assets..."
mkdir -p /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets || handle_error "Impossibile creare la directory assets."

# Aggiungi il file CSS
print_message "Aggiunta del file CSS..."
cat > /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets/styles.css << 'EOL'
body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background: #1C2526;
    color: #D3D3D3;
    overflow-x: hidden;
}

.card, .panel, .box {
    background: #4A4A4A;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    overflow: hidden;
}

.card:hover, .panel:hover, .box:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(255, 255, 255, 0.1);
}

button, .btn {
    background: linear-gradient(45deg, #4A4A4A, #1C2526);
    border: none;
    padding: 10px 20px;
    color: #FFFFFF;
    border-radius: 10px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: all 0.4s ease;
}

button::after, .btn::after {
    content: '';
    position: absolute;
    width: 0;
    height: 100%;
    background: rgba(255, 255, 255, 0.2);
    top: 0;
    left: -100%;
    transition: all 0.4s ease;
}

button:hover::after, .btn:hover::after {
    width: 100%;
    left: 0;
}

button:hover, .btn:hover {
    transform: scale(1.05);
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
}

@keyframes fadeInUp {
    0% { opacity: 0; transform: translateY(20px); }
    100% { opacity: 1; transform: translateY(0); }
}

@keyframes pulseGlow {
    0% { box-shadow: 0 0 5px rgba(255, 255, 255, 0.1); }
    50% { box-shadow: 0 0 15px rgba(255, 255, 255, 0.3); }
    100% { box-shadow: 0 0 5px rgba(255, 255, 255, 0.1); }
}

h1, h2, h3 {
    animation: fadeInUp 1s ease-out, pulseGlow 3s infinite;
}

#app {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: url('assets/login-background.jpg') no-repeat center center/cover;
}

.auth-container {
    background: rgba(74, 74, 74, 0.9);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.7);
    animation: fadeInUp 1.5s ease-out;
}

.server-card {
    background: #4A4A4A;
    border-radius: 15px;
    padding: 15px;
    margin: 10px 0;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.server-card:hover {
    background: #333333;
    transform: translateY(-5px);
}

.server-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    animation: orbit 6s linear infinite;
    z-index: 0;
}

.server-card-content {
    position: relative;
    z-index: 1;
}

@keyframes orbit {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.icon {
    display: inline-block;
    width: 40px;
    height: 40px;
    background: #D3D3D3;
    border-radius: 10px;
    margin: 5px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.icon:hover {
    transform: rotate(5deg) scale(1.1);
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
}

.icon::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1));
    animation: shine 2s infinite;
}

@keyframes shine {
    0% { transform: translateX(-100%); }
    100% { transform: translateX(100%); }
}

.intro-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: url('assets/intro-background.jpg') no-repeat center center/cover;
    animation: fadeInZoom 2s ease-out;
}

.intro-logo {
    width: 250px;
    animation: float 3s ease-in-out infinite;
}

.loader {
    border: 5px solid #4A4A4A;
    border-top: 5px solid #FFFFFF;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    animation: spin 1.5s linear infinite;
    margin: 20px auto;
}

#particles-js {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -1;
}

@keyframes fadeInZoom {
    0% { opacity: 0; transform: scale(0.5); }
    100% { opacity: 1; transform: scale(1); }
}

@keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
    100% { transform: translateY(0); }
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.glow-effect {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: 0;
}

@keyframes glowPulse {
    0% { opacity: 0.5; }
    50% { opacity: 1; }
    100% { opacity: 0.5; }
}

[data-tooltip] {
    position: relative;
}

[data-tooltip]:hover:after {
    content: attr(data-tooltip);
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: #4A4A4A;
    color: #D3D3D3;
    padding: 5px 10px;
    border-radius: 5px;
    animation: fadeInUp 0.5s ease-out;
    white-space: nowrap;
}

.server-icon {
    width: 30px;
    height: 30px;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="%23D3D3D3" d="M256 0C114.6 0 0 114.6 0 256s114.6 256 256 256s256-114.6 256-256S397.4 0 256 0zM256 448c-105.9 0-192-86.1-192-192s86.1-192 192-192s192 86.1 192 192S361.9 448 256 448zM256 128c-70.7 0-128 57.3-128 128s57.3 128 128 128s128-57.3 128-128S326.7 128 256 128zM256 320c-53 0-96-43-96-96s43-96 96-96s96 43 96 96S309 320 256 320z"/></svg>') no-repeat center;
    display: inline-block;
    animation: pulseGlow 3s infinite;
}
EOL

# Aggiungi il file HTML per l'intro
print_message "Aggiunta del file HTML per l'intro..."
cat > /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets/intro.html << 'EOL'
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>CosmicPulse Intro</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <div class="intro-container">
        <img src="assets/logo.png" alt="CosmicPulse Logo" class="intro-logo">
        <h1>CosmicPulse</h1>
        <div class="loader"></div>
    </div>
    <div id="particles-js"></div>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script src="assets/intro.js"></script>
</body>
</html>
EOL

# Aggiungi il file JavaScript per l'intro
print_message "Aggiunta del file JavaScript per l'intro..."
cat > /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets/intro.js << 'EOL'
setTimeout(() => {
    window.location.href = '/auth/login';
}, 4000);

particlesJS('particles-js', {
    particles: {
        number: { value: 100 },
        color: { value: '#D3D3D3' },
        shape: { type: 'circle' },
        opacity: { value: 0.7, random: true },
        size: { value: 4, random: true },
        move: { speed: 3, direction: 'none', random: true }
    },
    interactivity: {
        events: { onhover: { enable: true, mode: 'grab' } }
    }
});
EOL

# Aggiungi il file JavaScript per la gestione server
print_message "Aggiunta del file JavaScript per la gestione server..."
cat > /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets/server.js << 'EOL'
document.addEventListener('DOMContentLoaded', () => {
    const serverCards = document.querySelectorAll('.server-card');
    serverCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.background = '#333333';
            const glow = document.createElement('div');
            glow.className = 'glow-effect';
            glow.style.cssText = 'position: absolute; width: 100%; height: 100%; background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%); animation: glowPulse 1.5s infinite;';
            card.appendChild(glow);
        });
        card.addEventListener('mouseleave', () => {
            card.style.background = '#4A4A4A';
            const glow = card.querySelector('.glow-effect');
            if (glow) glow.remove();
        });
    });
});
EOL

# Scarica le immagini
print_message "Download delle immagini di sfondo..."
cd /var/www/pterodactyl/blueprint/extensions/CosmicPulse/assets || handle_error "Impossibile accedere alla directory assets."
wget https://images.unsplash.com/photo-1472214103451-9374bd1c798e -O login-background.jpg || handle_error "Impossibile scaricare login-background.jpg."
wget https://images.unsplash.com/photo-1501862700950-22794cb7c1b9 -O intro-background.jpg || handle_error "Impossibile scaricare intro-background.jpg."
wget https://cdn-icons-png.flaticon.com/512/2991/2991818.png -O logo.png || handle_error "Impossibile scaricare logo.png."

# Imposta i permessi
print_message "Impostazione dei permessi..."
chown -R www-data:www-data /var/www/pterodactyl || handle_error "Impossibile impostare i permessi."
chmod -R 755 /var/www/pterodactyl || handle_error "Impossibile modificare i permessi."

# Compila l'estensione
print_message "Compilazione del tema..."
cd /var/www/pterodactyl || handle_error "Impossibile accedere alla directory di Pterodactyl."
blueprint -build || handle_error "Impossibile compilare il tema."

# Riavvia il servizio web
print_message "Riavvio del servizio web..."
systemctl restart nginx || systemctl restart apache2 || handle_error "Impossibile riavviare il servizio web."

print_message "Configurazione completata! Visita http://34.170.166.161:8080 per vedere il tema CosmicPulse."
print_message "Nota: Verifica la porta configurata se il pannello non si apre."
