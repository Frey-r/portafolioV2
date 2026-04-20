# ==========================================
# BUILD STAGE: Generar archivos estáticos Astro
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar dependencias primero para optimizar el caché de Docker
COPY package*.json ./
COPY bun.lock ./

# Instalar dependencias (usaremos npm ya que está garantizado globalmente)
RUN npm install

# Copiar el código fuente
COPY . .

# Compilar Astro en modo estático por defecto
RUN npm run build


# ==========================================
# RUN STAGE: Servir con Caddy
# ==========================================
FROM caddy:2-alpine

# Copiar la carpeta dist/ lista (HTML/CSS/JS) hacia Caddy
COPY --from=builder /app/dist /srv

# Proveer la configuración que atrapa la API y los estáticos
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80
EXPOSE 443
