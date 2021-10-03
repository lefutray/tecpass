part of 'widgets.dart';

class UserPhoto extends StatefulWidget {
  const UserPhoto({this.editOption = false, Key? key}) : super(key: key);
  final bool editOption;

  @override
  State<UserPhoto> createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  @override
  void initState() {
    final photo = context.read<UserBloc>().state.base64Photo;
    if (photo == null || photo.isEmpty) context.read<UserBloc>().loadPhoto(context);
    super.initState();
  }

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
              final photo = state.base64Photo;
              if (photo != null && photo.isNotEmpty) {
                return OctoImage(
                  image: MemoryImage(Uint8List.fromList(base64Decode(photo))),
                  imageBuilder: OctoImageTransformer.circleAvatar(),
                  placeholderBuilder: (_) => _noImage(size, state.updatingPhoto),
                  errorBuilder: (_, __, ___) => _noImage(size, state.updatingPhoto),
                  colorBlendMode: BlendMode.dstOver,
                  height: size.width * 0.35,
                  width: size.width * 0.35,
                  color: Colors.black38,
                  gaplessPlayback: true,
                );
              }
              return _noImage(size, state.updatingPhoto);
            },
          ),
          Visibility(
            visible: widget.editOption,
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

  Widget _noImage(Size size, UpdatePhotoStatus status) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: size.width * 0.175,
          backgroundColor: Colors.black38,
          child: Icon(
            Icons.person,
            color: (status != UpdatePhotoStatus.uploaded) ? Colors.transparent : Colors.white,
            size: size.width * 0.1,
          ),
        ),
        if (status == UpdatePhotoStatus.uploading) CircularProgressIndicator(color: Colors.white),
        if (status == UpdatePhotoStatus.failed) Icon(Icons.error, color: Colors.red, size: size.width * 0.1),
      ],
    );
  }
}
