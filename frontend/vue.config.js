// vue.config.js

const IS_PRODUCTION = process.env.NODE_ENV === 'production'

module.exports = {
  lintOnSave: false,
  publicPath: IS_PRODUCTION
    ? ''
    : '/',
  assetsDir: IS_PRODUCTION
    ? 'static'
    : '',
  devServer: {
    hot: true,
    hotOnly: true,
    disableHostCheck: true,
    historyApiFallback: true,
    public: '0.0.0.0:8000',
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization'
    },
    watchOptions: {
      poll: 1000,
      ignored: '/app/node_modules/'
    },
  },
}
