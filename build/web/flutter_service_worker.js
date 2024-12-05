'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "49d1888b708f106d009977fde845167c",
"assets/AssetManifest.bin.json": "3608e89669af2ef9145750d6b2ade083",
"assets/AssetManifest.json": "664e158cbb35e3fec3de7bd1c7dfc701",
"assets/assets/3d/camara%2520V3.glb": "13a3f1d028db53c5d36945626a132de5",
"assets/assets/3d/camara%2520V7.glb": "10bcdb0e9b7c7907cc18cb0aae7c2388",
"assets/assets/3d/camara%2520V8.glb": "8e57e55ce528042262be1d631843a6f2",
"assets/assets/3d/estudio.glb": "5de844d618812562c849371f6168171b",
"assets/assets/fonts/GreatVibes-Regular.ttf": "f8ab2af266e7331cc085e495d82fecf8",
"assets/assets/images/04.jpg": "4066376de76391a47074758592a3c90e",
"assets/assets/images/20230928101414_IMG_4547.jpg": "414ffb7a2af9096171889668e7f6a8e7",
"assets/assets/images/20231118152107_IMG_5210.jpg": "a5b1c59c22ef333dc680ffa86eb66694",
"assets/assets/images/20240217183451_IMG_5565.jpg": "5a4abc32b0a328513bd3eacdfb3f9b76",
"assets/assets/images/20240623114514_IMG_6725.jpg": "5d384b9a860b63a1ee4c2d696d417068",
"assets/assets/images/carrucel/20240922144938_IMG_8064.jpg": "145d54ba8055895894bbaa015401efa7",
"assets/assets/images/carrucel/pexels-caspersomia-27060169.jpg": "d2354e5728554f11d58e818091ada1a2",
"assets/assets/images/carrucel/pexels-eduardo-barrientos-140939364-27815948.jpg": "45889b1bf111b49d21679d1c6e56bccc",
"assets/assets/images/carrucel/pexels-matvalina-12169557.jpg": "fbf696c01787929685cc3cdadeef1371",
"assets/assets/images/carrucel/pexels-norman-milwood-236004651-28182351.jpg": "ed9acb838e9172d9a0b179abeffd6d06",
"assets/assets/images/carrucel/pexels-vika-glitter-392079-1648387.jpg": "77250cdb88133baae841ae80389d0ad4",
"assets/assets/images/carrucel/woman-6671171_1280.jpg": "aecf3f120e1eb183bebb89623035ca5d",
"assets/assets/images/foto.png": "b601758f1b085a54984db7f5e5fe7686",
"assets/assets/images/fotoh.png": "e8734317e21590a2882829ee8d5b1a2a",
"assets/assets/images/inicio/img%252006.jpg": "6a4f3148feb30ed8287b2dcf87200581",
"assets/assets/images/inicio/pexels-alexander-mass-748453803-26795041.jpg": "95bf5b938aab85d0cba5ad48d152a296",
"assets/assets/images/inicio/pexels-hannia-torres-348555462-14160806.jpg": "715f1b99a07d8da5b17b986bc1400243",
"assets/assets/images/Logo%2520MontF.png": "d58c19e54b34ea6570ff551945a0252c",
"assets/assets/images/paqueteria/1.png": "e60cabf7ee756de5620daacde077e1ab",
"assets/assets/images/paqueteria/2.png": "7d8afb565fb96610d5b0b146f2e1b6ca",
"assets/assets/images/paqueteria/3.png": "367cea8381d7737cd490b87b95f0f5ed",
"assets/assets/images/paqueteria/4.png": "bcc3205dcb753d5fa0faa6db74367d74",
"assets/assets/images/PicsArt_09-19-08.51.36.jpg": "8d84a052d29886d6831e7b207b06d66c",
"assets/assets/images/PicsArt_09-19-08.54.37.jpg": "5132841c2cf2e16e2261b9c28f2fdc7c",
"assets/assets/images/portafolio/img%252003.jpg": "414a4d277bf69e7aa742e7efcbad72b4",
"assets/assets/images/portafolio/img%252008.jpg": "1831e3fd652d9a01179bf3b2467af0f9",
"assets/assets/images/portafolio/pexels-brett-sayles-14353625.jpg": "73bd213feef03c7140d8a006ee44f2f9",
"assets/assets/images/portafolio/pexels-caspersomia-27060156.jpg": "b7f0f1a3b3e410646c09efd4b3a51e38",
"assets/assets/images/portafolio/pexels-george-chambers-413080139-19817004.jpg": "12b639fa346d3b178d981ddf502b4002",
"assets/assets/images/portafolio/pexels-hasmukh-abchung-413074376-16897442.jpg": "af55ed1b08a2532d4cdfc0b04c51a225",
"assets/assets/images/portafolio/pexels-murillohm-10649109.jpg": "ae0b2a91cd7749dccac71c64b00ea7d9",
"assets/assets/images/portafolio/pexels-uraw-17615698.jpg": "654357701072c706e834b0045b9520bf",
"assets/assets/images/sobren/camara.png": "4df27c2120080b06768f4d082f82f170",
"assets/assets/images/sobren/estudio.png": "5435c6705d7778c9168cfe30d4012c48",
"assets/FontManifest.json": "08f39774014c25d58c1ed6d5d6dee710",
"assets/fonts/MaterialIcons-Regular.otf": "50aa9678cd9845f73ba5a8653652f1c7",
"assets/NOTICES": "aa972935a6f1ffe78682cc58fa266724",
"assets/packages/babylonjs_viewer/assets/viewer/babylon.viewer.min.js": "3453103262a6bfe68876db183953dd60",
"assets/packages/babylonjs_viewer/assets/viewer/bg_nx.jpg": "2a52b2671df5349d3d2ed77aeb549a7f",
"assets/packages/babylonjs_viewer/assets/viewer/template.html": "4e6408c82d0b48b2b3825e00ab00d4a4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "85111d52a6a0392133a0b9597633740e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "a9dc98f8bf360be897a0898a7395f905",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "4f699b7ee2874b7a9366fcc9e2e27c40",
"canvaskit/canvaskit.js.symbols": "02ddbe0eb7e29bf085fed31bbc7addab",
"canvaskit/canvaskit.wasm": "c1dc9fc64682ab3742d07cb6150c5494",
"canvaskit/chromium/canvaskit.js": "a8a985c372a3da4adddce08dddd93e4a",
"canvaskit/chromium/canvaskit.js.symbols": "b3da218d63f6fe24837b4b7a98adad6d",
"canvaskit/chromium/canvaskit.wasm": "3976dc779545b9bf5065c5e4540f4219",
"canvaskit/skwasm.js": "2f1d6794be164b5cad5772f38ad06973",
"canvaskit/skwasm.js.symbols": "f7ce6cdf2b0eb8928e1b15adf268f009",
"canvaskit/skwasm.wasm": "35c033246f88d704782ead5c133b2df2",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "d58c19e54b34ea6570ff551945a0252c",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "ba3f5fd29b29c00eb315522f326d1e90",
"icons/Icon-192.png": "b1f946f8b00ef55484b9548d3553661e",
"icons/Icon-512.png": "f559f4f228e2f11fdbe66f90d517071b",
"icons/Icon-maskable-192.png": "b1f946f8b00ef55484b9548d3553661e",
"icons/Icon-maskable-512.png": "f559f4f228e2f11fdbe66f90d517071b",
"index.html": "a31eedc5f1e32cff4118ad58a79b37d1",
"/": "a31eedc5f1e32cff4118ad58a79b37d1",
"main.dart.js": "3d560e0513f676ece35bb8a378d7abf1",
"manifest.json": "6757d6ba219766a825f78c4460721b68",
"version.json": "4415632d1d77ed92ff5f6d5f328cd913"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
