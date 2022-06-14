import React from 'react';
import {View, requireNativeComponent} from 'react-native';

const SimpleTextView = requireNativeComponent('SimpleTextView');

const App = () => (
  <View style={{flex: 1, justifyContent: 'center', backgroundColor: 'gray'}}>
    <SimpleTextView content={'test\n\ntest'} />
  </View>
);

export default App;
