#!/usr/bin/env python
from __future__ import print_function

import roslib
import rospy
import rostopic

import argparse
from collections import deque
import sys

msg_queue = deque()

def callback(msg, delay):
    try:
        msg.header.stamp += delay
        scheduled_time = msg.header.stamp        
    except AttributeError:
        scheduled_time = rospy.Time.now() + delay

    msg_queue.append((scheduled_time, msg))

def main():
    rospy.init_node('msg_delay', anonymous=True)
    
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='Input topic or topic field.')
    parser.add_argument('output', help='Output topic.')
    parser.add_argument('delay', type=float, default=5, help='Time to delay')

    argv = rospy.myargv()
    args = parser.parse_args(argv[1:])
    
    input_class, input_topic, input_fn = rostopic.get_topic_class(
            args.input, blocking=True)
    if input_topic is None:
        print('ERROR: Wrong input topic (or topic field): %s' % args.input, file=sys.stderr)
        sys.exit(1)

    sub = rospy.Subscriber(input_topic, input_class, callback, rospy.Duration.from_sec(args.delay))
    pub = rospy.Publisher(args.output, input_class, queue_size=10)

    while not rospy.is_shutdown():
        try:
            scheduled_time, msg = msg_queue.popleft()
        except IndexError:
            rospy.sleep(0.1)
        else:
            rospy.sleep(scheduled_time - rospy.Time.now())
            pub.publish(msg)

if __name__ == '__main__':
    main()
