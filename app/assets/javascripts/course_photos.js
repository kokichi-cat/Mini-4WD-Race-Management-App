document.addEventListener("DOMContentLoaded", function () {
  const fileInputs = document.querySelectorAll(".course-photo-input");
  const previewContainer = document.querySelector(".course-photo-preview");

  fileInputs.forEach((input, index) => {
    input.addEventListener("change", function (event) {
      const file = event.target.files[0];

      if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.classList.add("preview-image");

          const removeBtn = document.createElement("button");
          removeBtn.textContent = "削除";
          removeBtn.classList.add("remove-photo");
          removeBtn.dataset.index = index;

          const previewItem = document.createElement("div");
          previewItem.classList.add("preview-item");
          previewItem.appendChild(img);
          previewItem.appendChild(removeBtn);

          previewContainer.appendChild(previewItem);

          removeBtn.addEventListener("click", function () {
            previewItem.remove();
            input.value = ""; // 選択されたファイルをクリア
          });
        };
        reader.readAsDataURL(file);
      }
    });
  });
});
