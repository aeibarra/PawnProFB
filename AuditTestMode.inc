// ===========================================================================
// IMAGE AUDIT TEST MODE -- TEMPORARY. DELETE THIS FILE WHEN TESTING IS DONE.
// ===========================================================================
//
// Flipping the define below turns the weekly image-backup audit into something
// that can actually be exercised at a desk instead of only on a Tuesday:
//
//   * runs on any day, ignoring the weekly "already audited" marker
//   * starts 2s after the main form shows instead of 15s
//   * keeps the production 100ms per-image throttle, so timings observed in
//     testing are the timings a store will see
//   * Ctrl+Shift+A  starts an audit on demand (tests restart after a yield)
//   * Ctrl+Shift+W  arms a 30s uninterruptible stall in the next run, which is
//     the only practical way to exercise the shutdown abandon path
//
// Every one of those lives inside an AUDIT_TESTMODE conditional. With the
// define commented out none of it is compiled and the binary is unaffected.
//
// Removal, in order:
//   1. comment out the define, build, confirm the app behaves normally
//   2. grep -rn "AUDIT_TESTMODE" and delete every block it reports
//   3. delete the include directives for this file, then delete this file
//   4. see Docs\ImageAuditTestPlan.md for the checklist this supported
//
// Units carrying test-mode code: PawnMain.pas, uImageBackupAudit.pas
//
// NOTE: line comments only in this file. It is included at unit scope, and a
// brace comment here cannot contain a brace-delimited compiler directive --
// Delphi comments do not nest, so the first inner brace would end the comment.
// ===========================================================================

{$DEFINE AUDIT_TESTMODE}
