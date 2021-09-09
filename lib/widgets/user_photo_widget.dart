part of 'widgets.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({this.editOption = false, Key? key}) : super(key: key);

  final bool editOption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.33,
        right: size.width * 0.33,
        top: 20,
      ),
      child: Stack(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.base64Photo != null) {
                return OctoImage(
                  image: MemoryImage(Uint8List.fromList(base64Decode(state.base64Photo!))),
                  imageBuilder: OctoImageTransformer.circleAvatar(),
                  placeholderBuilder: (_) => _noImage(size),
                  errorBuilder: (_, __, ___) => _noImage(size),
                  colorBlendMode: BlendMode.dstOver,
                  height: size.width * 0.35,
                  width: size.width * 0.35,
                  color: Colors.black38,
                  gaplessPlayback: true,
                );
              }
              return _noImage(size);
            },
          ),
          Visibility(
            visible: editOption,
            child: Positioned(
              bottom: 10,
              right: 0,
              child: GestureDetector(
                onTap: () => pickUserPhoto(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: size.width * 0.06,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar _noImage(Size size) {
    return CircleAvatar(
      radius: size.width * 0.175,
      backgroundColor: Colors.black38,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: size.width * 0.1,
      ),
    );
  }
}
