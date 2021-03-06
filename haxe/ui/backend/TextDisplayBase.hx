package haxe.ui.backend;

import flixel.math.FlxRect;
import flixel.text.FlxText;
import haxe.ui.core.Component;
import haxe.ui.styles.Style;

class TextDisplayBase extends FlxText {
	
    public var parent:Component;
    
    public function new() {
        super();
    }

    public var left:Float;
    public var top:Float;

    public var textWidth(get, null):Float;
    inline function get_textWidth():Float { return textField.textWidth + 4; }

    public var textHeight(get, null):Float;
    inline function get_textHeight():Float { return textField.textHeight + 4; }

	/*
    public var fontName(get, set):String;
    inline function get_fontName():String { return embedded ? font : systemFont; }
    inline function set_fontName(value:String):String {
		
        if (isEmbeddedFont(value)) font = value;
		else systemFont = value;
		
        return value;
    }
	
	

    public var fontSize(get, set):Null<Float>;
    inline function get_fontSize():Null<Float> { return size; }
    inline function set_fontSize(value:Null<Float>):Null<Float> { return size = Std.int(value); }
	
    public var textAlign:String;
	*/
	
	public function applyStyle(style:Style):Void {
		
		// color, bold, italics, underline, etc
		
		if (style.width != null) {
			autoSize = false;
			fieldWidth = style.width;
		}
		
		if (style.fontName != null) {
			if (isEmbeddedFont(style.fontName)) font = style.fontName;
			else systemFont = style.fontName;
		}
		
		if (style.fontSize != null) {
			size = Std.int(style.fontSize);
		}
		
		if (style.textAlign != null) {
			alignment = style.textAlign;
		}
	}
	
	override function set_text(Text:String):String {
		
		var tempRect = clipRect;
		
		super.set_text(Text);
		
		clipRect = tempRect;
		
		return Text;
	}
	
	override function set_clipRect(rect:FlxRect):FlxRect {
		
		if (rect != null) 
			regenGraphic();
		
		return super.set_clipRect(rect);
	}
	
	override public function draw():Void {
		
		if (dirty) {
			x = left = parent.screenLeft;
			y = top = parent.screenTop;
		}
		
		super.draw();
	}
	
	inline function isEmbeddedFont(name:String):Bool {
        return name != "_sans" && name != "_serif" && name != "_typewriter";
    }
}