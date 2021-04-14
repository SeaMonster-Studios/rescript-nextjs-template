module.exports = {
  mode: "jit",
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },
  // purge: false,
  purge: {
    // Specify the paths to all of the template files in your project
    content: [
      './pages/**/*.{re,res,css,js}',
      './src/**/*.{re,res,css,js}'
    ],
    options: {
      whitelist: ["html", "body"],
    }
  },
  theme: {
    /* Most of the time we customize the font-sizes,
     so we added the Tailwind default values here for
     convenience */
    /* We override the default font-families with our own default prefs  */
    fontFamily: {
      body: ['Helvetica Neue', '-apple-system', 'BlinkMacSystemFont', 'Arial', 'sans-serif'],
      display: ['Helvetica Neue', 'Georgia', '-apple-system', 'BlinkMacSystemFont', 'Arial', 'sans-serif'],
    },
  },
}
