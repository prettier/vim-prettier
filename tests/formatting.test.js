const fs = require('fs');
const path = require('path');
const HeadlessRemoteClient = require('vim-driver/dist/HeadlessRemoteClient');
const Server = require('vim-driver/dist/Server');

const HOST = '127.0.0.1';
const PORT = 1337;
const FIXTURES_DIR = `${__dirname}/fixtures`;

let server;
let remote;

jest.setTimeout(15000);

const getBufferContents = async remote =>
  (await remote.call('getline', [1, '$'])).join('\n');

const sleep = ms => new Promise(resolve => setTimeout(resolve, ms));
const waitUntil = (condition, timeout = 2000) => {
  return new Promise(resolve => {
    let isTimedOut = false;
    let timeoutId = null;

    const check = () => {
      const promise = condition();
      promise.then(result => {
        if (!isTimedOut && result === true) {
          clearTimeout(timeoutId);
          resolve();
        } else if (!isTimedOut) {
          check();
        }
      });
    };

    timeoutId = setTimeout(() => {
      isTimedOut = true;
      resolve();
    }, timeout);
  });
};

const assertFormatting = (file) => {
  const filename = path.basename(file);
  test(`Prettier formats ${filename} file with :Prettier command`, async () => {
    await remote.edit(`${FIXTURES_DIR}/${file}`);

    const lines = await getBufferContents(remote);

    // run sync formatting
    await remote.execute('Prettier');

    const updatedLines = await getBufferContents(remote);

    // we now check that we have indeed formatted the code
    expect(updatedLines).not.toBe(lines);

    // check snapshot
    expect(updatedLines).toMatchSnapshot();
  });

  test(`Prettier formats ${filename} file with :PrettierAsync command`, async () => {
    await remote.edit(`${FIXTURES_DIR}/${file}`);

    const lines = await getBufferContents(remote);

    // run async formatting
    await remote.execute('PrettierAsync');

    const unmodifiedLines = await getBufferContents(remote);

    // async should not happen immediatly so content should still remain the same
    expect(unmodifiedLines).toBe(lines);

    // we now will wait until prettier has finally updated the content async
    await waitUntil(async () => (await getBufferContents(remote)) !== lines);

    const updatedLines = await getBufferContents(remote);

    // we now check that we have indeed formatted the code
    expect(lines).not.toBe(updatedLines);

    // check snapshot
    expect(updatedLines).toMatchSnapshot();
  });
};

beforeAll(async () => {
  server = new Server();
  await server.listen(HOST, PORT);
});

afterAll(async () => {
  await server.close();
});

// should ensure that we cache original fixture contents and
// restore it on the afterEach
beforeEach(async () => {
  remote = new HeadlessRemoteClient({host: HOST, port: PORT});
  await remote.connect(server);
});

afterEach(async () => {
  if (remote.isConnected()) {
    try {
      const filename = await remote.call('expand', ['%:p']);

      if (filename) {
        // restore the file
        await remote.execute('earlier 1d | noautocmd | write');
      }
    } catch (e) {
    } finally {
      await remote.close();
    }
  }
});

//test('PrettierVersion returns pluggin version', async () => {
//  const result = await remote.execute('PrettierVersion');
//  expect(result).toMatchSnapshot();
//});

// run formatting tests in all fixtures
fs.readdirSync(FIXTURES_DIR).forEach(file => assertFormatting(file));
