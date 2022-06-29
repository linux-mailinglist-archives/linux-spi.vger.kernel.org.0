Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5756028C
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiF2OZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiF2OZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:25:33 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1024967
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=bqDVG5jU/zNxxT3QbjSEH7xFS0LEmBCZzxKEukPidiE=;
        b=PEn2LgIl4Vt/rY5N/UmbYpHrO4kD9VqTIjs5cKNLtEl2M5G94YaSXchHt3inWQomi95ULJy06XK4a
         +BhOF3inh/XHOqFFirqH/EuhXiTibWR1rh1jiU86O4krML6K3dwrawO9z73GHTybBgPU4Nx9tAQh+t
         YYKRXIf23S8jL5a4YMveC/oJmgWjlUuiHSwRZYcNUkngggH27DTOQIjhw13CAIqF+mQ2s8o93aZu2D
         FTQ544uaP5lRyEK+pg/Lf2MUCxqpl3aVwuI0xf+x36iNjTyLAPRq/JWASZiJhC/5MDVmJK1Ss+Cve2
         RdMlERgl8WkacHIuQU7fSZtrBxZ7qNg==
X-MSG-ID: 535e01cc-f7b7-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH 1/3] spi: spi.c: White-space fix in __spi_pump_messages()
Date:   Wed, 29 Jun 2022 16:25:17 +0200
Message-Id: <20220629142519.3985486-2-david@protonic.nl>
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
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b9ac89ee9d05..b910f7a6c238 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1727,9 +1727,9 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
-
 	if (!ret)
 		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
+
 	ctlr->cur_msg = NULL;
 	ctlr->fallback = false;
 
-- 
2.32.0

