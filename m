Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D87552AD8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiFUGMt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbiFUGMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:45 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6419C05
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=Rx8m4LW9ySJ0xiERX/MhZmzWCLriIcDzwVdLW/HEd9E=;
        b=iDO8e1bBs9t/KXCYoaq6Ab4XSC9zgH14CqpzqzfpJkBU3UJeSPtTsMmy14vmynUSpEowwrAjz6oti
         Rge9IjeLdtrn8vOrqMXbKcnOMOArwEY2Rykoptwn8AtWRXOAQG+AVQRUymrvnC8SWKbkpU9C38dRk1
         xL5qvw4/gZKIUjx+a8c5hh0ypEfeBU55N05VNFPIwE7pCYqUo8sNwtMewzIlc3AxiAcJw0OqKAWneR
         mXS/smpSq9zEtgYjhyfOi/9XCrqvya2Nuw9xyAKDfVNso6hmKP3lFYRPxuOW0qE9QxLYKzZviFfvnI
         iSR3QXrmcP54V8JmtYmJaGtrZzy3JCg==
X-MSG-ID: 267bf568-f129-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 05/11] spi: Remove check for controller idling in spi sync path
Date:   Tue, 21 Jun 2022 08:12:28 +0200
Message-Id: <20220621061234.3626638-6-david@protonic.nl>
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

Now that the idling flag is wholly behind the io_mutex, this broken piece
of code can be safely removed.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fa2d091d2854..d8d2b7ac78f2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3964,10 +3964,6 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 
 	mutex_lock(&ctlr->io_mutex);
 
-	/* If another context is idling the device then wait */
-	while (ctlr->idling)
-		usleep_range(10000, 11000);
-
 	was_busy = READ_ONCE(ctlr->busy);
 
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
-- 
2.32.0

