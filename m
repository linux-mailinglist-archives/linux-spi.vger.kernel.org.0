Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEF54C8DB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbiFOMrt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82202DF87
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=h7h2OdTZM5QjhOhXH4N7Lr5PvnITA26Ut5j2+5THjOQ=;
        b=mR4NmljUUwWqotYmSjTJmP4wo8Tn9wtY4u18bXze+5TQWgcneVWeJfD8O5YKQA8EKN31cHjf/mXWF
         gPH1waLO4k9q2b22C8rFNG6hHqp3IVBi3uCcY3SQqX7JfehIE4vW45X8Lb6tjAwfqHo4JToZLPTzsT
         lA/1fZoLCXFlKQx7f61ziJYJKbmM2hageHgxFWeDxj7OvJI/0UxSYW/bc8fCsAdNQtNBI9sedE3FBP
         b9DkbJ56KG5MZEK4AoXYGr/vMRz/Xka6txN9XTWfVHnBemczx+FCZyQ8+bLX2IGHQR2DMwN7cqD4wG
         zSeAwndEMepAMae7y+gWZ+Vw7DTWWtw==
X-MSG-ID: 53a52f6d-eca9-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 06/11] spi: Remove check for idling in __spi_pump_messages()
Date:   Wed, 15 Jun 2022 14:46:29 +0200
Message-Id: <20220615124634.3302867-7-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220615124634.3302867-1-david@protonic.nl>
References: <20220615124634.3302867-1-david@protonic.nl>
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

