# Katahdin

## Current project aims

- Add Swift syntax
- Play around more with this awesome project!

## Important Windows setup info

### Paths (System.Net not found)

I haven't figured out how to get the `$KATAHDIN` environment variable to cooperate with me, so until I figure that out, putting `System.Net.dll` in the same directory as your program allows it to be imported. This can be found in any of these folders (ordered from normal to stupid - the last one requires you to have Paint.NET installed. Yes, this is stupid, please don't do this!):

```
C:\Program Files\Mono\lib\mono\2.0-api\System.Net.dll
C:\Program Files\Mono\lib\mono\gac\System.Net\4.0.0.0__b03f5f7f11d50a3a\System.Net.dll
C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0\System.Net.dll
C:\Program Files\paint.net\System.Net.dll
```

### URL requests

Making use of URL requests via `System.Net.HttpWebRequest` is a pain on Windows due to SSL issues. If you run into an issue like this:

```
System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.Net.WebException: Error: TrustFailure (Authentication failed, see inner exception.) ---> System.Security.Authentication.AuthenticationException: Authentication failed, see inner exception. ---> Mono.Btls.MonoBtlsException: Ssl error:1000007d:SSL routines:OPENSSL_internal:CERTIFICATE_VERIFY_FAILED        
  at D:\j\workspace\build-package-win-mono\2020-02\external\boringssl\ssl\handshake_client.c:1132
  at Mono.Btls.MonoBtlsContext.ProcessHandshake () [0x00048] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at Mono.Net.Security.MobileAuthenticatedStream.ProcessHandshake (Mono.Net.Security.AsyncOperationStatus status, System.Boolean renegotiate) [0x000da] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at (wrapper remoting-invoke-with-check) Mono.Net.Security.MobileAuthenticatedStream.ProcessHandshake(Mono.Net.Security.AsyncOperationStatus,bool)
  at Mono.Net.Security.AsyncHandshakeRequest.Run (Mono.Net.Security.AsyncOperationStatus status) [0x00006] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at Mono.Net.Security.AsyncProtocolRequest.ProcessOperation (System.Threading.CancellationToken cancellationToken) [0x000fc] in <2833956e84fa47a69fb5c0a42a95869c>:0
   --- End of inner exception stack trace ---
  at Mono.Net.Security.MobileAuthenticatedStream.ProcessAuthentication (System.Boolean runSynchronously, Mono.Net.Security.MonoSslAuthenticationOptions options, System.Threading.CancellationToken cancellationToken) [0x00262] in <2833956e84fa47a69fb5c0a42a95869c>:0

  at Mono.Net.Security.MonoTlsStream.CreateStream (System.Net.WebConnectionTunnel tunnel, System.Threading.CancellationToken cancellationToken) [0x0016a] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.WebConnection.CreateStream (System.Net.WebOperation operation, System.Boolean reused, System.Threading.CancellationToken cancellationToken) [0x001ba] in <2833956e84fa47a69fb5c0a42a95869c>:0
   --- End of inner exception stack trace ---
  at System.Net.WebConnection.CreateStream (System.Net.WebOperation operation, System.Boolean reused, System.Threading.CancellationToken cancellationToken) [0x0021a] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.WebConnection.InitConnection (System.Net.WebOperation operation, System.Threading.CancellationToken cancellationToken) [0x00141] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.WebOperation.Run () [0x0009a] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.WebCompletionSource`1[T].WaitForCompletion () [0x00094] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.HttpWebRequest.RunWithTimeoutWorker[T] (System.Threading.Tasks.Task`1[TResult] workerTask, System.Int32 timeout, System.Action abort, System.Func`1[TResult] aborted, System.Threading.CancellationTokenSource cts) [0x000f8] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at System.Net.HttpWebRequest.GetResponse () [0x00016] in <2833956e84fa47a69fb5c0a42a95869c>:0
  at (wrapper managed-to-native) System.Reflection.RuntimeMethodInfo.InternalInvoke(System.Reflection.RuntimeMethodInfo,object,object[],System.Exception&)
  at System.Reflection.RuntimeMethodInfo.Invoke (System.Object obj, System.Reflection.BindingFlags invokeAttr, System.Reflection.Binder binder, System.Object[] parameters, System.Globalization.CultureInfo culture) [0x0006a] in <32116eccb94d4ed685ca661d98e36637>:0
```

To fix this, you need to use Mono's `cert-sync` program to sync the Mono internal SSL certificate store with Windows' certificate store [(see here)](https://www.mono-project.com/docs/about-mono/releases/3.12.0/#cert-sync). This sounds good, but _doesn't work on Windows_ because Windows' certificate store is only present in the registry and not on the file system. This can be circumvented using curl's list of certificates from https://curl.haxx.se/ca/cacert.pem [(source)](https://mono.github.io/mail-archives/mono-list/2017-April/052433.html) and then running `cert-sync --user cacert.pem`.

## Original [katahdin](https://github.com/chrisseaton/katahdin) readme.txt below

-----

```
                               K A T A H D I N
                                       
                                 Chris Seaton
                                       
                            chris@chrisseaton.com
                         http://www.chrisseaton.com/
                         
Version 0.2, June 30th 2007

Requires

    Mono >= 1.2.3.1
    Gtk+ >= 2.6.10     }
    Gtk# >= 2.4.3      } only if you want to use the debugger

Compiling

    make

Installation

    After compiling you can use the executables where they are or copy the
    whole directory to somewhere else such as /usr/katahdin.
    
    You MUST set the $KATAHDIN variable to include the Katahdin directory, the
    library subdirectory, and the installed Mono library directory (usually
    something like /usr/lib/mono/2.0).

Getting Started

    Check the demos/ and tests/ subdirectories.

License

    Everything in this repository is placed into the public domain by the author.

    If that doesn't work for you, I also make it available under the BSD
    3-clause license.

        Copyright (c) 2007 Chris Seaton
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are
        met:

        Redistributions of source code must retain the above copyright notice,
        this list of conditions and the following disclaimer.

        Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.

        Neither the name of Chris Seaton nor the names of its contributors may
        be used to endorse or promote products derived from this software
        without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
        "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
        LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
        A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
        HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
        SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
        LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
        DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
        THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
        OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```