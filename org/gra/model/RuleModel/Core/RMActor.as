/*
	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base actor object.
		
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
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.patterns.observer.Notification;
	import org.gra.model.RuleModel.Interface.*;
	import org.gra.model.RuleModel.Pattern.Observer.ObserverManager;
	 
    /**
     * <P>The base actor object in Rule Model.</P>
     */
	 
    public class RMActor extends RMNotifyDispatcher implements IRMActor
    {
        /**static const variable : 靜態常數變數*/
		
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_spaceVarContainer : Object;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMActor()
		{
            //trace("RMActor");
			// Initial variable
			// Initial container
			this.m_spaceVarContainer = new Object();
			// Initial notify
			this.AddNotify(RMNotify.ADD_TO_SPACE, onNotifyAddSpace);
			this.AddNotify(RMNotify.REMOVE_FROM_SPACE, onNotifyRemoveSpace);
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Override function, Set a name and <code>RMModule</code> who is this <code>RMModule</code> object already registered in.</p>
      	 */
		public override function RegisterInfo( a_name : String = "" , a_model : IRMModule = null) : void
		{
			if( a_model != null && a_model.HasActor( a_name ) )
				super.RegisterInfo(a_name, a_model);
		}
		/**
     	 * <P>Retrieve a <code>RMSpace</code> that this <code>RMActor</code> addation.</p>
      	 */
		public function RetrieveSpaceVar( a_name : String ) : IRMSpaceVar
		{
			if( this.m_spaceVarContainer[ a_name ] != undefined )
				return this.m_spaceVarContainer[ a_name ] as IRMSpaceVar;
			return null;
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>ASESpace</code> container list.</P>
      	 */
		public function getSpaces() : Array
		{
			var list : Array = new Array();
			var spaceName : String = "";
			for( spaceName in this.m_spaceVarContainer )
			{
				list.push( this.m_spaceVarContainer[ spaceName ] );
			}
			return list;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		private function onNotifyAddSpace( a_notify : IRMNotification ) : void
		{
			var isExist : Boolean = false;
			var targetSpace : IRMSpace = a_notify.getNotifier() as IRMSpace;
			if( targetSpace != null )
			{
				// 避免重複物件存在
				if( this.m_spaceVarContainer[ targetSpace.getName() ] == undefined || this.m_spaceVarContainer[ targetSpace.getName() ] == null )
				{
					this.m_spaceVarContainer[ targetSpace.getName() ] = new RMSpaceVar( targetSpace.getName(), targetSpace );
				}
			}
		}
		private function onNotifyRemoveSpace( a_notify : IRMNotification ) : void
		{
			var i : Number = 0;
			var targetSpace : IRMSpace = a_notify.getNotifier() as IRMSpace;
			if( targetSpace != null && this.m_spaceVarContainer[ targetSpace.getName() ] != undefined && this.m_spaceVarContainer[ targetSpace.getName() ] != null )
			{
				this.m_spaceVarContainer[ targetSpace.getName() ] = null;
				targetSpace = null;
			}
		}
		/**javascript const variable：JavaScript 常數變數*/
    }
}