const defaultTheme = require('tailwindcss/defaultTheme')
const daisyui = require('daisyui')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      daisyui: {
        themes: ['garden'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    daisyui,
  ],
  safelist: [
    "bg-[#cb4023]",
    "bg-[#f48858]",
    "bg-[#6dd2d9]",
    "bg-[#3da566]",
    "bg-[#81ade0]",
    "bg-[#5bca84]",
    "bg-[#ffcf1c]",
    "bg-[#dca6bf]",
  ],
}
