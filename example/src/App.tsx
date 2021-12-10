import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { subscribe } from 'react-native-watch-connection';

export default function App() {
  React.useEffect(() => {
    subscribe(
      (message) => {
        console.log(`message`, message);
      },
      (error) => {
        console.log(`error`, error);
      }
    );
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result 0</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
