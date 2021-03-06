
import 'dart:ffi';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:to_do/shared/cubit/cubit.dart';
Widget defaultButton({

  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(

      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
///////////////////////////////////////////////
Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type,
  bool isPassword = false,
  required FormFieldValidator<String>? validate ,
  required String label,
  required IconData prefix,
  final VoidCallback? onTab,
  Function? onTap,
  final void  Function(String)? onChange,
  IconData? suffix,
  final VoidCallback? suffixPressed,
  bool isClickable = true,
  final VoidCallback? onSubmit ,

}) => TextFormField  (
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled:isClickable ,
  onTap : onTab,
  onFieldSubmitted: (String value)
  {
    print(value);
  },
  onChanged : onChange,
  validator: validate,

  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ) ,
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null ,
    border: OutlineInputBorder(),
  ),
);

///////////////////////////////////////////////////
Widget  buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['time']),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

            '${model['time']}',

            style: const TextStyle(

              color: Colors.white,

            ),

          ),

          backgroundColor: Colors.amber,

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children:[

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 16.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['time']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateDateData(

              status: 'done',

              id: model['id'],

            );

          },

          icon:const Icon(

            Icons.check,

            color: Colors.green,

          ),



        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateDateData(

              status: 'archived',

              id: model['id'],

            );

          },

          icon:const Icon(

            Icons.archive_outlined,

            color: Colors.black45,

          ),



        ),

      ],

    ),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);
//////////////////
Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index)=>buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index)=> myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, PLS Add Some Tasks',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  ),

);
Widget myDivider() =>Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);
void navigateTo(context,widget ){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

}
void navigateAndFinish(
    context,widget
    )=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>widget,
        ),
            (route) {
          return false;
        }
    );