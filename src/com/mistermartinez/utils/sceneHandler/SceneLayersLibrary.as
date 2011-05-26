package com.mistermartinez.utils.sceneHandler
{
	import flash.display.Sprite;

	public class SceneLayersLibrary
	{
		public static const UI:String = "uiSceneLayer";
		public static const FOREGROUND:String = "foregroundSceneLayer";
		public static const BACKGROUND:String = "backgroundSceneLayer";
		public static var ui:Sprite;
		public static var foreground:Sprite;
		public static var background:Sprite;
		
		public static function addLayers():void
		{
			background = SceneHandler.instance.addCameraLayer(BACKGROUND, new SceneLayer());
			foreground = SceneHandler.instance.addCameraLayer(FOREGROUND, new SceneLayer());
			ui = SceneHandler.instance.addCameraLayer(UI, new SceneLayer());
		}
	}
}