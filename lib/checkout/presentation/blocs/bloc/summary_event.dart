part of 'summary_bloc.dart';

@immutable
sealed class SummaryEvent {}

final class GetSummary extends SummaryEvent {}

final class OrderAccepted extends SummaryEvent {}
