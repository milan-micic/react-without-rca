#!/bin/bash

echo "Kreiran package.json fajl"
cat << EOF > package.json
{
  "name": "new-react-app",
  "version": "1.0.0",
  "description": "A new react app without CRA",
  "main": "index.js",
  "scripts": {
    "start": "webpack-dev-server .",
    "build": "webpack .",
    "test": "jest"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "jest": {
    "testEnvironment": "jsdom",
    "globals": {
      "IS_REACT_ACT_ENVIRONMENT": true
    }
  }
}
EOF

echo "Instaliranje paketa webpack babel eslint path jest"
npm i --save-dev webpack webpack-cli webpack-dev-server babel-loader @babel/preset-env @babel/core @babel/plugin-transform-runtime @babel/preset-react @babel/eslint-parser @babel/runtime @babel/cli eslint eslint-config-airbnb-base eslint-plugin-jest eslint-config-prettier path jest-environment-jsdom
echo "Instaliranje React paketa"
npm i react react-dom

echo "Kreiran public/index.html fajl"
mkdir public
cat << EOF > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Webpack React</title>
</head>
<body>
    <div id="root"></div>
    <script src="main.js"></script> <!-- The output file of webpack config-->
</body>
</html>
EOF

echo "Kreiran src/App.js fajl"
mkdir src
cat << EOF > src/App.js
import React from "react";

const App = () =>{
    return (
        <h1>
            Welcome to React App thats build using Webpack and Babel separately
        </h1>
    )
}

export default App
EOF

echo "Kreiran src/App.test.js fajl"
cat << EOF > src/App.test.js
import React from 'react'
import ReactDOM from 'react-dom/client'
import { act } from 'react-dom/test-utils'
import App from './App'

describe('All installs and settings work', () => {
  it('render app title', () => {
    const component = <App />
    const container = document.createElement('div')
    document.body.appendChild(container)

    act(() => ReactDOM.createRoot(container).render(component))

    expect(document.body.textContent).toContain('React')
  })
})
EOF

echo "Kreiran index.js fajl"
cat << EOF > index.js
import React from "react";
// React < 18
// import reactDom from "react-dom";
// React 18
import ReactDOM from 'react-dom/client'
import App from "./src/App"

// React < 18
// reactDom.render(<App />, document.getElementById("root"))

// React 18
ReactDOM.createRoot(document.getElementById('root')).render(<App />)
EOF

echo "Kreiran webpack.config.js fajl"
cat << EOF > webpack.config.js
const path = require("path");

/*We are basically telling webpack to take index.js from entry. Then check for all file extensions in resolve. 
After that apply all the rules in module.rules and produce the output and place it in main.js in the public folder.*/

module.exports={
    /** "mode"
     * the environment - development, production, none. tells webpack 
     * to use its built-in optimizations accordingly. default is production 
     */
    mode: "development", 
    /** "entry"
     * the entry point 
     */
    entry: "./index.js", 
    output: {
        /** "path"
         * the folder path of the output file 
         */
        path: path.resolve(__dirname, "public"),
        /** "filename"
         * the name of the output file 
         */
        filename: "main.js"
    },
    /** "target"
     * setting "node" as target app (server side), and setting it as "web" is 
     * for browser (client side). Default is "web"
     */
    target: "web",
    devServer: {
        /** "port" 
         * port of dev server
        */
        port: "9500",
        /** "static" 
         * This property tells Webpack what static file it should serve
        */
        static: ["./public"],
        /** "open" 
         * opens the browser after server is successfully started
        */
        open: true,
        /** "hot"
         * enabling and disabling HMR. takes "true", "false" and "only". 
         * "only" is used if enable Hot Module Replacement without page 
         * refresh as a fallback in case of build failures
         */
        hot: true ,
        /** "liveReload"
         * disable live reload on the browser. "hot" must be set to false for this to work
        */
        liveReload: true
    },
    resolve: {
        /** "extensions" 
         * If multiple files share the same name but have different extensions, webpack will 
         * resolve the one with the extension listed first in the array and skip the rest. 
         * This is what enables users to leave off the extension when importing
         */
        extensions: ['.js','.jsx','.json'] 
    },
    module:{
        /** "rules"
         * This says - "Hey webpack compiler, when you come across a path that resolves to a '.js or .jsx' 
         * file inside of a require()/import statement, use the babel-loader to transform it before you 
         * add it to the bundle. And in this process, kindly make sure to exclude node_modules folder from 
         * being searched"
         */
        rules: [
            {
                test: /\.(js|jsx)$/,    //kind of file extension this rule should look for and apply in test
                exclude: /node_modules/, //folder to be excluded
                use:  'babel-loader' //loader which we are going to use
            }
        ]
    }
}
EOF

echo "Kreiran .babelrc fajl"
cat << EOF > .babelrc
{
    /*
        a preset is a set of plugins used to support particular language features.
        The two presets Babel uses by default: es2015, react
    */
    "presets": [
        "@babel/preset-env", //compiling ES2015+ syntax
        "@babel/preset-react" //for react
    ],
    /*
        Babel's code transformations are enabled by applying plugins (or presets) to your configuration file.
    */
    "plugins": [
        "@babel/plugin-transform-runtime"
    ]
}
EOF

echo 
echo "Sve je instalirano i podeseno.Server ce se automatski pokrenuti !!!

=====================================================
      Komande iz shela:

      npm start     - pokrece server
      npm run build - kreira development aplikaciju
      npm run test  - pokrece Jest

====================================================="
echo
read -n 1 -s -r -p "Press any key to continue"

npm start
