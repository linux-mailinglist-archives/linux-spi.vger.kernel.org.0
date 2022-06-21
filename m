Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5B552AD9
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbiFUGMr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiFUGMo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:44 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE71DA46
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=K27EsJYcV5D6XaF1RNfZBWqOwfz0qgxJ/954VGvD+DA=;
        b=LJhROd9lEl5z4+uwE2F+yTkc+67hC4CB+BT6vaEFAxhtn9+VsngjCee7Dkqyz3v4Aq7K/2ZOOIrp2
         aawzQWoXbbiY74YfzZSdIF0voUgx3vgSDpvrYPdGtxCSq20odO45fRfGHSsjslMJg/EvwU4qw0qPVJ
         +X6HPQGoqDg/3LCaWH84tS/EQ6dqro8MF5XbgSpYpJbhp0ZFe4+z5gDQcyj8lpP552ns3hzfWFUd8D
         GV2ipkn0xllmHpRSCpzESF5smj0FJGISrgLxp1/iAaVTpnhn6NZXQE5utfNwB5TyXnqnZgZnTRvmLz
         6/LH2RC7u/QgrUszc78NUyjkVoa+EbA==
X-MSG-ID: 267edf0d-f129-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 08/11] spi: Remove unneeded READ_ONCE for ctlr->busy flag
Date:   Tue, 21 Jun 2022 08:12:31 +0200
Message-Id: <20220621061234.3626638-9-david@protonic.nl>
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

