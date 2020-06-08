

```
03.06.2020 13:05:42.289 [cm-p13952-e30153-aem-publish-6888cf6b6f-cfltk] *ERROR* [172.16.80.200 [1591189542286] GET /content/example/us/en.html HTTP/1.1] org.apache.sling.engine.impl.SlingRequestProcessorImpl service: Uncaught SlingException
java.io.IOException: classFile.delete() failed
	at org.apache.sling.scripting.jsp.jasper.compiler.SmapUtil$SDEInstaller.install(SmapUtil.java:245) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.compiler.SmapUtil.installSmap(SmapUtil.java:167) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.compiler.JDTCompiler.generateClass(JDTCompiler.java:151) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.compiler.Compiler.compile(Compiler.java:304) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.compiler.Compiler.compile(Compiler.java:282) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.compiler.Compiler.compile(Compiler.java:269) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129]
	at org.apache.sling.scripting.jsp.jasper.JspCompilationContext.compile(JspCompilationContext.java:501) [org.apache.sling.scripting.jsp:2.5.0.T20200512124225-74bd129] ...
```

+ __Resolution:__ Contact Adobe Support