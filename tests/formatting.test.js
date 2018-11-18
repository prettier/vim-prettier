const HeadlessRemoteClient = require('vim-driver/dist/HeadlessRemoteClient');
const Server = require('vim-driver/dist/Server');

const HOST = '127.0.0.1';
const PORT = 1337;

let server;
let remote;

beforeAll(async () => {
  server = new Server();
  await server.listen(HOST, PORT);
});

afterAll(async () => {
  await server.close();
});

beforeEach(async () => {
  remote = new HeadlessRemoteClient({host: HOST, port: PORT});
  await remote.connect(server);
});

afterEach(async () => {
  if (remote.isConnected()) {
    await remote.close();
  }
});

test('PrettierVersion returns pluggin version', async () => {
  const result = await remote.execute('PrettierVersion');
  expect(result).toMatchSnapshot();
});
