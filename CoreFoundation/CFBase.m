#import <CoreFoundation/CFBase.h>
#import <Foundation/NSRaise.h>
#import <Foundation/NSCFTypeID.h>
#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSFileManager.h>
#ifdef WINDOWS
#import <windows.h>
#endif

const CFAllocatorRef kCFAllocatorDefault;
const CFAllocatorRef kCFAllocatorSystemDefault;
const CFAllocatorRef kCFAllocatorMalloc;
const CFAllocatorRef kCFAllocatorMallocZone;
const CFAllocatorRef kCFAllocatorNull;
const CFAllocatorRef kCFAllocatorUseContext;

CFAllocatorRef CFAllocatorGetDefault(void){
   NSUnimplementedFunction();
   return 0;
}

void CFAllocatorSetDefault(CFAllocatorRef self){
}

CFTypeID CFAllocatorGetTypeID(void){
   return kNSCFTypeAllocator;
}

CFAllocatorRef CFAllocatorCreate(CFAllocatorRef self,CFAllocatorContext *context){
   NSUnimplementedFunction();
   return 0;
}

void CFAllocatorGetContext(CFAllocatorRef self,CFAllocatorContext *context){
}
CFIndex CFAllocatorGetPreferredSizeForSize(CFAllocatorRef self,CFIndex size,CFOptionFlags hint){
   NSUnimplementedFunction();
   return 0;
}

void *CFAllocatorAllocate(CFAllocatorRef self,CFIndex size,CFOptionFlags hint){
   NSUnimplementedFunction();
   return 0;
}
void CFAllocatorDeallocate(CFAllocatorRef self,void *ptr){
   NSUnimplementedFunction();
}
void *CFAllocatorReallocate(CFAllocatorRef self,void *ptr,CFIndex size,CFOptionFlags hint){
   NSUnimplementedFunction();
   return 0;
}


CFTypeID CFGetTypeID(CFTypeRef self){
   return [(id)self _cfTypeID];
}

CFTypeRef CFRetain(CFTypeRef self){
	return (CFTypeRef)[(id) self retain];
}

void CFRelease(CFTypeRef self){
	return [(id) self release];
}
CFIndex CFGetRetainCount(CFTypeRef self){
   return [(id) self retainCount];
   return 0;
}

CFAllocatorRef CFGetAllocator(CFTypeRef self){
   NSUnimplementedFunction();
   return 0;
}

CFHashCode CFHash(CFTypeRef self){
	return [(id)self hash];
}

Boolean CFEqual(CFTypeRef self,CFTypeRef other){
	return [(id) self isEqual:(id)other];
}

CFStringRef CFCopyTypeIDDescription(CFTypeID typeID){
	NSUnimplementedFunction();
	return 0;
}

CFStringRef CFCopyDescription(CFTypeRef self){
   return (CFStringRef)[[(id) self description] copy];
}

CFTypeRef CFMakeCollectable(CFTypeRef self){
   //does nothing on cocotron
   return 0;
}

#ifdef WINDOWS
unsigned int sleep(unsigned int seconds) {
   NSUnimplementedFunction();
   return 0;
}

size_t strlcpy(char *dst, const char *src, size_t size) {
   int i,count=size;
   
   for(i=0;i<count-1;i++)
    dst[i]=src[i];
    
   dst[i]='\0';

   return i;
}

void bzero(void *ptr,size_t size){
   size_t i;
   
   for(i=0;i<size;i++)
    ((unsigned char *)ptr)[i]=0;
}

void bcopy(const void *s1, void *s2, size_t n) {
   size_t i;
   
   for(i=0;i<n;i++)
    ((unsigned char *)s2)[i]=((unsigned char *)s1)[i];
}

int bcmp(const void *s1, void *s2, size_t n) {
   size_t i;
   
   for(i=0;i<n;i++)
    if(((unsigned char *)s2)[i]!=((unsigned char *)s1)[i])
     return 1;
   
   return 0;
}

int mkstemps(char *template,int suffixlen) {
   HANDLE result=NULL;
   const char *table="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
   int       modulo=strlen(table);
   int       counter=GetTickCount();
   NSString *check;
   int       length=strlen(template),pos=length-suffixlen;
   
   while(--pos>=0){
    if(template[pos]!='X'){
     pos++;
     break;
    }
   }
   
   int i,failSafe=0;
   char try[length+1];
   
   do {
    
    for(i=0;i<length;i++)
     if(i<pos || i>=length-suffixlen)
      try[i]=template[i];
     else {
      try[i]=table[counter%modulo];
      counter+=i;
     }
     
    try[i]=0;
    
    check=[NSString stringWithUTF8String:try];
    
    NSLog(@"mkstemps try=%@",check);
    
    result=CreateFileW([check fileSystemRepresentationW],GENERIC_WRITE|GENERIC_READ,0,NULL,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,NULL);
    
    failSafe++;
    
   }while(result==NULL && failSafe<100);

   if(result!=NULL){
    for(i=0;i<length;i++)
     template[i]=try[i];
    template[i]=0;
   }
   
   return (int)result;
}

#endif


