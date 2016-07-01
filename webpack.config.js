var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: 'eval',

  entry:
  [ 'webpack-dev-server/client?http://localhost:3000'
  , './app/index.js'
  ],

  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
  },

  resolve: {
    extensions: [ '', '.js', '.elm'],
    modulesDirectories: [ 'app', 'node_modules' ]
  },

  module: {
    loaders: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-hot!elm-webpack'
    }],

    noParse: /\.elm$/
  }
};