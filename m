Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6682552ADA
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbiFUGMt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345618AbiFUGMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:45 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FD186E3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=h7h2OdTZM5QjhOhXH4N7Lr5PvnITA26Ut5j2+5THjOQ=;
        b=qhozYrpNUQGmeUj1Z/3bRaYxiAfNsHxjH87bcRCsDciiZtMALjuokRwW8ATpGA86aiOIZd3YDiZPe
         KPpVktz1Ki0jnYVM6GEDWEZ01Rtl3QJRxxafZ4iylPEe6CITK3I61DkdmE6ffvqyZ5GmhEGJG8Ep93
         I25Hj5OtHtmTXnTw/TfIUAgjIY4BH1CJHWkxqeYzRdA9Tuy9jFj6mlmEAAdShpWDfkCYwaUn7j/VWN
         nELLRpOKgqKvazQrXT7EOPvZ3lOd7rEEO/F2bjuoNm3rmn5ZbcHuC1dvfPHE69EmWAlubx6LtWfXhz
         dDohCcwKeHaBkfYl844oNZiw3sUgEzg==
X-MSG-ID: 267befbe-f129-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 06/11] spi: Remove check for idling in __spi_pump_messages()
Date:   Tue, 21 Jun 2022 08:12:29 +0200
Message-Id: <20220621061234.3626638-7-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the whole idling transition is locked by the io_mutex now, there is
no need to check this flag anymore.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d8d2b7ac78f2..71b767a9ad77 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1653,13 +1653,6 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	if (ctlr->cur_msg)
 		goto out_unlock;
 
-	/* If another context is idling the device then defer */
-	if (ctlr->idling) {
-		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
-		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-		goto out_unlock;
-	}
-
 	/* Check if the queue is idle */
 	if (list_empty(&ctlr->queue) || !ctlr->running) {
 		if (!ctlr->busy)
-- 
2.32.0

