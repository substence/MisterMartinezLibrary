package com.mistermartinez.math
{
	public class MathX
	{
		public static const DEG2RAD:Number = Math.PI/180;
		public static const RAD2DEG:Number = 180/Math.PI;
		
		public static function translate(num:Number,min1:Number,max1:Number,min2:Number,max2:Number):Number
		{
			return ((num-min1)/(max1-min1)*(max2-min2))+min2;		
		}
				
		public static function getRandomNumberBetween(min:Number, max:Number):Number
		{			
			return (Math.round(((Math.random()*(max-min))+min)*1000))/1000;			
		}
		
		public static function roundTo(num:Number, to:Number):Number
		{			
			return Math.round(num/to)*to;			
		}
		
		public static function hexcidecimalToRGB(hex:uint):Vector.<int>
		{
			var r:Number = hex >> 16;
			var temp:Number = hex ^ r << 16;
			var g:Number = temp >> 8;
			var b:Number = temp ^ g << 8;
			return Vector.<int>([r,g,b]);
		}
	}
}