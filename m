Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC9261F9B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbgIHUFP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 16:05:15 -0400
Received: from smtp1.axis.com ([195.60.68.17]:2534 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgIHPV6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2150; q=dns/txt; s=axis-central1;
  t=1599578517; x=1631114517;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=z/BDmdjM/v/uKUwksEvqIKwATDtNWqz2DB9Hmgj+6lI=;
  b=F3BTmHD2mdT1WXEEkZzcolZFLjgsQXzaSuLh4FlbUkup09URqOAyjxIM
   0Z5/6EMQXkyCElO+6MaCXerbMtNA18eaA3eAkuaJ5+bYMgGRqBPfUI1+9
   dN6fTuuF4VGoHxvLp87OsYph85uYtSRUU9gTU5dv7S/m36HRmOHpq2oAT
   O5/myKJrtj0OfyboqMn+rYuSdP2/GICy67R5OTnQxx6YpTatz2/WiHuxN
   Q7pXXIJqkewfgMgAZ0WVal1dJkWdrJJpqM1zM/iPb5clembn+NUIwRwDZ
   qESCKgab+T2rp9ozw/WCtNK+lY2S0O9YjW/wZ3lHiscrGzM0CH7BQ1Wm5
   w==;
IronPort-SDR: IT/QAfd20aFr8qbGpXRLXsMAMov3y2s6L0C9ldlUP4Tnl1I39sXcoRkW18Qb3nDnfGfJJGHaCd
 dybcBRCanCsSt2hiO2LNwPmGjh73qe8oSan+yt9KWXKp5hjG2NKltMVEPLXpo0dVchg9Kp3JuT
 6sMIujYbtmZNpKHiFICNYoDGu0pTTlE4bpH+kpA1WOoSnoAN9xs4bKb4NMDjcLKmwc1c9zrHRt
 FkQrmKl/XUBZUmZkl8uXUn4uUXPRoNpW6/nHDCOVBAPJ+dW+UVyS5b8Ec9xFkBtRIwGhAedAHr
 sQ0=
X-IronPort-AV: E=Sophos;i="5.76,406,1592863200"; 
   d="scan'208";a="12672457"
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel@axis.com>,
        Gustav Wiklander <gustavwi@axis.com>
Subject: [PATCH v3] spi: Fix memory leak on splited transfers
Date:   Tue, 8 Sep 2020 17:11:29 +0200
Message-ID: <20200908151129.15915-1-gustav.wiklander@axis.com>
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

Kmemleak:
sg_alloc_table+0x28/0xc8
spi_map_buf+0xa4/0x300
__spi_pump_messages+0x370/0x748
__spi_sync+0x1d4/0x270
spi_sync+0x34/0x58
spi_test_execute_msg+0x60/0x340 [spi_loopback_test]
spi_test_run_iter+0x548/0x578 [spi_loopback_test]
spi_test_run_test+0x94/0x140 [spi_loopback_test]
spi_test_run_tests+0x150/0x180 [spi_loopback_test]
spi_loopback_test_probe+0x50/0xd0 [spi_loopback_test]
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

