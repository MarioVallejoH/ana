import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PersonRegistration extends StatefulWidget {
  const PersonRegistration({Key? key}) : super(key: key);

  @override
  State<PersonRegistration> createState() => _PersonRegistrationState();
}

class _PersonRegistrationState extends State<PersonRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [_appBar(context)],
      ),
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appBarColor,
      pinned: true,
      floating: true,
      elevation: 10,
      leading: IconButton(
        onPressed: () {
          finish(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: mainColor,
      ),
      title: Text(
        'Persona',
        style: ThemeConf().normalTextStyle(context),
      ),
      centerTitle: true,
    );
  }
}
