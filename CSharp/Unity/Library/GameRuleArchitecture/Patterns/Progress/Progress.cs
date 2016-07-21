using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Patterns
{
    public class Progress : Notification, IProgress
    {
        #region Static member
        public static string NOTIFICATION_TYPE = "pattern.progress.notification.type";
        #endregion

        #region Variable member
        private IPipe mPipe;
        private int mProgressIndex;
        private int mCurrentIndex;
        private string mErrorMessage;
        #endregion

        #region Constructor
        public Progress(string _name, object _body = null) : base(_name, _body, Progress.NOTIFICATION_TYPE)
        {
            // Initial variable
            this.mPipe = null;
            this.mProgressIndex = -1;
            this.mCurrentIndex = -1;
            this.mErrorMessage = "";
        }
        #endregion

        #region Public Method
        /// <summary>
        /// Goto next step in pipe routes.
        /// </summary>
        public void Next()
        {
            // 1. Add index
            this.mCurrentIndex++;
            if ( this.Pipe != null && this.mCurrentIndex >= 0 && this.mCurrentIndex < this.Pipe.Count )
            { 
                // 2. if still have filter in count, goto.
                this.mPipe.Execute(this, Patterns.Pipe.STEP_GOTO);
            }
            else if(this.Pipe != null )
            {
                // 3. if didn't have filter, complete
                this.mPipe.Execute(this, Patterns.Pipe.STEP_COMPLETE);
            }
        }
        /// <summary>
        /// Goto assign step, if step in pipe.
        /// </summary>
        public void Goto(string _filterName)
        {
            //
            if (this.Pipe == null)
                return;

            // 1. Check filter is exist.
            int filterID = -1;
            for(filterID = 0; filterID < this.Pipe.Routes.Count; filterID++)
            {
                if (this.Pipe.Routes[filterID].Equals(_filterName))
                    break;
            }

            // 2. Saving id, if filter exist
            if (filterID < this.Pipe.Routes.Count)
            { 
                this.mCurrentIndex = filterID;
                this.mPipe.Execute(this, Patterns.Pipe.STEP_GOTO);
            }
        }
        /// <summary>
        /// Set complete state, auto-goto pipe ending process.
        /// </summary>
        public void Complete()
        {
            //
            if (this.Pipe == null)
                return;

            // call complete state.
            this.mPipe.Execute(this, Patterns.Pipe.STEP_COMPLETE);
        }
        /// <summary>
        /// Set error state, auto-goto pipe error process.
        /// </summary>
        public void Error(string _message)
        {
            //
            if (this.Pipe == null)
                return;

            // 1. Saving message
            this.mErrorMessage = _message;
            // 2. Call error state.
            this.mPipe.Execute(this, Patterns.Pipe.STEP_ERROR);
        }
        #endregion

        #region Accessors
        /// <summary>
        /// [Read-Write] Piep setting, that is progress current control pipe.
        /// </summary>
        public IPipe Pipe
        {
            get { return this.mPipe; }
            set
            {
                // Make sure input pipe didn't null.
                this.mPipe = value;
                if(this.mPipe != null)
                { 
                    // 1. Retrieve index in pipe, it is double check, make sure pipe know progress exist.
                    this.mProgressIndex = this.mPipe.GetProgressIndex(this);
                    // 2. If index >= 0, than progress in pipe
                    if (this.mProgressIndex < 0)
                        this.mPipe = null;
                    else
                    {
                        // Initial variable
                        this.mCurrentIndex = -1;
                        this.mErrorMessage = "";
                        this.Next();
                    }
                }
                else
                {
                    this.mProgressIndex = -1;
                    this.mCurrentIndex = -1;
                }
            }
        }
        /// <summary>
        /// [Read-Only] Current routes index.
        /// </summary>
        public int Index {
            get { return this.mCurrentIndex; }
        }
        /// <summary>
        /// [Read-Only] Error message, when Error state happen.
        /// </summary>
        public string ErrorMessage {
            get { return this.mErrorMessage; }
        }
        #endregion
    }
}
