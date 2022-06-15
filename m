Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28154C8DE
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiFOMrv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347058AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA9DF6B
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=F15awN8fVr1aUHPApDU8EiblKTOOr8pm7ISa2F3TCnc=;
        b=wXYE3EKg+uoyduTjtzVHnRwgw3jmGPUTlaNvjQ8j8rbXCGs9xy51i9rA0HVEcF1GeaHJB81Kjo8gR
         6kMhmDIbZn8MHmj0l6Z409MvDWFrnBpQZuaMkk/Q1zaQn0IZeEOcNmXg1WUeJRD1T6/ezoObhnkliy
         90exon8i2ieXelutQzoNCxpClptqFM6TcZbOq+N4qAev7PMaQx9L21DKK9wm3PKPWxjH8yAe5nDTgV
         BJH6RAK4RlYN1vadJ99G2DbtFuTVvOG1OapiXqy6tlxu9vDwPy2h/MVn8yOJfVWQFuJqvicUcOwKyK
         g9BmH9qrRtSiB/eNTpid18jdKJJC8fQ==
X-MSG-ID: 53ad7e96-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 09/11] spi: Set ctlr->cur_msg also in the sync transfer case
Date:   Wed, 15 Jun 2022 14:46:32 +0200
Message-Id: <20220615124634.3302867-10-david@protonic.nl>
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

Some drivers rely on this to point to the currently processed message, so
set this here also.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 29f42753ef0f..3df84f43918c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3957,6 +3957,7 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 
 	was_busy = ctlr->busy;
 
+	ctlr->cur_msg = msg;
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	if (ret)
 		goto out;
-- 
2.32.0

