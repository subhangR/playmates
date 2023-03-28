import '../models/user_profile.dart';

List<UserProfile> getUsers() {

  return [
  UserProfile(
    uid: 'user1',
    phoneNumber: '+1234567890',
    displayName: 'Alice',
    email: 'alice@example.com',
    photoUrl: 'https://example.com/images/alice.jpg',
  ),
  UserProfile(
    uid: 'user2',
    phoneNumber: '+0987654321',
    displayName: 'Bob',
    email: 'bob@example.com',
    photoUrl: 'https://example.com/images/bob.jpg',
  ),

  UserProfile(
    uid: 'user3',
    phoneNumber: '+1122334455',
    displayName: 'Charlie',
    email: 'charlie@example.com',
    photoUrl: 'https://example.com/images/charlie.jpg',
  ),

  UserProfile(
    uid: 'user4',
    phoneNumber: '+5566778899',
    displayName: 'David',
    email: 'david@example.com',
    photoUrl: 'https://example.com/images/david.jpg',
  ),

  UserProfile(
    uid: 'user5',
    phoneNumber: '+9191919191',
    displayName: 'Eva',
    email: 'eva@example.com',
    photoUrl: 'https://example.com/images/eva.jpg',
  )
];}