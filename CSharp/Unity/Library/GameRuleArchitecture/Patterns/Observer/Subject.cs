/*
	Info:
		- The subject of observer.
        - Observer container, if observer's has the same topic but different method need to execute. 
	Date:
		- 2016.07.05
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Interfaces;
using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Patterns
{
    public class Subject : CommonObserver, ISubject
    {
        #region Member variable
        private string mNotificationName;
        private ArrayList mObservers;
        #endregion

        #region Constructors

        /// <summary>
        /// Constructs a new Subject with the specified notification name.
        /// </summary>
        /// <param name="_notificationName">The notification name of the Subject</param>
        public Subject(string _notificationName) : base(null, null)
        {
            // Setting subject notification topic.
            this.mNotificationName = _notificationName;
            this.mObservers = new ArrayList();
        }

        #endregion


        #region Public Methods

        #region Subject Members
        /// <summary>
        /// Register observer in subject.
        /// </summary>
        public bool Register(Action<INotification> _action)
        {
            return this.Register(_action.Method.Name, _action.Target);
        }
        public bool Register(string _method, object _context)
        {
            if(_context != null)
                return this.Register(new ObserverInfo(_method, _context));
            return false;
        }
        public bool Register(string _method, object _context, IObserver _observer)
        {
            if (_context != null)
                return this.Register(new ObserverInfo(_method, _context, _observer));
            return false;
        }

        /// <summary>
        /// Remove observer in subject.
        /// </summary>
        public bool Remove(Action<INotification> _action)
        {
            return this.Remove(_action.Method.Name, _action.Target);
        }
        public bool Remove(string _method, object _context)
        {
            ObserverInfo info = this.RetrieveInfo(_method, _context);
            if(info != null)
            {
                // remove info in array list.
                this.mObservers.Remove(info);
                // clear observer info
                info = null;
                return true;
            }
            return false;
        }

        /// <summary>
        /// Check observer in subject.
        /// </summary>
        public bool Has(Action<INotification> _action)
        {
            return this.Has(_action.Method.Name, _action.Target);
        }
        public bool Has(string _method, object _context)
        {
            return this.RetrieveInfo(_method, _context) != null;
        }

        /// <summary>
        /// Retrieve observer in subject.
        /// </summary>
        public IObserver Retrieve(Action<INotification> _action)
        {
            return this.Retrieve(_action.Method.Name, _action.Target);
        }
        public IObserver Retrieve(string _method, object _context)
        {
            ObserverInfo info = this.RetrieveInfo(_method, _context);
            if (info != null)
                return info.Observer;
            return null;
        }
        #endregion

        #region IObserver Members

        /// <summary>
        /// Notify the interested object
        /// </summary>
        /// <remarks>This method is thread safe</remarks>
        /// <param name="notification">The <c>INotification</c> to pass to the interested object's notification method</param>
        public override void NotifyObserver(INotification _notification)
        {
            // Check notification is send to right subject. 
            if (_notification != null && this.mNotificationName.Equals(_notification.Name))
            {
                // Send notification to all observer in the subject.
                for (int i = 0; i < this.mObservers.Count; i++)
                {
                    ObserverInfo info = this.mObservers[i] as ObserverInfo;
                    if (info != null && info.Observer != null)
                    {
                        info.Observer.NotifyObserver(_notification);
                    }
                }
            }
        }

        #endregion

        #endregion

        #region Private method

        #region Subject Members
        /// <summary>
        /// Register observer info in subject.
        /// </summary>
        private bool Register(ObserverInfo _info)
        {
            //skip dupilcates
            bool isDuplicate = false;

            for (int i = 0; i < this.mObservers.Count && !isDuplicate; i++)
            {
                ObserverInfo info = this.mObservers[i] as ObserverInfo;
                if (info != null && info.CompareInfo(_info))
                    isDuplicate = true;
            }

            // register
            if (!isDuplicate)
                this.mObservers.Add(_info);

            // return duplicate state.
            return isDuplicate;
        }

        /// <summary>
        /// Retrieve observer info in subject.
        /// </summary>
        private ObserverInfo RetrieveInfo(string _method, object _context)
        {
            for (int i = 0; i < this.mObservers.Count; i++)
            {
                // find observer info in list
                ObserverInfo info = this.mObservers[i] as ObserverInfo;
                if (info.CompareInfo(_method, _context))
                {
                    return info;
                }
            }
            return null;
        }
        #endregion

        #endregion

        #region Accessors

        /// <summary>
        /// The notification name of the subject.
        /// </summary>
        public virtual string NotificaionName
        {
            get
            {
                // Setting and getting of reference types is atomic, no need to lock here
                return this.mNotificationName;
            }
            protected set
            {
                // Setting and getting of reference types is atomic, no need to lock here
                this.mNotificationName = value;
            }
        }
        /// <summary>
        /// <P>[Read-only]Get the number of observer in subject.</P>
        /// </summary>
        public virtual int Count
        {
            get
            {
                return this.mObservers.Count;
            }
        }

        #endregion

        #region Observer info struct
        private class ObserverInfo
        {
            #region Member variable
            private string mMethod;
            private object mContext;
            private IObserver mObserver;
            #endregion

            #region Constructor
            public ObserverInfo(string _method, object _context)
            {
                this.mMethod = _method;
                this.mContext = _context;
                this.mObserver = new CommonObserver(_method, _context);
            }
            public ObserverInfo(string _method, object _context, IObserver _observer)
            {
                this.mMethod = _method;
                this.mContext = _context;
                this.mObserver = _observer;
            }
            #endregion

            #region Public method
            public bool CompareInfo(ObserverInfo _info)
            {
                return this.Mehtod.Equals(_info.Mehtod) && this.Context.Equals(_info.Context);
            }
            public bool CompareInfo(string _method, object _context)
            {
                return this.Mehtod.Equals(_method) && this.Context.Equals(_context);
            }
            #endregion

            #region Accessors
            /// <summary>
            /// The method of the observer.
            /// </summary>
            public virtual string Mehtod
            {
                get
                {
                    // Setting and getting of reference types is atomic, no need to lock here
                    return this.mMethod;
                }
            }
            /// <summary>
            /// The context of the observer.
            /// </summary>
            public virtual object Context
            {
                get
                {
                    // Setting and getting of reference types is atomic, no need to lock here
                    return this.mContext;
                }
            }
            /// <summary>
            /// The observer.
            /// </summary>
            public virtual IObserver Observer
            {
                get
                {
                    // Setting and getting of reference types is atomic, no need to lock here
                    return this.mObserver;
                }
            }
            #endregion
        }
        #endregion
    }
}
