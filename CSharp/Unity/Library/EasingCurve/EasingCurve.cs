using System;
using System.Collections;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Library.EasingCurve
{
    class EaseCurve
    {
        // Sample rate, using on get curve sample point.
        private static float sampleRate = 0.01f;
        public static void SetSampleRate(float _value) { sampleRate = _value; }

        // Single ease function, time is fixed,but distance is changed.
        public static AnimationCurve Ease(Easing.EaseFunctionType _easing, double _startValue, double _startTime, double _endValue, double _endTime)
        {
            AnimationCurve curve = new AnimationCurve();
            double duration = _endTime - _startTime;
            double distance = _endValue - _startValue;
            for (double i = 0; i <= duration; i += sampleRate)
                curve.AddKey((float) i, (float) _easing(_startValue, distance, i, duration));
            return curve;
        }

        // Multi ease function, time and distance both is changed.
        // CubicBezier
        public static AnimationCurve Ease(Easing.EaseFunctionType[] _easing,
            double _startValue, double _startTime, double _endValue, double _endTime)
        {
            AnimationCurve curve = new AnimationCurve();
            if (_easing.Length == 2) { 
                Easing.EaseFunctionType progress = _easing[0];
                Easing.EaseFunctionType time = _easing[1];
                double duration = _endTime - _startTime;
                double distance = _endValue - _startValue;
                for (double i = 0; i <= duration; i += sampleRate)
                    curve.AddKey((float)time(_startTime, duration, i, duration), (float)progress(_startValue, distance, i, duration));
            }
            return curve;
        }
    }
}
