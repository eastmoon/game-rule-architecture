/*
	Info:
        - Game Rule Architecture model object.
        - RMNotify is support static variable for architecture.
		
	Date:
		- 2016.07.12
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameRuleArchitecture.Core.Model.Object
{
    public class RMNotify
    {
        #region Rule Model standard notify
        /**
     	 * <P>Notify initial msg to target.</P>
      	 */
        public static string INITIAL = "GameRuleArchitecture.Model.Initial";
        /**
     	 * <P>Notify update msg to target.</P>
      	 */
        public static string UPDATE = "GameRuleArchitecture.Model.Update";
		/**
     	 * <P>Notify draw msg to target.</P>
      	 */
		public static string DRAW = "GameRuleArchitecture.Model.Draw";
		/**
     	 * <P>Notify enabled msg to target, when target notify system is enabled or disabled.</P>
		 * <p>Notification body info:</p>
		 * <p>body.context</p>
		 * <p>body.params.isEnabled</p>
      	 */
		public static string ENABLED = "GameRuleArchitecture.Model.Enabled";
		#endregion
    }
}
