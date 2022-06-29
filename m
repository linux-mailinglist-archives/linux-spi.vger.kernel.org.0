Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9E56029C
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiF2OZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiF2OZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:25:33 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BB25585
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=BH023I3zjWQtof7ybwZbCInHixyy7og+vqA89Cm+0HQ=;
        b=qF1KrhvMH+/DtKuvszQJPe/MKldvjfDP4wEWR2P0Wo1CnqEm2deYyboU+7MJDvHE42SeNt1zazQBR
         +qkf/Acb4LD9/DxKvfWIL9rTCxxWzrK0REzplwhIm/P8tP+Q5TK6+u83cNRXYvKi6J+2Lkbvf5YMik
         MWgZ0bGdIiZnmUC4owM75qtj1UBGK/gTRndGBUVaQFZXrYi94nbUVMZjqKuXpx3GUg0sqXIbYM5KRM
         Egs5ZoF6cLQRRBMCLQ3jsGW1VZBv5wIVWP2BMNgptHNiuFcCHKdIT5nOzS/uQcYmFugJrWtDBkDHym
         GwvI9neSkcCE/4oeEwqZTGpbGo3M3+Q==
X-MSG-ID: 537ced2f-f7b7-11ec-ba03-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH 3/3] spi: spi.c: Remove redundant else block
Date:   Wed, 29 Jun 2022 16:25:19 +0200
Message-Id: <20220629142519.3985486-4-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629142519.3985486-1-david@protonic.nl>
References: <20220629142519.3985486-1-david@protonic.nl>
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

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 09d4959bc09c..dc1a324e3271 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1636,13 +1636,13 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 		dev_err(&ctlr->dev,
 			"failed to transfer one message from queue\n");
 		return ret;
-	} else {
-		WRITE_ONCE(ctlr->cur_msg_need_completion, true);
-		smp_mb(); /* see spi_finalize_current_message()... */
-		if (READ_ONCE(ctlr->cur_msg_incomplete))
-			wait_for_completion(&ctlr->cur_msg_completion);
 	}
 
+	WRITE_ONCE(ctlr->cur_msg_need_completion, true);
+	smp_mb(); /* See spi_finalize_current_message()... */
+	if (READ_ONCE(ctlr->cur_msg_incomplete))
+		wait_for_completion(&ctlr->cur_msg_completion);
+
 	return 0;
 }
 
-- 
2.32.0

