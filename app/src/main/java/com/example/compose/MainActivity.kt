@file:OptIn(ExperimentalAnimationApi::class, ExperimentalMaterialApi::class)

package com.example.compose

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.animation.*
import androidx.compose.animation.core.*
import androidx.compose.foundation.*
import androidx.compose.foundation.gestures.*
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.consumeAllChanges
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.input.pointer.positionChange
import androidx.compose.ui.input.pointer.util.VelocityTracker
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.core.content.ContextCompat
import androidx.core.content.ContextCompat.getSystemService
import androidx.hilt.navigation.compose.hiltViewModel
import coil.compose.rememberImagePainter
import com.example.compose.model.HomeViewModel
import com.example.compose.ui.AppTheme
import com.example.compose.ui.purple200
import com.example.compose.utlis.MConstant.Engine_ID
import dagger.hilt.android.AndroidEntryPoint
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlin.math.absoluteValue
import kotlin.math.roundToInt


//@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        val mainViewModel: MainViewModel by viewModels()
        super.onCreate(savedInstanceState)
        Log.e("Hilt", "${mainViewModel.add(4, 5)}")

        setContent {
            AppTheme {
                Greeting(mainViewModel.name) {
//                    startActivity(Intent(this, FlutterActivity::class.java))
//                    startActivity(FlutterActivity.createDefaultIntent(this))
                    startActivity(
                        FlutterActivity
                            .withCachedEngine(Engine_ID)
//                            .initialRoute("/my_route")
                            .build(this)
                    )
                }
            }
        }
        configureFlutterEngine(MyApp.flutterEngine)
    }
    private val CHANNEL = "samples.flutter.dev/battery"
    private fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//    super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel"){
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1){
                    result.success(batteryLevel)
                }else{
                    result.error("UNAVAILABLE","Battery Level not available",null)
                }
            }else{
                result.notImplemented()
            }
        }
    }

    fun getBatteryLevel(): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null, IntentFilter(
                    Intent.ACTION_BATTERY_CHANGED
                )
            )
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent!!.getIntExtra(
                BatteryManager.EXTRA_SCALE,
                -1
            )
        }
    }
}


@Composable
fun Greeting(name: String = "", toFlutter: () -> Unit) {
    var viewModel = hiltViewModel<MainViewModel>()
    var homeViewModel = hiltViewModel<HomeViewModel>()
    homeViewModel.add(3)
    var visible by remember {
        mutableStateOf(true)
    }
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .padding(top = 10.dp)
            .verticalScroll(state = rememberScrollState())
    ) {
        //图片
        Image(painter = rememberImagePainter(data = R.mipmap.ic_launcher), contentDescription = "")
        MySpace()
        //文字
        Text(text = "Hello $name!,your age is ${viewModel.age},your num's ${homeViewModel.num}")
        MySpace()
        //画圆
        Canvas(modifier = Modifier
            .fillMaxWidth(1f)
            .height(100.dp), onDraw = {
            drawCircle(color = purple200)
        })
        MySpace()
        //动画
        var startPlay by remember {
            mutableStateOf(0)
        }
        val animateTween by animateIntAsState(
            targetValue = startPlay, animationSpec = tween(
                durationMillis = 1000,
                easing = LinearEasing
            )
        )
        val animateTween2 by animateIntAsState(
            targetValue = startPlay, animationSpec = tween(
                delayMillis = 1000,
                durationMillis = 1000,
                easing = LinearEasing
            )
        )
        val animateTweeninfinite by rememberInfiniteTransition().animateFloat(
            initialValue = 0f,
            targetValue = 1f,
            animationSpec = infiniteRepeatable(
                tween(durationMillis = 1000, easing = LinearEasing),
                RepeatMode.Restart
            )
        )

        Canvas(modifier = Modifier
            .height(100.dp)
            .width(200.dp)
            .border(width = 1.dp, color = Color.Gray), onDraw = {
            drawLine(
                color = Color.Red,
                start = Offset(0.0f, 0.0f),
                end = Offset((1 * animateTween).toFloat(), (1 * animateTween).toFloat()),
                strokeWidth = 2f
            )
            drawLine(
                color = Color.Red,
                start = Offset(100f, 100f),
                end = Offset(
                    (100 + 1 * animateTween2).toFloat(),
                    (100 - 1 * animateTween2).toFloat()
                ),
                strokeWidth = 2f
            )
        })
        MySpace()
        Box(
            modifier = Modifier
                .height(20.dp)
                .width((2 * animateTween).dp)
                .background(Color.Blue)
        ) {

        }
        MySpace()
        Button(onClick = {
            visible = !visible
            startPlay = if (startPlay == 0) {
                100
            } else {
                0
            }
        }) {
            Text(
                text = "点击开启动画效果", modifier = Modifier
                    .padding(horizontal = 20.dp)
            )
        }

        MySpace()

        //AnimatedVisibility
        AnimatedVisibility(
            visible = visible,
            enter = slideInHorizontally(initialOffsetX = {
                -it
            }) + expandHorizontally(
                animationSpec = tween(
                    durationMillis = 1000, easing = LinearEasing
                )
            ),
            exit = slideOutHorizontally(
                targetOffsetX = {
                    -it
                }, animationSpec = tween(
                    durationMillis = 1000, easing = LinearEasing
                )
            )
        ) {
            Text(
                text = "我可以隐藏【AnimatedVisibility】",
                Modifier
                    .background(color = Color.Gray)
                    .fillMaxWidth(1f)
                    .padding(20.dp)
            )
        }
        MySpace()
        //Flutter交互
        Button(onClick = {
            toFlutter.invoke()
        }) {
            Text(
                text = "点击进入Flutter", modifier = Modifier
                    .padding(horizontal = 20.dp)
            )
        }
        MySpace()
        Button(onClick = {
        }) {
            Text(
                text = "下面框框内点击动画", modifier = Modifier
                    .padding(horizontal = 20.dp)
            )
        }
        MySpace()
        Gesture()
        MySpace()
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(100.dp)
                .border(width = 1.dp, color = Color.Blue)
                .swipeToDismiss {
                    Log.e("Scroll", "dismiss")
                }
        ) {
            Box(
                modifier = Modifier
                    .size(50.dp)
                    .background(Color.Blue)

            )
        }
        MySpace()
        Text(
            text = "下面拖动效果-Orientation.Horizontal", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
        var offsetX by remember { mutableStateOf(0f) }
        Text(
            modifier = Modifier
                .offset { IntOffset(offsetX.roundToInt(), 0) }
                .background(color = Color.Blue)
                .draggable(
                    orientation = Orientation.Horizontal,
                    state = rememberDraggableState { delta ->
                        offsetX += delta
                    }
                ),
            text = "Drag me!", color = Color.White
        )
        MySpace()
        Text(
            text = "下面滚动修饰符-scrollable", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
// actual composable state
        var offset by remember { mutableStateOf(0f) }
        Box(
            Modifier
                .size(150.dp)
                .scrollable(
                    orientation = Orientation.Vertical,
                    // Scrollable state: describes how to consume
                    // scrolling delta and update offset
                    state = rememberScrollableState { delta ->
                        offset += delta
                        delta
                    }
                )
                .background(Color.LightGray),
            contentAlignment = Alignment.Center
        ) {
            Text(offset.toString())
        }
        MySpace()
        Text(
            text = "下面滚动修饰符-verticalScroll", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
        val state = rememberScrollState()
        LaunchedEffect(Unit) { state.animateScrollTo(200) }

        Column(
            modifier = Modifier
                .background(Color.LightGray)
                .size(100.dp)
                .padding(horizontal = 8.dp)
                .verticalScroll(state)
        ) {
            repeat(10) {
                Text("Item $it", modifier = Modifier.padding(2.dp))
            }
        }
        MySpace()
        Text(
            text = "pointerInput", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(200.dp)
                .border(width = 1.dp, color = Color.Blue)
        ) {
            var offsetX by remember { mutableStateOf(0f) }
            var offsetY by remember { mutableStateOf(0f) }

            Box(
                Modifier
                    .offset { IntOffset(offsetX.roundToInt(), offsetY.roundToInt()) }
                    .background(Color.Blue)
                    .size(50.dp)
                    .pointerInput(Unit) {
                        detectDragGestures { change, dragAmount ->
                            change.consumeAllChanges()
                            offsetX += dragAmount.x
                            offsetY += dragAmount.y
                        }
                    }
            )
        }
        MySpace()
        Text(
            text = "Swipeable", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
        SwipeableSample()
        MySpace()

        Text(
            text = "transform缩放", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
        TransformableSample()
        MySpace()

        Text(
            text = "interactionSource", modifier = Modifier
                .padding(horizontal = 20.dp)
        )
        MySpace()
        val interactionSource = remember { MutableInteractionSource() }
        val isPressed by interactionSource.collectIsPressedAsState()

        Button(
            onClick = { /* do something */ },
            interactionSource = interactionSource
        ) {
            Text(if (isPressed) "Pressed!" else "Not pressed")
        }
        MySpace()

    }
}

@Composable
fun MySpace() {
    Spacer(modifier = Modifier.height(10.dp))
}

@Composable
fun Gesture() {
    val offset = remember { Animatable(Offset(0f, 0f), Offset.VectorConverter) }
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(100.dp)
            .border(width = 1.dp, color = Color.Blue)
            .pointerInput(Unit) {
                coroutineScope {
                    while (true) {
                        // Detect a tap event and obtain its position.
                        val position = awaitPointerEventScope {
                            awaitFirstDown().position
                        }
                        launch {
                            // Animate to the tap position.
                            offset.animateTo(position)
                        }
                    }
                }
            }
    ) {
        Box(modifier = Modifier
            .size(50.dp)
            .offset {
                Log.e("OFFSET", "${offset.value.x},${offset.value.y}")
                offset.value.toIntOffset()
            }
            .background(Color.Blue)
        )
    }
}

private fun Offset.toIntOffset() = IntOffset(x.roundToInt(), y.roundToInt())

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    AppTheme {
        Greeting("Android") {

        }
    }
}

fun Modifier.swipeToDismiss(
    onDismissed: () -> Unit
): Modifier = composed {
    val offsetX = remember { Animatable(0f) }
    pointerInput(Unit) {
        // Used to calculate fling decay.
        val decay = splineBasedDecay<Float>(this)
        // Use suspend functions for touch events and the Animatable.
        coroutineScope {
            while (true) {
                // Detect a touch down event.
                val pointerId = awaitPointerEventScope { awaitFirstDown().id }
                val velocityTracker = VelocityTracker()
                // Stop any ongoing animation.
                offsetX.stop()
                awaitPointerEventScope {
                    horizontalDrag(pointerId) { change ->
                        // Update the animation value with touch events.
                        launch {
                            offsetX.snapTo(
                                offsetX.value + change.positionChange().x
                            )
                        }
                        velocityTracker.addPosition(
                            change.uptimeMillis,
                            change.position
                        )
                    }
                }
                // No longer receiving touch events. Prepare the animation.
                val velocity = velocityTracker.calculateVelocity().x
                val targetOffsetX = decay.calculateTargetValue(
                    offsetX.value,
                    velocity
                )
                // The animation stops when it reaches the bounds.
                offsetX.updateBounds(
                    lowerBound = -size.width.toFloat(),
                    upperBound = size.width.toFloat()
                )
                launch {
                    if (targetOffsetX.absoluteValue <= size.width) {
                        // Not enough velocity; Slide back.
                        offsetX.animateTo(
                            targetValue = 0f,
                            initialVelocity = velocity
                        )
                    } else {
                        // The element was swiped away.
                        offsetX.animateDecay(velocity, decay)
                        onDismissed()
                    }
                }
            }
        }
    }
        .offset { IntOffset(offsetX.value.roundToInt(), 0) }
}

@Composable
fun SwipeableSample() {
    val width = 96.dp
    val squareSize = 48.dp

    val swipeableState = rememberSwipeableState(0)
    val sizePx = with(LocalDensity.current) { squareSize.toPx() }
    val anchors = mapOf(0f to 0, sizePx to 1) // Maps anchor points (in px) to states

    Box(
        modifier = Modifier
            .width(width)
            .swipeable(
                state = swipeableState,
                anchors = anchors,
                thresholds = { _, _ -> FractionalThreshold(0.3f) },
                orientation = Orientation.Horizontal
            )
            .background(Color.LightGray)
    ) {
        Box(
            Modifier
                .offset { IntOffset(swipeableState.offset.value.roundToInt(), 0) }
                .size(squareSize)
                .background(Color.DarkGray)
        )
    }
}

@Composable
fun TransformableSample() {
    // set up all transformation states
    var scale by remember { mutableStateOf(1f) }
    var rotation by remember { mutableStateOf(0f) }
    var offset by remember { mutableStateOf(Offset.Zero) }
    val state = rememberTransformableState { zoomChange, offsetChange, rotationChange ->
        scale *= zoomChange
        rotation += rotationChange
        offset += offsetChange
    }
    Box(
        modifier = Modifier
            .height(500.dp)
            .fillMaxWidth()
            .border(width = 1.dp, color = Color.Blue),
        contentAlignment = Alignment.Center
    ) {

        Box(
            Modifier
                // apply other transformations like rotation and zoom
                // on the pizza slice emoji
                .graphicsLayer(
                    scaleX = scale,
                    scaleY = scale,
                    rotationZ = rotation,
                    translationX = offset.x,
                    translationY = offset.y
                )
                // add transformable to listen to multitouch transformation events
                // after offset
                .transformable(state = state)
                .background(Color.Blue)
                .size(200.dp)
        )
    }

}