/*
	Info:
		- Re design notification structure, use subject container to setting notify system. 
	
    Date:
		- 2016.07.25
		
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

using PureMVC.Interfaces;
using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;

namespace GameRuleArchitecture.Patterns
{
    class SubjectMediator : Mediator, ISubjectMediator
    {
        #region Member variable
        private ISubjectContainer mContainer;
        #endregion

        #region Constructor
        /// <summary>
        /// Constructs a new mediator with the default name and no view component
        /// </summary>
        public SubjectMediator()
            : this(NAME, null)
        {
        }

        /// <summary>
        /// Constructs a new mediator with the specified name and no view component
        /// </summary>
        /// <param name="mediatorName">The name of the mediator</param>
        public SubjectMediator(string _mediatorName)
            : this(_mediatorName, null)
        {
        }

        /// <summary>
        /// Constructs a new mediator with the specified name and view component
        /// </summary>
        /// <param name="mediatorName">The name of the mediator</param>
        /// <param name="viewComponent">The view component to be mediated</param>
		public SubjectMediator(string _mediatorName, object _viewComponent) : base(_mediatorName, _viewComponent)
        {
            // Initial member variable
            this.mContainer = new SubjectContainer();
        }
        #endregion

        #region Public Methods

        #region ISubjectMediator Members

        /// <summary>
        /// Register Subject in container.
        /// </summary>
        public bool RegisterSubject(string _notificationName, Action<INotification> _action)
        {
            ISubject subject = null;
            if (this.mContainer.Has(_notificationName))
            {
                // 1. Notification is exist in container, only register action.
                subject = this.mContainer.Retrieve(_notificationName);
                return subject.Register(_action);
            }
            else
            {
                // 1. Notification isn't exist in container, create subject and register action.
                subject = new Subject(_notificationName);
                subject.Register(_action);
                return this.mContainer.Register(subject);
            }
        }

        /// <summary>
        /// Remove Subject in container.
        /// </summary>
        public bool RemoveSubject(string _notificationName)
        {
            return this.mContainer.Remove(_notificationName);
        }
        #endregion

        #region IMediator Members

        /// <summary>
        /// List the <c>INotification</c> names this <c>Mediator</c> is interested in being notified of
        /// </summary>
        /// <returns>The list of <c>INotification</c> names </returns>
        public override IList<string> ListNotificationInterests()
        {
            return this.mContainer.ListSubjectInterests;
        }

        /// <summary>
        /// Handle <c>INotification</c>s
        /// </summary>
        /// <param name="notification">The <c>INotification</c> instance to handle</param>
        /// <remarks>
        ///     <para>
        ///        Typically this will be handled in a switch statement, with one 'case' entry per <c>INotification</c> the <c>Mediator</c> is interested in. 
        ///     </para>
        /// </remarks>
        public override void HandleNotification(INotification notification)
        {
            // 1. Retrieve subject
            ISubject subject = this.mContainer.Retrieve(notification.Name);
            // 2. Subject exist than send notify.
            if (subject != null)
                subject.NotifyObserver(notification);
        }

        #endregion

        #endregion

        #region Accessors
        /// <summary>
        /// <P>[Read-only] Get subject container.</P>
        /// </summary>
        public ISubjectContainer Container { get { return this.mContainer; } }
        #endregion
    }
}
