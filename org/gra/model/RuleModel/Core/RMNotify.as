/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2013.08.29
		
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
	
    /**
     * <P>The event dispatcher in Actor-Space-Event Model.</P>
     */
	 
    public class RMNotify extends RMObject
    {
        /**static const variable : 靜態常數變數*/
		// Rule Model standard notify
		/**
     	 * <P>Notify initial msg to target.</P>
      	 */
		public static const INITIAL : String = "RuleModelInitial";
		/**
     	 * <P>Notify update msg to target.</P>
      	 */
		public static const UPDATE : String = "RuleModelUpdate";
		/**
     	 * <P>Notify draw msg to target.</P>
      	 */
		public static const DRAW : String = "RuleModelDraw";
		/**
     	 * <P>Notify enabled msg to target, when target notify system is enabled or disabled.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.isEnabled</p>
      	 */
		public static const ENABLED : String = "RuleModelEnabled";
		// Rule Model object notify
		/**
     	 * <P>Add <code>RMActor</code> or <code>RMSpace</code> to <code>RMSpace</code> or <code>RMSpaceContainer</code>.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.space</p>
      	 */
		public static const ADD_TO_SPACE : String = "RuleModelAddToSpace";
		/**
     	 * <P>Remove <code>RMActor</code> or <code>RMSpace</code> from <code>RMSpace</code> or <code>RMSpaceContainer</code>.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.space</p>
      	 */
		public static const REMOVE_FROM_SPACE : String = "RuleModelRemoveFromSpace";
		/**
     	 * <P>Add <code>RMActor</code> to <code>RMActorContainer</code>.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.actor</p>
      	 */
		public static const ADD_TO_ACTOR : String = "RuleModelAddToSpace";
		/**
     	 * <P>Remove <code>RMActor</code> from <code>RMActorContainer</code>.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.actor</p>
      	 */
		public static const REMOVE_FROM_ACTOR : String = "RuleModelRemoveFromActor";
		// Rule Model event notify
		public static const EVENT_START : String = "RuleModelEventStart";
		public static const EVENT_COMPLETE : String = "RuleModelEventComplete";
		
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMNotify()
		{
        }
		
		/**public function：對外公開函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}