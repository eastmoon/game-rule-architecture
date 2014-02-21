/*

	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base space object conatiner.
		
	Useage:
		- AddSpace 			: [public]增加Space
		- RemoveSpace 		: [public]刪除Space
		- container 		: [Read-only]取得Space存放容器
		
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
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.*;
	 
    /**
     * <P>The base space object conatiner in Actor-Space-Event Model.</P>
     */
    public class RMSpaceContainer extends RMSpace implements IRMSpaceContainer
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_container : Array;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMSpaceContainer( a_spaceVar : IRMSpaceVar = null )
		{
            //trace("RMSpaceContainer");
			
			// Initial space variable
			if( a_spaceVar == null )
				this.setSpaceVar( new RMSpaceVar() );
			this.setSpaceVar( a_spaceVar );
			// Initial container
			this.m_container = new Array();
			// Initial notify
			this.AddNotify(RMNotify.INITIAL, this.onNotifyInitial);
			this.AddNotify(RMNotify.ENABLED, this.onNotifyEnabled);
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>RMSpace</code> in container</P>
      	 */
		public function AddSpace( a_space : IRMSpace ) : void
		{
			var isExist : Boolean = false;
			var i : Number = 0;
			if( a_space != null )
			{
				// 避免重複物件存在
				for( i = 0 ; i < this.m_container.length ; i++ )
				{
					if( this.m_container[i] == a_space )
						isExist = true;
				}
				
				if( !isExist )
				{
					this.m_container.push(a_space);
					a_space.SendNotify(new RMNotification( RMNotify.ADD_TO_SPACE, null, this));
				}
			}
		}
		/**
     	 * <P>Remove <code>RMSpace</code> from container</P>
      	 */
		public function RemoveSpace( a_space : IRMSpace ) : void
		{
			var i : Number = 0;
			if( a_space != null )
			{
				for( i = 0 ; i < this.m_container.length ; i++ )
				{
					if( this.m_container[i] == a_space )
					{
						this.m_container.splice(i, 1);
						a_space.SendNotify(new RMNotification( RMNotify.REMOVE_FROM_SPACE, null, this));
						break;
					}
				}
			}
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>RMSpace</code> container.</P>
      	 */
		public function getContainer() : Array
		{
			return this.m_container;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**
     	 * <P>Initial all sub-space in <code>RMSpaceContainer</code>.</P>
      	 */
		private function onNotifyInitial( a_notify : IRMNotification ) : void
		{
			var i : Number = 0;
			// 執行子單元
			for( i = 0 ; i < this.m_container.length ; i++ )
				(this.m_container[i] as RMNotifyDispatcher).SendNotify(new RMNotification(RMNotify.INITIAL));
		}
		/**
     	 * <P>Enabled all sub-space in <code>RMSpaceContainer</code>.</P>
      	 */
		private function onNotifyEnabled( a_notify : IRMNotification ) : void
		{
			var i : Number = 0;
			// 執行子單元
			// ※此階段，本物件的onNotifyEnabled已經完成enabled，因此無需使用getBody()取得送入參數
			for( i = 0 ; i < this.m_container.length ; i++ )
				(this.m_container[i] as IRMNotifyDispatcher).setEnabledNotify( this.getEnabledNotify() );
		}
		/**javascript const variable：JavaScript 常數變數*/
    }
}