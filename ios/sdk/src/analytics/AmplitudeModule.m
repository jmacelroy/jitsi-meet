/*
 * Copyright @ 2018-present 8x8, Inc.
 * Copyright @ 2017-2018 Atlassian Pty Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <React/RCTBridgeModule.h>
#import "Amplitude.h"

@interface AmplitudeModule : NSObject<RCTBridgeModule>

@end

@implementation AmplitudeModule

RCT_EXPORT_MODULE(Amplitude)

+ (BOOL)requiresMainQueueSetup{
    return NO;
}

RCT_EXPORT_METHOD(init:(NSString*)project API_KEY:(NSString*)apiKey) {
    [[Amplitude instanceWithName:project] initializeApiKey:apiKey];
}

RCT_EXPORT_METHOD(setUserProperties:(NSString*)project userPropsString:(NSString*)userPropsString) {
    NSError *error;
    NSData *userPropsData = [userPropsString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *userProperties = [NSJSONSerialization JSONObjectWithData:userPropsData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    [[Amplitude instanceWithName:project] setUserProperties:userProperties];
}

RCT_EXPORT_METHOD(logEvent:(NSString*)project eventType:(NSString*)eventType eventPropsString:(NSString*)eventPropsString) {
    NSError *error;
    NSData *eventPropsData = [eventPropsString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *eventProperties = [NSJSONSerialization JSONObjectWithData:eventPropsData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
    [[Amplitude instanceWithName:project] logEvent:eventType withEventProperties:eventProperties];
}

@end

