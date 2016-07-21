using System;
using System.Collections;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Library.EasingCurve
{
    class Easing
    {
        /**
         * Reference : http://wiki.unity3d.com/index.php?title=Interpolate
         * Reference : http://robertpenner.com/easing/
         * Reference : https://en.wikipedia.org/wiki/B%C3%A9zier_curve
         */

        /**
         * delegate function type. 
         */
        public delegate double EaseFunctionType(double start, double distance, double elapsedTime, double duration);

        #region Linear
        /**
         * Linear interpolation (same as Mathf.Lerp)
         */
        public static double Linear(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime to be <= duration
            if (elapsedTime > duration) { elapsedTime = duration; }
            return distance * (elapsedTime / duration) + start;
        }
        #endregion

        #region Sine
        /**
         * sinusoidal easing in - accelerating from zero velocity
         */
        public static double EaseSineIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime to be <= duration
            if (elapsedTime > duration) { elapsedTime = duration; }
            return -distance * Math.Cos(elapsedTime / duration * (Math.PI / 2)) + distance + start;
        }

        /**
         * sinusoidal easing out - decelerating to zero velocity
         */
        public static double EaseSineOut(double start, double distance, double elapsedTime, double duration)
        {
            if (elapsedTime > duration) { elapsedTime = duration; }
            return distance * Math.Sin(elapsedTime / duration * (Math.PI / 2)) + start;
        }

        /**
         * sinusoidal easing in/out - accelerating until halfway, then decelerating
         */
        public static double EaseSineInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime to be <= duration
            if (elapsedTime > duration) { elapsedTime = duration; }
            return -distance / 2 * (Math.Cos(Math.PI * elapsedTime / duration) - 1) + start;
        }
        #endregion

        #region Quad
        /**
         * quadratic easing in - accelerating from zero velocity
         */
        public static double EaseQuadIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return distance * elapsedTime * elapsedTime + start;
        }

        /**
         * quadratic easing out - decelerating to zero velocity
         */
        public static double EaseQuadOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return -distance * elapsedTime * (elapsedTime - 2) + start;
        }

        /**
         * quadratic easing in/out - acceleration until halfway, then deceleration
         */
        public static double EaseQuadInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2);
            if (elapsedTime < 1) return distance / 2 * elapsedTime * elapsedTime + start;
            elapsedTime--;
            return -distance / 2 * (elapsedTime * (elapsedTime - 2) - 1) + start;
        }
        #endregion

        #region Cubic
        /**
         * cubic easing in - accelerating from zero velocity
         */
        public static double EaseCubicIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return distance * elapsedTime * elapsedTime * elapsedTime + start;
        }

        /**
         * cubic easing out - decelerating to zero velocity
         */
        public static double EaseCubicOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            elapsedTime--;
            return distance * (elapsedTime * elapsedTime * elapsedTime + 1) + start;
        }

        /**
         * cubic easing in/out - acceleration until halfway, then deceleration
         */
        public static double EaseCubicInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2);
            if (elapsedTime < 1) return distance / 2 * elapsedTime * elapsedTime * elapsedTime + start;
            elapsedTime -= 2;
            return distance / 2 * (elapsedTime * elapsedTime * elapsedTime + 2) + start;
        }
        #endregion

        #region Quart
        /**
         * quartic easing in - accelerating from zero velocity
         */
        public static double EaseQuartIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return distance * elapsedTime * elapsedTime * elapsedTime * elapsedTime + start;
        }

        /**
         * quartic easing out - decelerating to zero velocity
         */
        public static double EaseQuartOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            elapsedTime--;
            return -distance * (elapsedTime * elapsedTime * elapsedTime * elapsedTime - 1) + start;
        }

        /**
         * quartic easing in/out - acceleration until halfway, then deceleration
         */
        public static double EaseQuartInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2);
            if (elapsedTime < 1) return distance / 2 * elapsedTime * elapsedTime * elapsedTime * elapsedTime + start;
            elapsedTime -= 2;
            return -distance / 2 * (elapsedTime * elapsedTime * elapsedTime * elapsedTime - 2) + start;
        }
        #endregion

        #region Quint
        /**
         * quintic easing in - accelerating from zero velocity
         */
        public static double EaseQuintIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return distance * elapsedTime * elapsedTime * elapsedTime * elapsedTime * elapsedTime + start;
        }

        /**
         * quintic easing out - decelerating to zero velocity
         */
        public static double EaseQuintOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            elapsedTime--;
            return distance * (elapsedTime * elapsedTime * elapsedTime * elapsedTime * elapsedTime + 1) + start;
        }

        /**
         * quintic easing in/out - acceleration until halfway, then deceleration
         */
        public static double EaseQuintInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2f);
            if (elapsedTime < 1) return distance / 2 * elapsedTime * elapsedTime * elapsedTime * elapsedTime * elapsedTime + start;
            elapsedTime -= 2;
            return distance / 2 * (elapsedTime * elapsedTime * elapsedTime * elapsedTime * elapsedTime + 2) + start;
        }
        #endregion

        #region Expo
        /**
         * exponential easing in - accelerating from zero velocity
         */
        public static double EaseExpoIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime to be <= duration
            if (elapsedTime > duration) { elapsedTime = duration; }
            return distance * Math.Pow(2, 10 * (elapsedTime / duration - 1)) + start;
        }

        /**
         * exponential easing out - decelerating to zero velocity
         */
        public static double EaseExpoOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime to be <= duration
            if (elapsedTime > duration) { elapsedTime = duration; }
            return distance * (-Math.Pow(2, -10 * elapsedTime / duration) + 1) + start;
        }

        /**
         * exponential easing in/out - accelerating until halfway, then decelerating
         */
        public static double EaseExpoInOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2);
            if (elapsedTime < 1) return distance / 2 * Math.Pow(2, 10 * (elapsedTime - 1)) + start;
            elapsedTime--;
            return distance / 2 * (-Math.Pow(2, -10 * elapsedTime) + 2) + start;
        }
        #endregion

        #region Circ
        /**
         * circular easing in - accelerating from zero velocity
         */
        public static double EaseCircIn(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            return -distance * (Math.Sqrt(1 - elapsedTime * elapsedTime) - 1) + start;
        }

        /**
         * circular easing out - decelerating to zero velocity
         */
        public static double EaseCircOut(double start, double distance, double elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 1.0f : elapsedTime / duration;
            elapsedTime--;
            return distance * Math.Sqrt(1 - elapsedTime * elapsedTime) + start;
        }

        /**
         * circular easing in/out - acceleration until halfway, then deceleration
         */
        public static double EaseCircInOut(double start, double distance, double
                             elapsedTime, double duration)
        {
            // clamp elapsedTime so that it cannot be greater than duration
            elapsedTime = (elapsedTime > duration) ? 2.0f : elapsedTime / (duration / 2);
            if (elapsedTime < 1) return -distance / 2 * (Math.Sqrt(1 - elapsedTime * elapsedTime) - 1) + start;
            elapsedTime -= 2;
            return distance / 2 * (Math.Sqrt(1 - elapsedTime * elapsedTime) + 1) + start;
        }
        #endregion

        #region Elastic

        /// <summary>
        /// Easing equation function for an elastic (exponentially decaying sine wave) easing out: 
        /// decelerating from zero velocity.
        /// </summary>
        public static double EaseElasticOut(double start, double distance, double elapsedTime, double duration)
        //public static double ElasticEaseOut(float t, float b, float c, float d)
        {
            if ((elapsedTime /= duration) == 1)
                return start + distance;

            double p = duration * .3;
            double s = p / 4;

            return (distance * Math.Pow(2, -10 * elapsedTime) * Math.Sin((elapsedTime * duration - s) * (2 * Math.PI) / p) + distance + start);
        }

        /// <summary>
        /// Easing equation function for an elastic (exponentially decaying sine wave) easing in: 
        /// accelerating from zero velocity.
        /// </summary>
        public static double EaseElasticIn(double start, double distance, double elapsedTime, double duration)
        {
            if ((elapsedTime /= duration) == 1)
                return start + distance;

            double p = duration * .3;
            double s = p / 4;

            return -(distance * Math.Pow(2, 10 * (elapsedTime -= 1)) * Math.Sin((elapsedTime * duration - s) * (2 * Math.PI) / p)) + start;
        }

        /// <summary>
        /// Easing equation function for an elastic (exponentially decaying sine wave) easing in/out: 
        /// acceleration until halfway, then deceleration.
        /// </summary>
        public static double EaseElasticInOut(double start, double distance, double elapsedTime, double duration)
        {
            if ((elapsedTime /= duration / 2) == 2)
                return start + distance;

            double p = duration * (.3 * 1.5);
            double s = p / 4;

            if (elapsedTime < 1)
                return -.5 * (distance * Math.Pow(2, 10 * (elapsedTime -= 1)) * Math.Sin((elapsedTime * duration - s) * (2 * Math.PI) / p)) + start;
            return distance * Math.Pow(2, -10 * (elapsedTime -= 1)) * Math.Sin((elapsedTime * duration - s) * (2 * Math.PI) / p) * .5 + distance + start;
        }

        #endregion

        #region Back

        /// <summary>
        /// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out: 
        /// decelerating from zero velocity.
        /// </summary>
        public static double EaseBackOut(double start, double distance, double elapsedTime, double duration)
        {
            return distance * ((elapsedTime = elapsedTime / duration - 1) * elapsedTime * ((1.70158 + 1) * elapsedTime + 1.70158) + 1) + start;
        }

        /// <summary>
        /// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in: 
        /// accelerating from zero velocity.
        /// </summary>
        public static double EaseBackIn(double start, double distance, double elapsedTime, double duration)
        {
            return distance * (elapsedTime /= duration) * elapsedTime * ((1.70158 + 1) * elapsedTime - 1.70158) + start;
        }

        /// <summary>
        /// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out: 
        /// acceleration until halfway, then deceleration.
        /// </summary>
        public static double EaseBackInOut(double start, double distance, double elapsedTime, double duration)
        {
            double s = 1.70158;
            if ((elapsedTime /= duration / 2) < 1)
                return distance / 2 * (elapsedTime * elapsedTime * (((s *= (1.525)) + 1) * elapsedTime - s)) + start;
            return distance / 2 * ((elapsedTime -= 2) * elapsedTime * (((s *= (1.525)) + 1) * elapsedTime + s) + 2) + start;
        }

        #endregion

        #region Bounce

        /// <summary>
        /// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out: 
        /// decelerating from zero velocity.
        /// </summary>
        public static double EaseBounceOut(double start, double distance, double elapsedTime, double duration)
        {
            if ((elapsedTime /= duration) < (1 / 2.75))
                return distance * (7.5625 * elapsedTime * elapsedTime) + start;
            else if (elapsedTime < (2 / 2.75))
                return distance * (7.5625 * (elapsedTime -= (1.5 / 2.75)) * elapsedTime + .75) + start;
            else if (elapsedTime < (2.5 / 2.75))
                return distance * (7.5625 * (elapsedTime -= (2.25 / 2.75)) * elapsedTime + .9375) + start;
            else
                return distance * (7.5625 * (elapsedTime -= (2.625 / 2.75)) * elapsedTime + .984375) + start;
        }

        /// <summary>
        /// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in: 
        /// accelerating from zero velocity.
        /// </summary>
        public static double EaseBounceIn(double start, double distance, double elapsedTime, double duration)
        {
            return distance - EaseBounceOut(duration - elapsedTime, 0, distance, duration) + start;
        }

        /// <summary>
        /// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in/out: 
        /// acceleration until halfway, then deceleration.
        /// </summary>
        public static double EaseBounceInOut(double start, double distance, double elapsedTime, double duration)
        {
            if (elapsedTime < duration / 2)
                return EaseBounceIn(elapsedTime * 2, 0, distance, duration) * .5 + start;
            else
                return EaseBounceOut(elapsedTime * 2 - duration, 0, distance, duration) * .5 + distance * .5 + start;
        }
        #endregion

        #region Cubic Bezier

        public static EaseFunctionType Bezier(double p0, double p1, double p2, double p3)
        {
            return (double start, double distance, double elapsedTime, double duration) =>
            {
                double t = elapsedTime / duration;
                double it = 1 - t;
                double r = p0 * Math.Pow(it, 3) + 
                      p1 * 3 * Math.Pow(it, 2) * t +
                      p2 * 3 * it * Math.Pow(t, 2) +
                      p3 * Math.Pow(t, 3);
                return start + distance * r;
            };
        }

        public static EaseFunctionType[] CubicBezier(double p0, double p1, double p2, double p3)
        {
            return new EaseFunctionType[] { Bezier(0, p1, p3, 1), Bezier(0, p0, p2, 1) };
        }

        #endregion
    }
}
