fixMethod('ViewController', 'mightCrashMethod:', 1, false, function(instance, originInvocation, originArguments) {
          if (originArguments[0] == null) {
              runErrorBranch('ViewController', 'mightCrashMethod');
          } else {
              runInvocation(originInvocation);
          }
});
