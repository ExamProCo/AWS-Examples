# Andriod Env Vars Exported

In order for Appium to work it needs to know where Andriod is.
Open .bash_profile and update.

```sh
export ANDROID_HOME ~/Library/Android/sdk
export PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
```

> Mac example above

https://developer.android.com/tools/variables


# Run Appium

Before you can run your tests you need to ensure Appium is running

```sh
appium
```

> Default port for Appium is 4723

# Run Test Suite Locally

```
bundle exec ruby main.rb
```

## References

https://docs.aws.amazon.com/devicefarm/latest/developerguide/test-types-appium.html
https://appium.io/docs/en/2.0/quickstart/test-rb/
