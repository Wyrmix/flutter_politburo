# flutter_politburo

A central flutter package to host common classes like widets that provide a DI container, etc

## Classes

### AppRouter

Wrapper for a `Fluro` router that registers all routes provides from a map the developer provides through a method implementation. These routes all get added to the `DebugDrawer` automatically with the `DebugDrawerScaffoldFactory`

### ObjectGraph

Contract for the DI container provider

#### DefaultObjectGraph

Simple implementation of the `ObjectGraph` that lets a subclass provide dependencies per `Env` in a sensible way without having to build the container manually

### DebugDrawerScaffoldFactory

Implementation of the `ScaffoldFactory` library that handles adding a debug drawer to screens if the app is in debug mode, uses the `DebugDrawer` and any `DebugDrawerSection` found in the object graph.

## Widgets

### ContainerProvider

Use this to wrap the material app in to provide a container all the way down

### ContainerConsumer

Mixin that makes accessing the container simpler

### DebugDrawer

End drawer that handles showing options to accelerate development

### Image Picker

Simple box that handles selecting an image from the gallery or camera

![Image Picker](/screenshots/image_picker.png?raw=true "Image Picker")

### Photo Picker Card Settings

`CardSettings` section that handles adding multiple images that returns a list of files as a form value

![Photo Picker Card Settings](/screenshots/photo_picker_widget.png?raw=true "Photo Picker Card Settings")

### Incubating Feature

Simple placeholder screen for screens that don't have implementations yet

![Incubating Feature](/screenshots/incubating_feature.png?raw=true "Incubating Feature")
