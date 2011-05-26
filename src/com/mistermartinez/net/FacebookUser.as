package com.mistermartinez.net
{
	public class FacebookUser
	{
		public var firstName:String;
		public var lastName:String;
		public var gender:String;
		public var id:String;
		public var link:String;
		public var locale:String;
		public var timezone:Number;
		public var updatedTime:String;
		public var isVerified:Boolean;
		//
		public var isFilled:Boolean;
		
		public function FacebookUser(userObject:Object)
		{
			isFilled = false;
			parseUserObject(userObject);
		}
		
		public function parseUserObject(userObject:Object):void
		{
			firstName = userObject.first_name;
			lastName = userObject.last_name;
			gender = userObject.gender;
			id = userObject.id;
			link = userObject.link;
			locale = userObject.locale;
			timezone = userObject.timezone;
			updatedTime = userObject.updated_time;
			isVerified = userObject.verified;
			isFilled = true;
		}
		
		public function get fullName():String
		{
			return firstName + " " + lastName;
		}
	}
}