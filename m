Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABC268DF3
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgINOjU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgINNFm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:05:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEEC2224B;
        Mon, 14 Sep 2020 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600088699;
        bh=QaATxbJtJyusY9LwI1jhp7H112Uul8PCsqbACGYf+3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0uo1JZSnBqI6b6u3OZFcPzIQYoni00bHScb2TjSIiGzWb8Btn5mV5Vo4A6fFsIlz8
         35sMaP/qTFO6CMZnhi8mQ4EoMJcm4CPp7+Zmf+A3BzOiZ3FvcPdpQeW5Pv9FTMQitx
         6D+ad5XlmL1E2Y77Q/g08NxoD7pnB1G0jBwg+3ko=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gustav Wiklander <gustavwi@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/22] spi: Fix memory leak on splited transfers
Date:   Mon, 14 Sep 2020 09:04:32 -0400
Message-Id: <20200914130434.1804478-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130434.1804478-1-sashal@kernel.org>
References: <20200914130434.1804478-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Gustav Wiklander <gustavwi@axis.com>

[ Upstream commit b59a7ca15464c78ea1ba3b280cfc5ac5ece11ade ]

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
Link: https://lore.kernel.org/r/20200908151129.15915-1-gustav.wiklander@axis.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6a81b2a33cb4b..982753ac1bf6c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1241,8 +1241,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	if (msg->status && ctlr->handle_err)
 		ctlr->handle_err(ctlr, msg);
 
-	spi_res_release(ctlr, msg);
-
 	spi_finalize_current_message(ctlr);
 
 	return ret;
@@ -1525,6 +1523,13 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
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
2.25.1

