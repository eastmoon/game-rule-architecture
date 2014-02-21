/*
	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base actor object container.
		
	Useage:
		- AddActor 			: [public]增加Actor
		- RemoveActor 		: [public]刪除Actor
		- container 		: [Read-only]取得Actor存放容器
		
	Date:
		- 2013.03.20
		
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
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.patterns.observer.Notification;
	import org.gra.model.RuleModel.Interface.*;

    /**
     * <P>The base actor object container in Rule Model.</P>
     */
    public class RMActorContainer extends RMActor implements IRMActorContainer
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_container : Array;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMActorContainer()
		{
            //trace("RMActorContainer");
			
			// Initial container
			this.m_container = new Array();
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>IRMActor</code> in container.</P>
      	 */
		public function AddActor( a_actor : IRMActor ) : void
		{
			var isExist : Boolean = false;
			var i : Number = 0;
			if( a_actor != null )
			{
				// 避免重複物件存在
				for( i = 0 ; i < this.m_container.length ; i++ )
				{
					if( this.m_container[i] == a_actor )
						isExist = true;
				}
				
				if( !isExist )
				{
					this.m_container.push(a_actor);
					a_actor.SendNotify(new RMNotification( RMNotify.ADD_TO_ACTOR, null, this));
				}
			}
		}
		/**
     	 * <P>Remove <code>IRMActor</code> from container.</P>
      	 */
		public function RemoveActor( a_actor : IRMActor ) : void
		{
			var i : Number = 0;
			if( a_actor != null )
			{
				for( i = 0 ; i < this.m_container.length ; i++ )
				{
					if( this.m_container[i] == a_actor )
					{
						this.m_container.splice(i, 1);
						a_actor.SendNotify(new RMNotification( RMNotify.REMOVE_FROM_ACTOR, null, this));
						break;
					}
				}
			}
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>IRMActor</code> container.</P>
      	 */
		public function getContainer() : Array
		{
			return this.m_container;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}