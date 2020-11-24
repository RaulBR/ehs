import 'dart:convert';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/services/camera_service.dart';
import 'package:ehsfocus/shared/photoComponents/bloc/photo_bloc.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoWithPlaceholder extends StatelessWidget {
  final Aspect aspectIn;
  final bool isEditable;
  final double size;
  final Function addPicture;
  final Function deletePicture;
  final CameraService camera = CameraService();
  PhotoWithPlaceholder(
      {this.aspectIn,
      this.deletePicture,
      this.isEditable,
      this.addPicture,
      this.size});
  @override
  Widget build(BuildContext context) {
    double _screenSize = MediaQuery.of(context).size.height;
    double _size = 190;
    _size = size == null ? _size : size;
    _size = _screenSize < 600 ? 100 : _size;
    String image;
    final bool _isEditable = isEditable == null ? true : isEditable;
    AspectPhoto _image = AspectPhoto();
    List<AspectPhoto> _images = [];
    Aspect _aspect = Aspect();

    return BlocProvider<PhotoBloc>(
      create: (context) {
        PhotoBloc a = PhotoBloc();
        if (aspectIn != null || aspectIn.id != null) {
          _aspect = aspectIn;
          _images = _aspect.photos ?? _images;
          a.add(GetPhotoEvent(aspectIn));
        }

        return a;
      },
      child: Container(
        child: BlocListener<PhotoBloc, PhotoState>(
          listener: (context, state) {
            if (state is DeletedPicture) {
              deletePicture(state.photo);
            }
          },
          child: BlocBuilder<PhotoBloc, PhotoState>(
            buildWhen: (previous, current) => current is ShowPhotoState,
            builder: (context, state) {
              if (state is ShowPhotoState) {
                _image = state.photo;
                image = state.photo.photo;
              }
              return image != null
                  ? Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Image.memory(
                              (base64Decode(image)),
                              height: _size,
                              width: 400,
                              fit: BoxFit.cover,
                            ),
                            !_isEditable
                                ? Text('')
                                : GestureDetector(
                                    onTap: () {
                                      if (!_isEditable) return;

                                      BlocProvider.of<PhotoBloc>(context)
                                          .add(DeletePhotoEvent(_image));
                                    },
                                    child: Icon(Icons.close),
                                  ),
                          ],
                        ),
                        _images.length > 1 ? Text('Before') : Text(''),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        if (!_isEditable) {
                          return;
                        }
                        camera.handleShowDialog(context, (data) {
                          BlocProvider.of<PhotoBloc>(context)
                              .add(ChangePhotoEvent(data));
                          addPicture(data);
                        });
                      },
                      child: Icon(
                        Icons.photo_camera,
                        size: _size,
                        color: AppColors.textSecundart,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
