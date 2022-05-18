@file:OptIn(ExperimentalAnimationApi::class)

package com.example.compose

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.animation.*
import androidx.compose.animation.core.*
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import coil.compose.rememberImagePainter
import com.example.compose.ui.AppTheme
import com.example.compose.ui.purple200

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AppTheme {
                Greeting("Android")
            }
        }
    }
}

@Composable
fun Greeting(name: String = "") {
    var visible by remember {
        mutableStateOf(true)
    }
    Column {
        Image(painter = rememberImagePainter(data = R.mipmap.ic_launcher), contentDescription = "")
        Text(text = "Hello $name!")
        Canvas(modifier = Modifier
            .fillMaxWidth(1f)
            .height(100.dp), onDraw = {
            drawCircle(color = purple200)
        })
        var startPlay by remember {
            mutableStateOf(0)
        }
        val animateTween by animateIntAsState(
            targetValue = startPlay, animationSpec = tween(
                durationMillis = 2000,
                easing = LinearEasing
            )
        )
        val animateTween1 by rememberInfiniteTransition().animateFloat(
            initialValue = 0f,
            targetValue = 1f,
            animationSpec = infiniteRepeatable(
                tween(durationMillis = 1000, easing = LinearEasing),
                RepeatMode.Restart
            )
        )

        Canvas(modifier = Modifier.size(200.dp), onDraw = {
            drawLine(
                color = Color.Red,
                start = Offset(0.0f, 0.0f),
                end = Offset(200.0f * animateTween, 200.0f * animateTween),
                strokeWidth = 2f
            )
//            drawLine(color = Color.Red,
//                start = Offset(30.0f, 70.0f),
//                end = Offset(80.0f, 130.0f),
//            strokeWidth = 2f)
//            drawLine(color = Color.Red,
//                start = Offset(80.0f, 130.0f),
//                end = Offset(160.0f, 50.0f),
//                strokeWidth = 2f)
        })
        Button(onClick = {
            visible = !visible
            startPlay = 1
        }) {
            Text(
                text = "点击显示隐藏下面按钮", modifier = Modifier
                    .padding(20.dp)
            )
        }

        AnimatedVisibility(
            visible = visible,
            enter = slideInHorizontally(initialOffsetX = {
                -it
            }),
            exit = slideOutHorizontally()
        ) {
            Text(
                text = "我可以隐藏",
                Modifier
                    .background(color = Color.Gray)
                    .padding(20.dp)
            )
        }

    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    AppTheme {
        Greeting("Android")
    }
}