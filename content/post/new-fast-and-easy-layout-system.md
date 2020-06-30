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

## Immediate vs Retained

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

**Retained GUI**: _First_, the client _describes_ to the graphics library what they want to render and how, for example:

    <VerticalStack>
    	<Text Name="text1">Hello, world 123</Text>
    	<Button Name="btn1">Save</Button>
        <TextBox Name="textBox1" Size=40 />
        <Slider Name="mySlider" Min=0 Max=1 />
    </VerticalStack>

_Then_, the client makes sure

## UI Library Goals

1. Simple
2. High performance
3. Easy to style
4. Easy to extend with custom widgets
5. Advanced effects - blur, frosted glass, shaders
6. Animation

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