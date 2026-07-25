---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Flutter Helper Utils"
  tagline: Flutter Helper Utils is a comprehensive package aimed to augment Dart and Flutter's core functionalities. With a rich set of extensions and helper methods, this package boosts productivity and simplifies coding in Flutter projects.
  actions:
    - theme: brand
      text: Getting Started
      link: /documentation/getting-started
    - theme: alt
      text: Extensions
      link: /documentation/string-extension
    - theme: alt
      text: Helper Utils
      link: /documentation/convert-object
  image:
    src: /main-icon.png
    alt: VitePress

features:
  - title: Converting Objects
    details: Streamline data conversion with the ConvertObject class, resolving common issues when working with API data.
  - title: Date and Time Extension
    details: Simplify date and time operations in your app, making it easier to handle date-related tasks.
  - title: String Extension
    details: Efficiently manipulate strings in your code with the String Extension, saving time and effort.
  - title: Navigator Extension
    details: Enhance navigation within your app using the Navigator Extension, improving the user experience.
---

<style>
:root {
  --vp-home-hero-name-color: transparent;
  --vp-home-hero-name-background: -webkit-linear-gradient(120deg, #bd34fe 30%, #41d1ff);

  --vp-home-hero-image-background-image: linear-gradient(-45deg, #bd34fe 50%, #47caff 50%);
  --vp-home-hero-image-filter: blur(44px);
}

@media (min-width: 640px) {
  :root {
    --vp-home-hero-image-filter: blur(56px);
  }
}

@media (min-width: 960px) {
  :root {
    --vp-home-hero-image-filter: blur(68px);
  }
}
</style>
