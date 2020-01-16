

typedef void (*LogCallback)(const char *log);

class Obfuscator {
    //
    
public:
    
    LogCallback logCallback;
    void start(int argc, const char **argv);
    
//    void obfuscateClassName();
//    void obfuscateMethodName();
    
//private:
//    bool isObfuscateClassName;      //是否混淆类名
//    bool isObfuscateMethodName;     //是否混淆方法名
//    bool isObfuscatePropertyName;   //是否混淆属性名
//    bool isObfuscateConstantString; //是否混淆常量字符串
    
};
