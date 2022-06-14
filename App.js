import React from 'react';
import {View, Button, NativeModules, Image} from 'react-native';

const {ImagePicker} = NativeModules;

const App = () => {
  const [image, setImage] = React.useState(null);

  const selectImage = React.useCallback(() => {
    ImagePicker.selectPhoto()
      .then(newImage => {
        setImage(newImage);
      })
      .catch(ex => console.warn(ex));
  }, []);

  return (
    <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
      <Button onPress={selectImage} title={'Выбрать фото'} />
      <Image
        key={image}
        source={{uri: image}}
        style={{width: '100%', aspectRatio: 1}}
      />
    </View>
  );
};

export default App;
