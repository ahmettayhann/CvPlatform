module.exports = function(api) {
  // Define valid environments
  const validEnv = ['development', 'test', 'production'];
  const currentEnv = api.env();

  // Throw error if the environment is not valid
  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      `Please specify a valid NODE_ENV or BABEL_ENV environment variables. 
      Valid values are "development", "test", and "production". Instead, received: ${JSON.stringify(currentEnv)}`
    );
  }

  const isDevelopmentEnv = api.env('development');
  const isProductionEnv = api.env('production');
  const isTestEnv = api.env('test');

  return {
    presets: [
      isTestEnv && [
        '@babel/preset-env',
        {
          targets: { node: 'current' },
          modules: 'commonjs',
        }
      ],
      (isDevelopmentEnv || isProductionEnv) && [
        ["@babel/preset-env", {
          "targets": {
            "browsers": ["> 1%", "last 2 versions", "not ie <= 8"]
          }
        }],
        {
          useBuiltIns: 'entry',
          corejs: 3,
          modules: false,
          forceAllTransforms: true,
          exclude: ['transform-typeof-symbol']
        }
      ],
      [
        '@babel/preset-react',
        {
          development: isDevelopmentEnv || isTestEnv,
          useBuiltIns: true
        }
      ]
    ].filter(Boolean),
    plugins: [
      'babel-plugin-macros',
      '@babel/plugin-syntax-dynamic-import',
      isTestEnv && 'babel-plugin-dynamic-import-node',

      // Class properties and private methods
      ['@babel/plugin-proposal-class-properties', { loose: true }],
      ['@babel/plugin-proposal-private-methods', { loose: true }],
      ['@babel/plugin-proposal-private-property-in-object', { loose: true }],

      // Optional chaining and nullish coalescing
      '@babel/plugin-proposal-optional-chaining',
      '@babel/plugin-proposal-nullish-coalescing-operator',

      '@babel/plugin-transform-destructuring',
      '@babel/plugin-proposal-object-rest-spread',
      
      [
        '@babel/plugin-transform-runtime',
        {
          helpers: false,
          regenerator: true,
          corejs: false
        }
      ],
      [
        '@babel/plugin-transform-regenerator',
        {
          async: false
        }
      ],

      isProductionEnv && [
        'babel-plugin-transform-react-remove-prop-types',
        {
          removeImport: true
        }
      ]
    ].filter(Boolean)
  }
}
