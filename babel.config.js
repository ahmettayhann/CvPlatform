module.exports = function(api) {
  const validEnv = ['development', 'test', 'production'];
  const currentEnv = api.env();

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      `Please specify a valid NODE_ENV or BABEL_ENV environment variables. 
       Valid values are "development", "test", and "production". Instead, received: ${JSON.stringify(currentEnv)}`
    );
  }

  return {
    presets: [
      ['@babel/preset-env', {
        useBuiltIns: 'entry',
        corejs: 3,
        modules: false,
        targets: {
          browsers: ["> 1%", "last 2 versions", "not ie <= 8"]
        },
        exclude: ['transform-typeof-symbol']
      }]
    ],
    plugins: [
      '@babel/plugin-transform-runtime',
      '@babel/plugin-syntax-dynamic-import',
      ['@babel/plugin-proposal-class-properties', { loose: true }],
      ['@babel/plugin-proposal-private-methods', { loose: true }],
      ['@babel/plugin-proposal-private-property-in-object', { loose: true }],
      '@babel/plugin-proposal-optional-chaining',
      '@babel/plugin-proposal-nullish-coalescing-operator',
      '@babel/plugin-proposal-logical-assignment-operators'
    ]
  }
}