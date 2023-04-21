const path = require('path')

module.exports = (env, args) => {
  return {
    entry: "./src/coffee/app.coffee",
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "app.js",
    },
    mode:   env.prod ? 'production' : 'development',
    watch:  env.prod ? false : true,
    module: {
      rules: [
        {
          test: /\.css$/i,
          use: ["style-loader", "css-loader"],
        },
        {
          test: /\.coffee$/,
          use: ["coffee-loader"],
        },
        {
          test: /\.pug$/,
          use: ["apply-loader", "pug-loader"],
        },
      ]
    }
  }
}
