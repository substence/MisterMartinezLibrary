package com.mistermartinez.utils
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.math.Vector2D;
	
	import flash.display.Sprite;

	public class Box2DHandler implements IUpdatable
	{
		private const _VELOCITY_ITERATIONS:int = 10;
		private const _POSITION_ITERATIONS:int = 10;
		public static const DRAW_SCALE:Number = 30;
		public const GRAVITY:b2Vec2 = new b2Vec2(0, 0);
		public const DO_ENTITIES_SLEEP:Boolean = true;
		public var world:b2World;
		public var timeStep:Number = 1.0 / UpdateHandler.TICKS_PER_SECOND;
		public var debugDraw:b2DebugDraw;
		private static var _instance:Box2DHandler;
		
		public static function get instance():Box2DHandler
		{
			if (!_instance)
				throw new Error("Box2DHandler must be first initialized.");      		  
			return _instance;				
		}	
		
		public static function initialize(debugSprite:Sprite = null):Box2DHandler
		{
			if (_instance)
				throw new Error("Box2DHandlerr has already been intialized, use 'getInstance()' to reference a local instance.");	   
			_instance = new Box2DHandler();
			var world:b2World = new b2World(_instance.GRAVITY, _instance.DO_ENTITIES_SLEEP);
			world.SetContactListener(new ContactListener());
			_instance.world = world;
			if (debugSprite)
			{
				var debugDraw:b2DebugDraw = new b2DebugDraw();
				debugDraw.SetSprite(debugSprite);
				debugDraw.SetDrawScale(DRAW_SCALE);
				debugDraw.SetFillAlpha(0.3);
				debugDraw.SetLineThickness(1.0);
				debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
				world.SetDebugDraw(debugDraw);
				world.DrawDebugData();
				_instance.debugDraw = debugDraw;
			}
			return _instance;
		}
		
		public function update():void
		{
			world.Step(timeStep, _VELOCITY_ITERATIONS, _POSITION_ITERATIONS);
			world.DrawDebugData();
		}
		
		public static function tob2vec2(vector2D:Vector2D):b2Vec2
		{
			return new b2Vec2(vector2D.x / DRAW_SCALE, vector2D.y / DRAW_SCALE);
		}
		
		public static function toVector2D(b2vec:b2Vec2):Vector2D
		{
			return new Vector2D(b2vec.x * DRAW_SCALE, b2vec.y * DRAW_SCALE);
		}
	}
}
import Box2D.Dynamics.Contacts.b2Contact;
import Box2D.Dynamics.b2ContactImpulse;
import Box2D.Dynamics.b2ContactListener;

import com.mistermartinez.interfaces.ICollidable;

class ContactListener extends b2ContactListener
{
	override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
	{
		var a:* = contact.GetFixtureA().GetUserData();
		var b:* = contact.GetFixtureA().GetUserData();
		if (a is ICollidable && b is ICollidable)
		{
			var aCollidable:ICollidable = ICollidable(a);
			var bCollidable:ICollidable = ICollidable(b);
			aCollidable.collided(bCollidable);
			bCollidable.collided(aCollidable);
		}
		//var count:int = contact.GetManifold().m_pointCount;
	}
}