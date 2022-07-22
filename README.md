# Compose
Compose&amp;Flutter


用于Compose的各种组件的学习使用，
Compose和Flutter的结合使用

#### Flutter和原生Android交互
使用MethodChannel进行交互，需要在MainActivity中注册MethodChannel，所使用的engine必须要是启动Flutter的engine.

#### 使用Camera
使用相机拍照要注意
如果混合开发，使用了FlutterEngineCache的话，界面打不开，这个问题网上都没有找到。这是最终的问题。
而且：拍照后跳转的Navigator还有要求，整个Widget外面必须有一个StatelessWidget，并且使用MaterialApp作为StatelessWidget的父节点。