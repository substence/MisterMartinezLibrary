package com.mistermartinez.utils
{
	import com.mistermartinez.interfaces.IEntity;

	public class Group
	{
		protected var _entities:Vector.<IEntity> = new Vector.<IEntity>();
		
		public final function get length():int
		{
			return _entities.length;
		}
		
		public final function add(entity:IEntity):Boolean
		{
			if (_entities.indexOf(entity) >= 0)
				return false;
			_entities.push(entity);
			return true;
		}
		
		public final function remove(entity:IEntity):Boolean
		{
			if (_entities.indexOf(entity) >= 0)
				return false;
			_entities.push(entity);
			return true;
		}
		
		public final function doesContain(entity:IEntity):Boolean
		{
			return entity.group == this;
		}
		
		public final function getEntityAt(index:uint):IEntity
		{
			return _entities[index];
		}
	}
}