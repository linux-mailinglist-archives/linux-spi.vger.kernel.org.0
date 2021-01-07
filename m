Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32912EEA11
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 01:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbhAHAAA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 19:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbhAHAAA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 19:00:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBCC0612F8
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 15:59:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a188so5071199pfa.11
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gVWRVkXWEtpIQllAztl5ByGC/c1eu5QBEtUSi0NXW/E=;
        b=i2YgCFwgtZZdzRZJD4YSySL+q2WsW9ZSAkmserIOkBQABL1Cl6Xj+Fz0WYqQEi4png
         Y1V8zuiIrxG6y1fSAHsrqb0IJPI/bwuDcdEh60XvU8mqNiPYn78RAEemIn/DupetEaL7
         RFTNQDuZmagTKCjD+1xmsSinxjHAUCxBRR9+0lg1yHM1JaYSPgik4JXN6ovAo59ckBJG
         k74Mb62iLRIVxvXxCUFmRNOY8jfviVzfjqqfubRKbfYRm4vZnotTkC+qgLb0Nm8y98rd
         QGS+5IgvGfyKq8aNtflEXaLM6nwfGWAKw9vUkRAINbOzWPelHiqpzcjKtUILw6OeUcWU
         hovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVWRVkXWEtpIQllAztl5ByGC/c1eu5QBEtUSi0NXW/E=;
        b=S+yip80bxr08oYsLjYkLCE7tHAP++u9Xr9TmAo7bFWT+YIKe/EduZkHo/OleNoZVJh
         iaR0FseB5q8TD9qxWXpS4Kduyb/o40u4WfkA6oE3yEbjLXpo2xy9dAr/QltB8I1A3Rci
         6asAjzvF42uvhin9OxDG7oCYzNFWJcapxG0KEZVBF46owpIo2OVWNqd2+oDBsPx1qv+I
         XOTjZVw78mDMIx9DEpHnraGH3ZzgxiZKexbTV01ai/y6qm30kc5UUX/mniPBmPN3HQVX
         Xz76CBEzE9JNYSvAWGBSPhC2Z97vBVSzD5D9FyfMNQ5kRmmGeXY8hYOaK7Jjk8fx5FbS
         dWkg==
X-Gm-Message-State: AOAM5302/wIbn4TXWIxD3UBp37V2fU2CZ03dMgvYcItRbLxUm1ZYf2D6
        rcMu+jet2oF0OpJLVMkppoQ=
X-Google-Smtp-Source: ABdhPJy63j9zOI2U7M1X9Cl7DDOIvjhpbkAHlxM9fj1EcOvbRS5cAbyP56glxIhoqpxTXx1uNFvn8A==
X-Received: by 2002:a63:c64:: with SMTP id 36mr4200685pgm.255.1610063959705;
        Thu, 07 Jan 2021 15:59:19 -0800 (PST)
Received: from x2.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id bf3sm6448195pjb.45.2021.01.07.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:59:19 -0800 (PST)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [2/3] spi: bcm2835aux: Call the dedicated transfer completion function.
Date:   Thu,  7 Jan 2021 23:58:31 +0000
Message-Id: <2636096a3b40febf680f9fff33944a5480561df9.1610062884.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
References: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_finalize_current_transfer currently only calls "complete", so no
functional change is expected.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 1a26865c42f8..75589ac6e95f 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -254,7 +254,7 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	/* and if rx_len is 0 then disable interrupts and wake up completion */
 	if (!bs->rx_len) {
 		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
-		complete(&master->xfer_completion);
+		spi_finalize_current_transfer(master);
 	}
 
 	return IRQ_HANDLED;
-- 
2.30.0

