Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07254C8DC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiFOMru (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82339DF8A
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=K27EsJYcV5D6XaF1RNfZBWqOwfz0qgxJ/954VGvD+DA=;
        b=lNzHuEC4QSAign18zu1jKThBnQCz5gsjMWPanK0kKH3yOb96f/UwkJi2nQKQbwsvhX4FP81Tb9PKC
         R2FrAKwQQ8qLHMOK0XzhGF2UiyxQGdvmKU10lGXwgIAhLRR1V4RlByhIFC3u0sPxlNxd8qZCYWmA85
         wOHVXRU13zgf+8sB9zRC/XjZkKEo6IVjqhvw6MOMvWhQlL9/Hkj0tzosEcxN2xmfLOPwdXu9jGSjYS
         qxfEb5mnBScSjHNSDdNVSl87xVEuouEl9xe1y7gMkfZaFrQDfdBR6JbK1Ijusei6p8Ru/AuM3U6FL9
         UjmwvgnudkuATq3uwKd10uFBqeu1rWA==
X-MSG-ID: 53a9944d-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH 08/11] spi: Remove unneeded READ_ONCE for ctlr->busy flag
Date:   Wed, 15 Jun 2022 14:46:31 +0200
Message-Id: <20220615124634.3302867-9-david@protonic.nl>
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

Now this flag is written entirely in the mutex, so no need for READ_ONCE

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 52736e339645..29f42753ef0f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3955,7 +3955,7 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 
 	mutex_lock(&ctlr->io_mutex);
 
-	was_busy = READ_ONCE(ctlr->busy);
+	was_busy = ctlr->busy;
 
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	if (ret)
-- 
2.32.0

