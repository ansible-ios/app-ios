#ifndef Iosapp_NetworkLogging_h
#define Iosapp_NetworkLogging_h

#import <Foundation/Foundation.h>

void NetworkRegisterLoggingFunction();
void NetworkSetLoggingEnabled(bool);

void setBridgingTraceFunction(void (*)(NSString *, NSString *));
void setBridgingShortTraceFunction(void (*)(NSString *, NSString *));

#endif
