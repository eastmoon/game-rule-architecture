/*
	Info:
        - Game Rule Architecture progress controller implement class.
        - Pipe and Filter is an architecture, that is use on step by step to execute, and Progress is a controller to control pipe execute state.
        - Pipe is a object to management filters and execute order.
		
	Date:
		- 2016.07.19
		
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
using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Patterns
{
    public class Pipe : Filter, IPipe
    {
        #region Static member
        public static string STATE_START = "pattern.progress.pipe.step.start";
        public static string STATE_GOTO = "pattern.progress.pipe.step.goto";
        public static string STATE_COMPLETE = "pattern.progress.pipe.step.end";
        public static string STATE_ERROR = "pattern.progress.pipe.step.error";
        #endregion

        #region Variable member
        private Hashtable mFilters;
        private ArrayList mRoutes;
        private ArrayList mProgress;
        private ISubjectContainer mStateEventListener;
        #endregion

        #region Constructor
        public Pipe(string _name = "") :base(_name)
        {
            // Filter store container
            this.mFilters = new Hashtable();
            // Routing map
            this.mRoutes = new ArrayList();
            // Progress store container
            this.mProgress = new ArrayList();
            // State event listener
            this.mStateEventListener = new SubjectContainer();
            // Register state event
            this.onRegisterStateEventListener();
        }
        #endregion

        #region Public Method

        #region Filter object management
        /// <summary>
        /// Register filter in pipe.
        /// </summary>
        public bool Register(IFilter _filter)
        {
            // 1. Duplicate object could not register
            if (!this.Has(_filter.Name))
            {
                // 2. Add in container
                this.mFilters.Add(_filter.Name, _filter);
                this.mRoutes.Add(_filter.Name);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Remove filter in pipe.
        /// </summary>
        public bool Remove(string _name)
        {
            // 1. Make sure filter exist
            if (this.Has(_name))
            {
                // 1.1. Remove target object in store container.
                this.mFilters.Remove(_name);
                // 1.2. Remove target object in routes.
                this.mRoutes.Remove(_name);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Check filter in pipe.
        /// </summary>
        public bool Has(string _name)
        {
            return this.mFilters.ContainsKey(_name);
        }

        /// <summary>
        /// Retrieve filter in pipe.
        /// </summary>
        public IFilter Retrieve(string _name)
        {
            if (this.Has(_name))
                return this.mFilters[_name] as IFilter;
            return null;
        }
        #endregion

        #region Progress object management
        /// <summary>
        /// Retrieve IProgress by index.
        /// </summary> 
        public IProgress GetProgress(int _indexID)
        {
            IProgress target = null;
            if (_indexID >= 0 && _indexID < this.mProgress.Count)
                target = (this.mProgress[_indexID] as IProgress);
            return target;
        }

        /// <summary>
        /// Retrieve index by IProgress
        /// </summary> 
        public int GetProgressIndex(IProgress _progress)
        {
            return this.mProgress.IndexOf(_progress);
        }
        #endregion

        #region Execute filter function
        /// <summary>
        /// <P>Execute filter functional.</P>
        /// </summary>
        public override void Execute(IProgress _progress)
        {
            this.Execute(_progress, Pipe.STATE_START);
        }

        /// <summary>
        /// Execute pipe and use progress to control.
        /// </summary> 
        public virtual void Execute(IProgress _progress, string _state)
        {
            // 1. Check state is register in StateEventListener
            if (this.mStateEventListener.Has(_state))
            {
                // 2. Execute function
                IObserver observer = this.mStateEventListener.Retrieve(_state) as IObserver;
                if (observer != null)
                    observer.NotifyObserver(new Notification(_state, _progress));
            }
        }
        #endregion

        #endregion

        #region Protected Method
        protected virtual void onRegisterStateEventListener()
        {
            ISubject state = null;
            // Setting start state
            state = new Subject(Pipe.STATE_START);
            state.Register(this.onPipeStart);
            this.StateEventListener.Register(state);

            // Setting start state
            state = new Subject(Pipe.STATE_GOTO);
            state.Register(this.onPipeGoto);
            this.StateEventListener.Register(state);

            // Setting complete state
            state = new Subject(Pipe.STATE_COMPLETE);
            state.Register(this.onPipeComplete);
            this.StateEventListener.Register(state);

            // Setting error state
            state = new Subject(Pipe.STATE_ERROR);
            state.Register(this.onPipeError);
            this.StateEventListener.Register(state);

        }
        protected virtual void onPipeStart(INotification _notification)
        {
            IProgress progress = _notification.Body as IProgress;
            if(progress != null)
            { 
                // Progress starting, save progress variable
                // 1. Put progress in list.
                this.mProgress.Add(progress);
                // 2. Set pipe to progress
                progress.Pipe = this;
            }
        }
        protected virtual void onPipeComplete(INotification _notification)
        {
            IProgress progress = _notification.Body as IProgress;
            if (progress != null)
            {
                // 1. Remove progress in pipe
                this.mProgress.Remove(progress);

                // 2. Seting progress.pipe is null
                progress.Pipe = null;
            }
        }
        protected virtual void onPipeGoto(INotification _notification)
        {
            IProgress progress = _notification.Body as IProgress;
            if (progress != null && progress.Index >= 0 && progress.Index < this.Routes.Count)
            {
                // 1. Retrieve filter
                string name = this.Routes[progress.Index] as string;
                IFilter filter = this.Retrieve(name);

                // 2. Execute filter
                if (filter != null)
                    filter.Execute(progress);
            }
        }
        protected virtual void onPipeError(INotification _notification)
        {
            // Error process.

            // Call Complete
            this.onPipeComplete(_notification);
        }
        #endregion

        #region Accessors
        /// <summary>
        /// <P>[Read-only]Get the number of filter in pipe.</P>
        /// </summary>
        public int Count
        {
            get { return this.mRoutes.Count; }
        }

        /// <summary>
        /// <P>[Read-only]Get the route map in pipe, which is store filter.</P>
        /// </summary>
        public ArrayList Routes
        {
            get { return this.mRoutes; }
        }

        /// <summary>
        /// <P>[Read-only]Get the state event listener object</P>
        /// </summary>
        public ISubjectContainer StateEventListener
        {
            get { return this.mStateEventListener; }
        }
        #endregion
    }
}
