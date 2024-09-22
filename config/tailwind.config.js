const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue',
  ],
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  safelist: [
    'bg-blue-600',
    'hover:bg-blue-700',
    'bg-gray-600',
    'hover:bg-gray-700',
    'text-white',
    'inline-flex',
    'items-center',
    'px-4',
    'py-2',
    'border',
    'border-transparent',
    'text-sm',
    'font-medium',
    'rounded-md',
    'focus:outline-none',
    'focus:ring-2',
    'focus:ring-offset-2',
    'focus:ring-blue-500',
    'focus:ring-gray-500',
    'mr-2',
    'space-x-4',
    'mb-6',
    'sm:inline-flex',
    'hidden'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}