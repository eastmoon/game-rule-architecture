/*
	Info:
		- Re design binding structure, that observer could call public, protected, private method. 
	
    Date:
		- 2016.07.20
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
using System;
using System.Reflection;

using PureMVC.Interfaces;
using PureMVC.Patterns;

namespace GameRuleArchitecture.Patterns
{
    public class CommonObserver : Observer
    {
        #region Member variable
        private string mNotifyMethod;
        private object mNotifyContext;
        private BindingFlags mFlags;
        #endregion

        #region Constructor
        public CommonObserver(string _notifyMethod, object _notifyContext) : base(_notifyMethod, _notifyContext)
        {
            this.mNotifyMethod = _notifyMethod;
            this.mNotifyContext = _notifyContext;
            this.Flags = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.IgnoreCase;
        }
        #endregion

        #region Public Methods

        #region IObserver Members

        /// <summary>
        /// Notify the interested object
        /// </summary>
        /// <remarks>This method is thread safe</remarks>
        /// <param name="notification">The <c>INotification</c> to pass to the interested object's notification method</param>
        public override void NotifyObserver(INotification notification)
        {
            object context;
            string method;
            BindingFlags flags;

            // Retrieve the current state of the object, then notify outside of our thread safe block
            lock (m_syncRoot)
            {
                context = this.mNotifyContext;
                method = this.mNotifyMethod;
                flags = this.mFlags;
            }

            Type t = context.GetType();
            MethodInfo mi = t.GetMethod(method, flags);
            mi.Invoke(context, new object[] { notification });
        }

        #endregion

        #endregion

        #region Accessors

        /// <summary>
        /// The binding flags define, that is what type of notification (callback) method of the interested object.
        /// </summary>
        /// <remarks>https://msdn.microsoft.com/en-us/library/system.reflection.bindingflags.aspx</remarks>
        public virtual BindingFlags Flags
        {
            get
            {
                // Setting and getting of reference types is atomic, no need to lock here
                return mFlags;
            }
            set
            {
                // Setting and getting of reference types is atomic, no need to lock here
                this.mFlags = value;
            }
        }

        #endregion
    }
}
