import 'package:service_worker/window.dart' as sw;

void main(){
  if (sw.isSupported){
    sw.register('sw.dart.js');
  }
  else{
    print ('Service Worker are not supported.');
  }
}
