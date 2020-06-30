+++
date = 2020-06-27T07:00:00Z
draft = true
featured_image = ""
title = "GUI of the Third Kind"

+++
In this post I'll discuss the pros and cons of immediate and retained GUIs and propose a new, third kind of "fused UI" in an attempt to make a future-ready UI paradigm that combines the pros of both immediate and retained modes, and less of the cons.

Before we start, see this

## TL; DR; Example of Fused UI

    TODO

## A Short History: Immediate vs Retained UI

Today, there are two kinds of GUI implementations:

**Immediate GUI**: the client calls a set of commands to draw UI on each frame, for [example](https://github.com/ocornut/imgui):

    ImGui::Text("Hello, world %d", 123);
    if (ImGui::Button("Save"))
        MySaveFunction();
    ImGui::InputText("string", buf, IM_ARRAYSIZE(buf));
    ImGui::SliderFloat("float", &f, 0.0f, 1.0f);

One big benefit of immediate mode GUI is that the client does not need to use a specific way to transfer the client's app state (e.g. "slider X value") to match a state from the GUI. Instead the client "draws" the GUI by calling a command that uses the client's state directly.

The huge drawback of immediate mode GUIs is that layout is [hard](https://github.com/ocornut/imgui/issues/97). [Really](https://github.com/ocornut/imgui/issues/857). [Hard](https://twitter.com/ocornut/status/950821285004759042?lang=en). The links are from Dear ImGui - one of the most popular imgui implementations. One of these open issues with simple layouts has been around since 2014.

Another drawback of imgui-s is that even though they are stylable, they are not easy to style. That's why most imgui users create cookie-cutter UIs.

The second kind of GUI is:

**Retained GUI**: _First_, the client _describes_ to the graphics library what they want to render and how. The same example from above may look something like this:

    <VerticalStack>
    	<Text Name="text1">Hello, world 123</Text>
    	<Button Name="btn1">Save</Button>
        <TextBox Name="textBox1" Size=40 />
        <Slider Name="mySlider" Min=0 Max=1 />
    </VerticalStack>

_Then_, the client makes sure that the UI events and data is updated:

    text1.Text = "Hello world 12345"; // somewhere in code
    btn1.Click = () => {
       // ... handle button click
    }
    mySlider.OnSlide = (newValue: float) => {
       // ... handle slider slided
    }
    textBox1.OnTextChanged = (newText: string) => {
       // ... handle new text entered by user
    }

Amongst the biggest benefits of retained UI the ability to express _UI only_ which makes it easier to reason about how a UI should look and easier for design tools to help with drag-drop UI. Another benefit is theme-ability and much easier layout support (such as grid views, flex views.)

A big drawback of retained UI is that now the _UI retains a state of the app that must be synchronized with the actual app state_. For example, in immediate mode a slider value is populated directly when the slider is created and is transient - valid for one frame. In retained mode, both the GUI library and the app have a value that is associated with a single slider. It's harder to keep these values in sync, which gives rise of workarounds through like design patterns like MVVM or MVC.

Another drawback of retained UI is that _it's by default slower. _If you try displaying 10,000 elements in retained UI, each element will take up space in memory, and maybe participate in layout even if only 10 of those are visible on screen. Contrast with immediate mode UI where the only elements being drawn are the ones visible on screen, and anything else does not have a GUI representation.

With those in mind, is it possible to make a GUI that combines both the benefits of immediate UI (single state and speed) and retained UI (easy theming and layout?)

Before we go deeper, let's look at what we'd like our ideal UI library to have.

## UI Library Goals

1. Simple to use
2. High performance
3. Easy to style
4. Easy to extend with custom widgets
5. Advanced effects - blur, frosted glass, shaders
6. Animation

## What is UI?

## Layout

Layout is just a function that takes 

There are two types of layout:

1. Built-as-we-go: 

**What makes a good layout system?**

**Can we have a third kind?**

**On technical level, UI is just a way to track and display state**

    draw(app_state, ui_state, presentation);

**app_state:** the state that the user of the GUI library cares about. For example - is an option selected, what text did the human type, etc.

**ui_state:** the internal state of the GUI library. For example: which control is hovered, pressed, focused. Which treeview node is expanded and which one is collapsed.

presentation: 

**Widget == Drawing + Behavior + Layout**

**Examples**