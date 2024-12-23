'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "5d3b3bbeec4ce6123a648b681b799df6",
"assets/AssetManifest.bin.json": "6fc03464fc8633a4a1c84270d39dfba7",
"assets/AssetManifest.json": "fa18e5debf6e56ae6da5a25a397e6ebb",
"assets/assets/icons/admin.png": "64e52f94f98d6106785eeb554d5d34f4",
"assets/assets/icons/arabic.png": "3940e635469edb93cead69cbea5902ca",
"assets/assets/icons/campus.png": "a36ac86998bc7f54c9ed02252132b8c5",
"assets/assets/icons/certificates.png": "b190df285d589296894876e8652ed15b",
"assets/assets/icons/class.png": "8ca6b8284b5f353855fd1906cc2faa83",
"assets/assets/icons/classRooms.png": "24130ed7d2f8d898fcfb61339daa184d",
"assets/assets/icons/cohort.png": "8394bd56f6ce5d94f859654e85737bd8",
"assets/assets/icons/dashboard.png": "f4a9c1ab5bc71e77a5644f9e0ef86eb5",
"assets/assets/icons/exam.png": "a3ab010250bbc34af294cb1130428138",
"assets/assets/icons/logout.png": "f277ca59e3ff6d348ecd9c768899c072",
"assets/assets/icons/more.png": "48872501243cd173e89b04d1693ae5f2",
"assets/assets/icons/notification_image.png": "0d291870bd273d45bfc2811cddf7c107",
"assets/assets/icons/patchDoc.png": "b604fc9b7afb86ebb5b118511ae4f93f",
"assets/assets/icons/proccess.png": "9c60c96507377e22ea0df4fed583dc79",
"assets/assets/icons/roles.png": "4d9cf5bf361d2d5f60fef1a6cf5ec990",
"assets/assets/icons/student.png": "d6ee05e22204f565587ad91c3391e2ce",
"assets/assets/icons/student_degrees.png": "99212d8b02c83816e088fc6dd8fd0110",
"assets/assets/icons/supject.png": "92841a65c25462b6cfd48fd4950663e3",
"assets/assets/images/background.png": "36364c1c826cfaedbd1fa4f8d2a4c3f6",
"assets/assets/images/class_desk.png": "4c8cc8046233c470d7271df37a9dbe0a",
"assets/assets/images/nis1.jpg": "2654c9a24975c3d7fc420cbd195b2aa6",
"assets/assets/images/nis2.jpg": "2faa9c9dc6e7dcae39eaf604722ea500",
"assets/assets/images/nis3.jpg": "a8cfeb77b66d8247fcebf79ef4eca4e9",
"assets/assets/logos/barcode.png": "577c23deba5b30dc765e24bebf84c54b",
"assets/assets/logos/NIS5.png": "08432cdcd55b1152cd5f6b7bff271ca8",
"assets/assets/logos/nis_logo.png": "728f93d3c5a77278002eb1dd3e4aa64d",
"assets/assets/logos/nis_logo22.png": "e88bad9f217e8d2932fd9dd154dd4cb6",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "cc0105fb0543837accf45ff32f5b1e51",
"assets/NOTICES": "e0c4101e9bf819a9e87a9c94bcbe0b9f",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "7d844e596d4c0da5e4d0b6b35c196b97",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "9d82b082b1786b84eeaf85875495d0d9",
"icons/Icon-192.png": "db9fb010616d67905d18a3c517479f4e",
"icons/Icon-512.png": "4f1685b6f43d89b05e30955afc5f7aae",
"icons/Icon-maskable-192.png": "db9fb010616d67905d18a3c517479f4e",
"icons/Icon-maskable-512.png": "4f1685b6f43d89b05e30955afc5f7aae",
"index.html": "4d80b8f3e04fd1f2868889b73d71e1ee",
"/": "4d80b8f3e04fd1f2868889b73d71e1ee",
"main.dart.js": "b8d9b29168b7092ef790cb9e4effe5b3",
"manifest.json": "9169b64f5ba2ea8abd56d4f9fe7e48c4",
"version.json": "57843ccc919bc39a0d65e97afc6117e4"};
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
