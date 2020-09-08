Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C3D260E82
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgIHJRo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 05:17:44 -0400
Received: from smtp1.axis.com ([195.60.68.17]:26583 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgIHJRk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 05:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2659; q=dns/txt; s=axis-central1;
  t=1599556660; x=1631092660;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1Le6jlzzDWoy8wF4SF4a/XhkEuJNl4OtPQ4nZDiadg8=;
  b=BJ/0vmvmVrMI/V+Z+ZUliDZdQ89xmZyQoY/eAydg4kt5MO4B2sizeZWo
   UdigdfNcuetxvzA4jT0RLJP7gwi8iO/ZGWtdEVYwqDJ9skulWDkzK/Vkk
   xLA1fgXMQxnN1b0IBNUnzpj+bzENf+hUEiNbk7MwhEUeqVYbVD+/GK1qs
   +OYWoZhNwfyNMqFQrlW/s3VaYFbubxiEOToHVqi94AGuYe4S6fAEEpwUk
   DR16HtRZPQ9dXfFSj/+bGt+FTz9jB2KgXAKtNH6RmWmlzEM4NnYTLR55X
   4fMh83yEC+qKE0AnaLjIaiiTwCgJJLQpuTuboQBfF8Suw3jCJtbkAJPQu
   A==;
IronPort-SDR: Ze8+iPgvIrJSo2MLXzNFVw4EsNcdJthDmM9ut8PlDV45QBM23dj7qHP7arI64g1lcTI9vynTHZ
 /2pb8+JBwoDPPohDHXIiigvPXH7OaUKE3c3llPnuqCjVpV11W/T1VfU1ZiHyYey9g5dr1G3Yb5
 m3fML5/I8bV1dULcPdWiYzp+X2YieLCSd5vuXAxKsTUmZyUAGDAK0pMQ+CgcwatdlNifTlvM9V
 CLtfd2GaF/e/UUTL9+cCF7uzGIYdNVDPodCtRQNEdVSLcq5bEgzNlj8j64qwyQxCxz6GonjCDI
 Xuc=
X-IronPort-AV: E=Sophos;i="5.76,405,1592863200"; 
   d="scan'208";a="12654923"
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel@axis.com>,
        Gustav Wiklander <gustavwi@axis.com>
Subject: [PATCH v2] spi: Fix memory leak on splited transfers
Date:   Tue, 8 Sep 2020 11:17:36 +0200
Message-ID: <20200908091736.29782-1-gustav.wiklander@axis.com>
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

Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
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

