package co.exampro.helloworld

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Button
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import co.exampro.helloworld.ui.theme.HelloWorldTheme
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.semantics.testTagsAsResourceId

class MainActivity : ComponentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContent {
      HelloWorldTheme {
        Main()
      }
    }
  }
}
@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun Main(){
  var text by remember { mutableStateOf("Andriod") }
  Surface(
    modifier = Modifier.semantics { testTagsAsResourceId = true },
    color = MaterialTheme.colorScheme.background) {
    Column (verticalArrangement = Arrangement.spacedBy(24.dp)){
      Greeting(text)
      WorldButton {
        text = "World"
      }
    }
  }
}

@OptIn(ExperimentalComposeUiApi::class)
@Composable
fun Greeting(name: String) {
  Text(
    text = "Hello $name!",
    modifier = Modifier.semantics { testTagsAsResourceId = true; testTag = "text_hello" }

  )
}

@OptIn(ExperimentalComposeUiApi::class) 
@Composable
fun WorldButton(onClick: () -> Unit) {
  Button(
    onClick = { onClick() },
    modifier = Modifier.semantics { testTagsAsResourceId = true; testTag = "button_world" }
  ) {
    Text("World")
  }
}