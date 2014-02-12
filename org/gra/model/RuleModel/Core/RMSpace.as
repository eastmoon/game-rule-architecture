/*
	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base space object.
		
	Useage:
		- AddActor 			: [public]增加Actor
		- RemoveActor 		: [public]刪除Actor
		- actors 			: [Read-only]取得Actor存放容器
		
	Date:
		- 2013.03.14
		
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
	 
    public class RMSpace extends RMNotifyDispatcher implements IRMSpace
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_actorContainer : Array;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMSpace()
		{
            //trace("RMSpace");
			// Initial container
			this.m_actorContainer = new Array();
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>RMActor</code> in RMSpace.</P>
      	 */
		public function AddActor( a_actor : IRMActor ) : void
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
					a_actor.SendNotify(new RMNotification( RMNotify.ADD_TO_SPACE, null, this ));
				}
			}
		}
		
		/**
     	 * <P>Remove <code>RMActor</code> from RMSpace.</P>
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
     	 * <P>Change Actor corrdinate to Space corrdinate.</P>
      	 */
		public function SpaceCoordinate( a_local : Point ) : Point
		{
			return null;
		}
		
		/**
     	 * <P>Retrieve all object ( <code>RMActor</code> or <code>RMSpace</code> ) in the range.</P>
      	 */
		public function RetrieveRangeObject( a_rect : Rectangle ) : Array
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
     	 * <P>[Read-only]Get <code>RMActor</code> container.</P>
      	 */
		public function getActors() : Array
		{
			return this.m_actorContainer;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}