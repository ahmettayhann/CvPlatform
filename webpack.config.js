const path = require('path');

   module.exports = {
     module: {
       rules: [
         {
           test: /\.scss$/,
           use: [
             'style-loader',
             'css-loader',
             {
               loader: 'postcss-loader',
               options: {
                 postcssOptions: {
                   plugins: [
                     require('postcss-import'),
                     require('tailwindcss'),
                     require('autoprefixer'),
                   ],
                 },
               },
             },
             'sass-loader',
           ],
         },
       ],
     },
   };