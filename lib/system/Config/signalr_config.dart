// // Server khong gui khi connect Signalr
// import '../../main.dart';
// import '../_base/model/data/data_group_modal.dart';
// import '../connect/modals/data_link_modal.dart';

// class StartSignalr {
//   static Future<void> connectSignalR() async {
//     signalrComponent.connect(
//       globalModel.encryptToken,
//       [
//         DataTransferEventModal(
//           "GetMessageToGroup",
//           getGroupMessage,
//         ),
//         //DataTransferEventModal("GetMessageToUser", _getUserMessage),
//         //DataTransferEventModal("GetUserOnline", _getUseOnline),
//       ],
//     );
//   }

//   static Future<void> getGroupMessage(List<Object> input) async {
//     final group = DataGroupModal.fromJson(
//       input[1] as Map<String, dynamic>,
//       globalModel.userDataModal.id!,
//     );

//     group.dataLinkModal =
//         DataLinkModal.fromJson(input[0] as Map<String, dynamic>);

//     globalModel.broadcastEventBus.fire(group);
//   }

//   static Future<void> disconnectSignalR() async {
//     await signalrComponent.disconnect();
//   }
// }
