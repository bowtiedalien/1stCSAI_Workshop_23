<style>
    img{
        width: 50%;
    }
</style>

# Instructions for implementing the Flutter Quotes App

1. Go to this link and clone the starter code: https://github.com/bowtiedalien/virtual-factory

2. First, add the `quotes.json` file as a dependency in your `pubspec.yaml` file.

```yaml
  assets:
    - assets/quotes.json
```

> Note: if you change anything in your pubspec.yaml file or add any assets while your app is running, you will need to restart the app. Hot Reload does not work in the case of adding or removing assets or packages.

3. Run the app using the Flutter plugin, or by running `flutter run` in the terminal. You should see this output on your device:

<div float="left">
<img alt="Starter Code output - main screen" src="instructions/startercode1.jpg">

<img alt="Starter Code output - favourites screen" src="instructions/startercode2.jpg">
</div>

4. Replace the `Container` widget inside the Scaffold in the following line of code:

```dart
Center(
    child: _quotes.isEmpty
        ? const CircularProgressIndicator()
        : Container(),  // delete this widget
    ....
)
```

with a ListView widget. This is the widget that will hold our list of quotes. It should return a `ListTile` widget, which is responsible for displaying a single unit in a list view (a.k.a a single quote item).

```dart
// add a ListView widget instead
ListView.builder(
        itemBuilder: (BuildContext context, int i) {
            return ListTile(
            title: Text(_quotes[i].quoteText),
            subtitle: Text(_quotes[i].author),
            trailing: alreadySaved
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,)
                : const Icon(
                    Icons.favorite_border,),
            onTap: () {
            setState(() {
                alreadySaved
                    ? favQuotes.remove(_quotes[i])
                    : favQuotes.add(_quotes[i]);
            });
            },  //end of onTap
        );  //end of ListTile
        } // end of itemBuilder
),   // end of ListView.builder
```

5. Add this line before the return statement inside the `ListView.builder`. This is to set the value of the `alreadySaved` variable according to whether or not the quotes[] array is occupied.

```dart
    final alreadySaved = favQuotes.contains(_quotes[i]);
```

6. Now let's make the app bar change according to the current screen we're in.
Instead of this line:

```dart
return Scaffold(
    appBar: AppBar(title: const Text('My Quotes')),
    ...
);
```

Write this:

```dart
return Scaffold(	
    appBar: AppBar(	
        title: _selectedIndex == 0	
            ? const Text('My Quotes')
            : const Text('My favourites')),
        ...
);
```

7. Now take a look at favourites.dart
After the changes we did, it should be displaying a circular progress indicator, which means that indeed it sensed that the quotes[] array is now populated. We want to get the data from the quotes[] array and display it in the same way we did in main.dart. You will also use a ListView and a ListTile. Can you do this part yourself? :D 

