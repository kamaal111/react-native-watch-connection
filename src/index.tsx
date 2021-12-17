import { NativeEventEmitter, NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-watch-connection' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const WatchConnection = NativeModules.WatchConnection
  ? NativeModules.WatchConnection
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

enum Events {
  DID_CHANGE = 'watchConnectionDidChange',
}

let watching = false;

const WatchConnectionEventEmitter = new NativeEventEmitter(WatchConnection);

function activate() {
  watching = true;
  WatchConnection.activate();
}

function noop() {}

export function subscribe(
  callback: (event: any) => void,
  error: (_err: Error) => void = noop
) {
  activate();

  if (!watching) {
    error(new Error('Could not watch for watchConnection events'));
    return;
  }

  return WatchConnectionEventEmitter.addListener(Events.DID_CHANGE, callback);
}

interface Message {
  [x: string]: any;
}

export async function sendMessage(message: Message): Promise<Message> {
  return WatchConnection.sendMessage(message);
}

export default { subscribe, sendMessage };
