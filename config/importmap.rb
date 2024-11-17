# Pin npm packages by running ./bin/importmap

pin "application"
# pin "bootstrap" # @5.3.3
# pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.2.0/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js"
pin "filepond", to: "https://ga.jspm.io/npm:filepond@4.30.4/dist/filepond.js"
pin_all_from "app/javascript/custom", under: "custom"
pin "filepond-plugin-image-preview", to: "https://ga.jspm.io/npm:filepond-plugin-image-preview@4.6.11/dist/filepond-plugin-image-preview.js"
pin "filepond-plugin-file-validate-type", to: "https://ga.jspm.io/npm:filepond-plugin-file-validate-type@1.2.8/dist/filepond-plugin-file-validate-type.js"
