# React application from scratch without CRA

## Installation
```bash
chmod +x install.sh
./install.sh
```
## Using
Its described at end of file:
```
npm start     - run app on localhost server
npm run build - build app in development mode
npm run test  - start testing with Jest
```
## Build in production mode
Change _mode_ in __webpack.config.js__
```js
mode: "production"
```
## Testing

> ***Warning!!!***  
  i'm using `act`, if you don't need remove that part from the end of `package.json` file and change import in `src/App.test.js`.
  
  Install `@testing-library/react` if you need it.
