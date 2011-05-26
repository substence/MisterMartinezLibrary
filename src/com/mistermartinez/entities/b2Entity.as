package com.mistermartinez.entities
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.mistermartinez.interfaces.IAdvancedSpatial;
	import com.mistermartinez.interfaces.IBound;
	import com.mistermartinez.interfaces.IBox2D;
	import com.mistermartinez.interfaces.ICollidable;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.Box2DHandler;
	import com.mistermartinez.utils.sceneHandler.SceneHandler;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class b2Entity extends Entity implements IAdvancedSpatial, IBound, IBox2D
	{
		protected var _body:b2Body;
		protected var _bodyDefinition:b2BodyDef;
		protected var _bounds:Rectangle;
		
		public function b2Entity(position:Vector2D = null, isBullet:Boolean = false)
		{
			_bodyDefinition = new b2BodyDef();
			position = position.divide(Box2DHandler.DRAW_SCALE);
			_bodyDefinition.position = new b2Vec2(position.x, position.y);
			_bodyDefinition.userData = this;
			_bodyDefinition.fixedRotation = true;
			_bodyDefinition.bullet = isBullet;
			_bodyDefinition.type = b2Body.b2_dynamicBody;
			_bounds = SceneHandler.instance.camera.bounds;
		}
		
		override public function initialize(name:String = null):void
		{
			if (_body)
				return;
			super.initialize(name);
			_body = Box2DHandler.instance.world.CreateBody(_bodyDefinition);
		}
		
		public function addFixture(fixtureDefinition:b2FixtureDef):b2Fixture
		{
			if (!_body)
				initialize();
			var fixture:b2Fixture = _body.CreateFixture(fixtureDefinition);
			fixture.SetUserData(this);
			return fixture;
		}
				
		public static function createFixtureDefinition(shape:b2Shape, friction:Number = 0.5, density:Number = 1.0, restitution:Number = 0.2, isSensor:Boolean = false, filterData:b2FilterData = null):b2FixtureDef
		{
			var fixtureDefinition:b2FixtureDef = new b2FixtureDef();
			fixtureDefinition.isSensor = isSensor;
			if (filterData)
				fixtureDefinition.filter = filterData;
			fixtureDefinition.shape = shape;
			fixtureDefinition.friction = friction;
			fixtureDefinition.density = density;
			fixtureDefinition.restitution = restitution;
			return fixtureDefinition;
		}
		
		public function applyForce(force:Vector2D):void
		{
			_body.ApplyImpulse(Box2DHandler.tob2vec2(force), _body.GetWorldCenter());
		}
		
		public function collided(into:ICollidable):Boolean
		{
			return true;
		}
		
		public function get body():b2Body
		{
			return _body;
		}
		
		public function get damping():Number
		{
			return _body.GetLinearDamping();
		}
		
		public function get velocity():Vector2D
		{
			return Box2DHandler.toVector2D(_body.GetLinearVelocity())
		}
		
		public function get mass():Number
		{
			return _body.GetMass();
		}
		
		public function set position(value:Vector2D):void
		{
			_body.SetPosition(Box2DHandler.tob2vec2(value));
		}
		
		public function get position():Vector2D
		{
			return Box2DHandler.toVector2D(_body.GetWorldCenter());
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function get hitBox():Rectangle
		{
			var position:b2Vec2 = _body.GetWorldCenter();
			position.Multiply(Box2DHandler.DRAW_SCALE);
			return new Rectangle(position.x, position.y, 0, 0);
		}
	}
}