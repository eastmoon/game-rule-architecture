/*
	Info:
        - Game Rule Architecture model object.
        - RMNotification is information object.
        - Include new information, who send this notification. 
		
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

using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Core.Model
{
    public class RMNotification : Notification, IRMNotification
    {
        #region Member variable
        private IRMNotifyDispatcher mNotifier;
        #endregion

        #region Constructor
        public RMNotification(string _name, object _body = null, IRMNotifyDispatcher _notifier = null) : base(_name, _body)
        {
            this.Notifier = _notifier;
        }
        #endregion

        #region Accessors
        /**
     	 * <P>[Read-Write]Get / Set notifier who send the <code>RMNotification</code> instance.</P>
      	 */
        public IRMNotifyDispatcher Notifier {
            get
            {
                return this.mNotifier;
            }
            set
            {
                this.mNotifier = value;
            }
        }
        #endregion 
    }
}
