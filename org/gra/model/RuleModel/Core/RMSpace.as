/*
	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base space object.
		
	Useage:
		- AddActor 			: [public]增加Actor
		- RemoveActor 		: [public]刪除Actor
		- actors 			: [Read-only]取得Actor存放容器
		
	Date:
		- 2014.02.20
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Core
{	
	
	/*import：Flash內建元件庫*/
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.*;
	
    /**
     * <P>Tha base space object in Rule Model.</P>
     */
	 
    public class RMSpace extends RMNotifyDispatcher implements IRMSpace, IRMSpaceVar
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_actorContainer : Array;
		private var m_spaceVar : IRMSpaceVar;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMSpace( a_spaceVar : IRMSpaceVar = null )
		{
            //trace("RMSpace");
			// Initial space variable
			if( a_spaceVar == null )
				this.setSpaceVar( new RMSpaceVar() );
			this.setSpaceVar( a_spaceVar );
			
			// Initial container
			this.m_actorContainer = new Array();
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>IRMActor</code> in RMSpace.</P>
      	 */
		public function AddActor( a_actor : IRMActor, a_var : IRMSpaceVar = null ) : void
		{
			var isExist : Boolean = false;
			var i : Number = 0;
			if( a_actor != null )
			{
				// 避免重複物件存在
				for( i = 0 ; i < this.m_actorContainer.length ; i++ )
				{
					if( this.m_actorContainer[i] == a_actor )
						isExist = true;
				}
				
				if( !isExist )
				{
					this.m_actorContainer.push(a_actor);
					if( a_var == null )
						a_var = new RMSpaceVar( 0, 0, 0, 0, 0, 0, this, this.getName() );
					a_actor.SendNotify(new RMNotification( RMNotify.ADD_TO_SPACE, null, a_var ));
				}
			}
		}
		
		/**
     	 * <P>Remove <code>IRMActor</code> from RMSpace.</P>
      	 */
		public function RemoveActor( a_actor : IRMActor ) : void
		{
			var i : Number = 0;
			if( a_actor != null )
			{
				for( i = 0 ; i < this.m_actorContainer.length ; i++ )
				{
					if( this.m_actorContainer[i] == a_actor )
					{
						this.m_actorContainer.splice(i, 1);
						a_actor.SendNotify(new RMNotification( RMNotify.REMOVE_FROM_SPACE, null, this ));
						break;
					}
				}
			}
		}
		
		/**
     	 * <P>Transform global coordinate to the RMSpace coordinate.</P>
      	 */
		public function TransformCoordinate( a_spaceVar : IRMSpaceVar ) : IRMSpaceVar
		{
			return null;
		}
		
		/**
     	 * <P>Retrieve all object ( <code>IRMActor</code> or <code>IRMSpace</code> ) in the RMSpace.</P>
      	 */
		public function RetrieveObject( a_spaceVar : IRMSpaceVar ) : Array
		{
			return null;
		}
		/**
     	 * <P>Override function, Set a name and <code>RMModule</code> who is this <code>RMModule</code> object already registered in.</p>
      	 */
		public override function RegisterInfo( a_name : String = "" , a_model : IRMModule = null) : void
		{
			if( a_model != null && a_model.HasSpace( a_name ) )
				super.RegisterInfo(a_name, a_model);
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>IRMActor</code> container.</P>
      	 */
		public function getActors() : Array
		{
			return this.m_actorContainer;
		}
		/**
    	 * <P>Implement IRMSpaceVars : Take back <code>RMSpace</code> object point.</P>
     	*/
		public function getSpace() : IRMSpace
		{
			return this;
		}
		/**read/write：讀寫*/
		/**
    	 * <P>Protected function : Set and Get ths space variable, it only use with inherit class.</P>
     	 */
		protected function setSpaceVar( a_spaceVar : IRMSpaceVar ) : void
		{
			this.m_spaceVar = a_spaceVar;
		}
		protected function getSpaceVar() : IRMSpaceVar
		{
			return this.m_spaceVar;
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths location.x .</P>
     	 */
		public function setX( a_value : Number ) : void
		{
			this.m_spaceVar.setX( a_value );
		}
		public function getX() : Number
		{
			return this.m_spaceVar.getX();
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths location.y .</P>
     	 */
		public function setY( a_value : Number ) : void
		{
			this.m_spaceVar.setY( a_value );
		}
		public function getY() : Number
		{
			return this.m_spaceVar.getY();
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths location.z .</P>
     	 */
		public function setZ( a_value : Number ) : void
		{
			this.m_spaceVar.setZ( a_value );
		}
		public function getZ() : Number
		{
			return this.m_spaceVar.getZ();
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths Size.width .</P>
     	 */
		public function setWidth( a_value : Number ) : void
		{
			this.m_spaceVar.setWidth( a_value );
		}
		public function getWidth() : Number
		{
			return this.m_spaceVar.getWidth();
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths Size.height .</P>
     	 */
		public function setHeight( a_value : Number ) : void
		{
			this.m_spaceVar.setHeight( a_value );
		}
		public function getHeight() : Number
		{
			return this.m_spaceVar.getHeight();
		}
		/**
    	 * <P>Implement IRMSpaceVars : Set and Get ths Size.depth .</P>
     	 */
		public function setDepth( a_value : Number ) : void
		{
			this.m_spaceVar.setDepth( a_value );
		}
		public function getDepth() : Number
		{
			return this.m_spaceVar.getDepth();
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}