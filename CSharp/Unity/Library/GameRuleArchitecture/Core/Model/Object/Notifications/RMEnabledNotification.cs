/*
	Info:
        - Game Rule Architecture model object.
        - RMEnabledNotification is information object.
        - Use on notify RMNotify.ENABLED. 
		
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

using GameRuleArchitecture.Core.Model.Interface;
using GameRuleArchitecture.Core.Model.Object;

namespace GameRuleArchitecture.Core.Model.Object.Notifications
{
    public class RMEnabledNotification : RMNotification
    {
        #region Variable member
        private bool mEnabled;
        #endregion

        #region Constructor
        public RMEnabledNotification(object _body = null, IRMNotifyDispatcher _notifier = null) : base(RMNotify.ENABLED, _body, _notifier)
        {
            this.Enabled = false;
        }
        #endregion

        #region Public Method
        public RMEnabledNotification SetEnabled(bool _value)
        {
            this.Enabled = _value;
            return this;
        }
        #endregion
        
        #region Accessors
        /**
     	 * <P>[Read-Write]Get / Set notifier who send the <code>RMNotification</code> instance.</P>
      	 */
        public bool Enabled
        {
            get
            {
                return this.mEnabled;
            }
            set
            {
                this.mEnabled = value;
            }
        }
        #endregion 
    }
}
