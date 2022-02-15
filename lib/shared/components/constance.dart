
void printFullText(String text)
{
  final pattern = RegExp('.{1,8000}'); // 800 is the size of chunk
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String token ='';
String uId = '';
