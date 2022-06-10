import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/data/image_repository.dart';

class SceneFormField extends StatelessWidget {
  final List<SceneDetail> scenes;
  final int? initialValue;
  final Function(int?) onSaved;
  final String? Function(int?) validator;

  const SceneFormField({
    Key? key,
    required this.scenes,
    required this.onSaved,
    required this.validator,
    this.initialValue,
  }): super(key: key);

  ImageProvider _getImage(String? source) {
    if (source != null && source.toString().isNotEmpty) {
      return NetworkImage('${ImageRepository.entrypoint}/$source');
    } else {
      return Image.asset('assets/image_not_found.jpeg').image;
    }
  }

  @override
  Widget build(BuildContext context) { 
    ThemeData theme = Theme.of(context);
    return FormField<int?>(
      onSaved: onSaved,
      validator: validator,
      builder: (formState) => SmartSelect<int?>.single(
        title: 'Сцены',
        placeholder: 'Выберите сцену',
        selectedValue: formState.value,
        onChange: (selected) => formState.didChange(selected.value),
        modalType: S2ModalType.bottomSheet,
        modalHeader: false,
        choiceItems: S2Choice.listFrom<int, SceneDetail>(
          source: scenes,
          value: (index, item) => index,
          title: (index, item) => item.title ?? '',
          meta: (index, item) => item,
        ),
        choiceLayout: S2ChoiceLayout.wrap,
        choiceDirection: Axis.horizontal,
        choiceBuilder: (context, state, choice) {
          return Card(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            color: choice.selected ? theme.primaryColor : theme.cardColor,
            child: InkWell(
              onTap: () => choice.select?.call(true),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4), 
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: _getImage((choice.meta as SceneDetail).thumbnail),
                          child: choice.selected
                              ? const Icon(Icons.check,color: Colors.white)
                              : null,
                          minRadius: 30,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          choice.title ?? '',
                          style: TextStyle(
                            color: choice.selected ? Colors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          );
        },
        tileBuilder: (context, state) {
          final meta = state.selected?.choice?.meta as SceneDetail?;
          final ImageProvider<Object> avatar = _getImage(meta?.thumbnail);

          return S2Tile.fromState(
            state,
            isTwoLine: true,
            isError: formState.hasError,
            leading: CircleAvatar(
              backgroundImage: avatar,
            ),
          );
        },
      )
    );
  }
}

