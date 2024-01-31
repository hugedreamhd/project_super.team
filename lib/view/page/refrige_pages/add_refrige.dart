import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/view_model/add_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_dialog/two_answer_dialog.dart';

class AddRefrige extends StatefulWidget {
  const AddRefrige({super.key, required this.currentUser});

  final UserModel currentUser;

  //외부에서 값을 받아올 수 있다

  @override
  State<AddRefrige> createState() => _AddRefrigeState();
}

class _AddRefrigeState extends State<AddRefrige> {
  final _addNameController = TextEditingController();

  TextEditingController get addNameController =>
      _addNameController; //addNameController 외부접근
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  @override
  void dispose() {
    addNameController.dispose(); //호출(단발성) - 함수를 포장해서 보내주자
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addPageViewModel = context.watch<AddPageViewModel>();
    //뷰모델 람다식 상태변경을 인식하려고 notifyListeners(); - 함수를 포장해서 보내주자
    //위젯 전체를 인식하려고 쓴것이다

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '냉장고 추가',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w200,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF9bc6bf),
        //actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20).w,
                  child: SizedBox(
                    height: 300.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '냉장고 이름',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  maxLength: 10,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '냉장고 이름을 입력하세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                    addPageViewModel.name = value!; //여기 잘 모르겠다
                                  },
                                  controller: addNameController,
                                  //obscureText: true, 입력값을 안보여주고싶을때
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(
                                      left: 15,
                                      top: 10,
                                      bottom: 10,
                                    ).w,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10).w,
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.green,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10).w,
                                      borderSide: BorderSide(
                                        width: 1.r,
                                        color: Colors.green,
                                      ),
                                    ),
                                    //hintText: '이름을 입력하세요',
                                    labelText: '이름을 입력하세요',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                          ],
                        ),
                        // 이 부분을 수정하여 두 번째 냉장고 이름을 표시하세요.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '냉장고 칸수',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40).w,
                                child: DropdownButton(
                                  value: addPageViewModel.selectedColdstorage,
                                  items: addPageViewModel
                                      .coldStorageOfCompartmentsList //String이 아닌 List<String>을 반환되고 있다
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      addPageViewModel.selectedColdstorage =
                                          value!;
                                    });
                                  },
                                  /*selectedItemBuilder: (BuildContext context) {
                                    return addPageViewModel
                                        .coldStorageOfCompartmentsList
                                        .map<Widget>((String value) {
                                      return Text('선택');
                                    }).toList()
                                  },*/
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             Expanded(
                              flex: 1,
                              child: Text(
                                '냉동고 칸수',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40).w,
                                child: DropdownButton(
                                    value:
                                        addPageViewModel.selectedFrozenStorage,
                                    items: addPageViewModel
                                        .frozenStorageOfCompartmentsList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel.selectedFrozenStorage =
                                            value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '보관기간',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40).w,
                                child: DropdownButton(
                                    value:
                                        addPageViewModel.selectedStoragePeriod,
                                    items: addPageViewModel.storagePeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel.selectedStoragePeriod =
                                            value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             Expanded(
                              child: Text(
                                '연장가능기간',
                                style: TextStyle(
                                  color: Color(0xFF00557F),
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40).w,
                                child: DropdownButton(
                                    elevation: 10,
                                    dropdownColor: Colors.green,
                                    value: addPageViewModel
                                        .selectedExtensionPeriod,
                                    items: addPageViewModel.extensionPeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel
                                            .selectedExtensionPeriod = value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TwoAnswerDialog(
                                        title: '등록하시겠습니까?',
                                        subtitle: '등록된 냉장고 이름은 수정이 불가합니다.',
                                        titleStyle: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.green,
                                        ),
                                        firstButton: '네',
                                        secondButton: '아니오',
                                        onTap: () async {
                                          setState(() {});

                                          if (mounted) {
                                            context.go('/', extra: 0);
                                          }
                                          await addPageViewModel
                                              .addRefrige(widget.currentUser);
                                        });
                                  });
                              //왜 async?
                            }
                          },
                          child: Text(
                            '추가하기',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/', extra: 0);
                          },
                          child: Text(
                            '취소하기',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
