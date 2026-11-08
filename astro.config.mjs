import { defineConfig } from 'astro/config';

// El rediseño bento es de una sola página: las rutas antiguas redirigen al inicio.
export default defineConfig({
  redirects: {
    '/proyectos': '/',
    '/sobre-mi': '/',
    '/contacto': '/#contacto',
  },
});
