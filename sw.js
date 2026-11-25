// Service Worker - عالم الشيمي
// تخزين مؤقت للعمل بدون إنترنت

const CACHE_NAME = "shimee-v1";

const ASSETS = [
    "index.html",
    "dashboard.html",
    "company_accounts.html",
    "manifest.json",
    "logo-transparent.png",
    "logo-print-black.png",
    "favicon-32.png",
    "pwa-icon-192.png",
    "pwa-icon-512.png"
];

self.addEventListener("install", (event) => {

    event.waitUntil(

        caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))

    );

});

self.addEventListener("fetch", (event) => {

    event.respondWith(

        caches.match(event.request).then((response) => {

            return response || fetch(event.request);

        })

    );

});
