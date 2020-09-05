Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89C25EA52
	for <lists+linux-spi@lfdr.de>; Sat,  5 Sep 2020 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgIEUOl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Sep 2020 16:14:41 -0400
Received: from smtp2.axis.com ([195.60.68.18]:33239 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIEUOk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 5 Sep 2020 16:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3257; q=dns/txt; s=axis-central1;
  t=1599336878; x=1630872878;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CX4yRWuFTgsS8o0t8HPYvwskW7rGZs3lnP8KiwwwypQ=;
  b=oTnxJVwhC/MiRilqvOuOku2Fui/1beFGqVvRZ7G8VeipRqKfRMQ3obaL
   TJwecCb/DxgXPhkUQa6Err+PgNZ0ikUKyIMa9HB4RqNfeRmEcdC1hCcRR
   1rvPZ/epIbRxG9veMuofjqicHTQsnK2ukjazZfgsBAZVEPEIjEpqORaHA
   MPF1xMYg5XerGkCKRpyjUmVuNJnah/Ro6oa8jz+GIjQsaeOACdbAK5bVy
   lfFKeLRPahs6K7HIBJVxfEtDvwZfxcyyrjMXrFx7eGUaXaCvDEMeofQkY
   W/AYxGz9kE/FEreXQdwbvwZre9eI5CisrnBl65+PMVSmEuFVlE9M4cts8
   Q==;
IronPort-SDR: O0hLwekSSOVBzJ+7dCDsro9+73iX47QgdecBtV/07SExZh1BDrr/mwEtTQFg1av1gnQVEvHUw1
 0nft0dmVqwxOZoKbxzU0loYD1tVf0XNCGCgEXfp0hTcjal9/syeuKq4rO0H5z4+bAYFUAH5qUh
 uCmh+pvTL2YJg/OkrMApFSyF7lycGQo8OiyFRe5TT6AOLv+wqFJn5MqdKw6dEISTR/4qyGFRNq
 ODGXLUKYfe1L4cYxDbrlBWu/1JFcv9YfzUHs+LzBupwSFzUummVTECo4PCRPlhsEaYdkPcXiAS
 XRo=
X-IronPort-AV: E=Sophos;i="5.76,395,1592863200"; 
   d="scan'208";a="12231824"
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel@axis.com>,
        Gustav Wiklander <gustavwi@axis.com>
Subject: [PATCH] spi: Fix memory leak on splited transfers
Date:   Sat, 5 Sep 2020 22:14:21 +0200
Message-ID: <20200905201421.29495-1-gustav.wiklander@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Gustav Wiklander <gustavwi@axis.com>

In the prepare_message callback the bus driver has the
opportunity to split a transfer into smaller chunks.
spi_map_msg is done after prepare_message.

Function spi_res_release releases the splited transfers
in the message. Therefore spi_res_release should be called
after spi_map_msg.

The previous try at this was commit c9ba7a16d0f1
which released the splited transfers after
spi_finalize_current_message had been called.
This introduced a race since the message struct could be
out of scope because the spi_sync call got completed.

Fixes this leak on spi bus driver spi-bcm2835.c when transfer
size is greater than 65532:

[   76.611642][  T170] kmemleak: unreferenced object 0xfffffff06ef81480
(size 128):
[   76.618965][  T170] kmemleak:   comm "insmod", pid 493, jiffies
4294941102 (age 38.540s)
[   76.627031][  T170] kmemleak:   backtrace:
[   76.631206][  T170] kmemleak:     [<ffffffa542c5f8f8>]
create_object+0x100/0x288
[   76.638596][  T170] kmemleak:     [<ffffffa5432a9ee4>]
kmemleak_alloc+0x8c/0xe0
[   76.645723][  T170] kmemleak:     [<ffffffa542c4cbe8>]
__kmalloc+0x1c8/0x370
[   76.652754][  T170] kmemleak:     [<ffffffa542e14c94>]
sg_kmalloc+0x1c/0x68
[   76.659782][  T170] kmemleak:     [<ffffffa542e1543c>]
__sg_alloc_table+0xf4/0x128
[   76.667420][  T170] kmemleak:     [<ffffffa542e15820>]
sg_alloc_table+0x28/0xc8
[   76.674636][  T170] kmemleak:     [<ffffffa542f938a4>]
spi_map_buf+0xa4/0x300
[   76.681838][  T170] kmemleak:     [<ffffffa542f94648>]
__spi_pump_messages+0x370/0x748
[   76.689573][  T170] kmemleak:     [<ffffffa542f94c24>]
__spi_sync+0x1d4/0x270
[   76.696863][  T170] kmemleak:     [<ffffffa542f94cf4>]
spi_sync+0x34/0x58
[   76.703562][  T170] kmemleak:     [<ffffffa4cd94a638>]
spi_test_execute_msg+0x60/0x340 [spi_loopback_test]
[   76.713193][  T170] kmemleak:     [<ffffffa4cd94ae60>]
spi_test_run_iter+0x548/0x578 [spi_loopback_test]
[   76.722740][  T170] kmemleak:     [<ffffffa4cd94af24>]
spi_test_run_test+0x94/0x140 [spi_loopback_test]
[   76.732037][  T170] kmemleak:     [<ffffffa4cd94b120>]
spi_test_run_tests+0x150/0x180 [spi_loopback_test]
[   76.741498][  T170] kmemleak:     [<ffffffa4cd94b1a0>]
spi_loopback_test_probe+0x50/0xd0 [spi_loopback_test]
[   76.751392][  T170] kmemleak:     [<ffffffa542f911f4>]
spi_drv_probe+0x84/0xe0
---
 drivers/spi/spi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dc12af018350..0cab239d8e7f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1327,8 +1327,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);
 
-	spi_res_release(ctlr, msg);
-
 	spi_finalize_current_message(ctlr);
 
 	return ret;
@@ -1725,6 +1723,13 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	spi_unmap_msg(ctlr, mesg);
 
+	/* In the prepare_messages callback the spi bus has the opportunity to
+	 * split a transfer to smaller chunks.
+	 * Release splited transfers here since spi_map_msg is done on the
+	 * splited transfers.
+	 */
+	spi_res_release(ctlr, mesg);
+
 	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
 		ret = ctlr->unprepare_message(ctlr, mesg);
 		if (ret) {
-- 
2.11.0

