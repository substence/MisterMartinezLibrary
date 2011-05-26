package com.mistermartinez.entities
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.mistermartinez.interfaces.IDrawable;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.Box2DHandler;
	
	import flash.display.DisplayObject;
	
	public class b2VisibleEntity extends b2Entity implements IDrawable
	{
		protected var _graphic:DisplayObject;
		
		public function b2VisibleEntity(position:Vector2D = null, graphic:DisplayObject = null, isBullet:Boolean = false)
		{
			super(position, isBullet);
			if (graphic)
			{
				_graphic = graphic;
				addShapeFromDisplayObject(graphic);
			}
		}
		
		public function get graphic():DisplayObject
		{
			return _graphic;
		}
		
		public function set graphic(value:DisplayObject):void
		{
			_graphic = value;
		}			
		
		public function draw():void
		{
			if (_graphic && _body)
			{
				var position:b2Vec2 = _body.GetWorldCenter();
				var drawScale:Number = Box2DHandler.DRAW_SCALE;
				_graphic.x = position.x * drawScale;
				_graphic.y = position.y * drawScale;
				_graphic.rotation = _body.GetAngle();
			}
		}
		
		override public function update():void
		{
			super.update();
			draw();
		}
		
		public function addShapeFromDisplayObject(displayObject:DisplayObject):b2Fixture
		{
			return addFixture(createFixtureDefinition(getShapeFromDisplayObject(displayObject)));
		}
		
		public static function getShapeFromDisplayObject(displayObject:DisplayObject):b2PolygonShape
		{
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(displayObject.width * .5 / Box2DHandler.DRAW_SCALE, displayObject.height *.5 / Box2DHandler.DRAW_SCALE);
			return polygonShape;
		}
	}
}