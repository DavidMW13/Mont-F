'use strict';

// Nombre del caché
const CACHE_NAME = 'flutter-app-cache';

// Archivos que se deben cachear
const RESOURCES = {
  "index.html": "código_hash",
  "main.dart.js": "código_hash",
  "flutter.js": "código_hash",
  "manifest.json": "código_hash",
  "assets/NOTICES": "código_hash",
  "assets/AssetManifest.json": "código_hash",
  "assets/FontManifest.json": "código_hash",
  // Agrega aquí más archivos de tu carpeta build/web
};

self.addEventListener('install', (event) => {
  // Precarga de recursos
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('activate', (event) => {
  // Limpieza de cachés antiguas
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

self.addEventListener('fetch', (event) => {
  // Respuesta desde la caché
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request).then((fetchResponse) => {
        return caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, fetchResponse.clone());
          return fetchResponse;
        });
      });
    })
  );
});
