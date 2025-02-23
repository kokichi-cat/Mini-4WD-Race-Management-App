document.addEventListener("turbo:load", function() {
    console.log("Turbo loaded - reinitializing Lightbox"); // デバッグ用
    if (window.lightbox) {
        lightbox.init(); // 再初期化
    }
});
