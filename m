Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041911E6A0C
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406170AbgE1TGr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406108AbgE1TGp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 15:06:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B997CC08C5C6;
        Thu, 28 May 2020 12:06:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so178056wmd.0;
        Thu, 28 May 2020 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4KhJ0czAtInc6S6Xs9xVMwv9E2Cl3DrgPdxIonc8bGQ=;
        b=GQo3w7YNGghCGU1XnVGFhDTXxN7CHLJy5jHWuFWHMjmjY1DpiRjBbt3+fX52jRH4pB
         tA7eVVSlE8fR6l6YVf4FMcg3QGw9Z4pYlIDgPgZQSKKV0j0dosHPzhtTCtH/hxbp8Z2y
         YuT2OSFUyqo1p6xnZfv8yGsn6IgyZ/RY86XrNTrF0cTQGOs4xKDcQU4XJo66BJucPbkh
         W5v7+w+PalWr2jdmjB/N73DKTQh3rTNR/KstTYX1AUE4noSPD5J/z5TOrbuX6rwdWBNw
         2qQE+YZUHkiPOLlLyRhr2ItFHrJwv/nAD1BZX2bfCWn2p0EBGiOpRV39kIQHiLNRaCGl
         W17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4KhJ0czAtInc6S6Xs9xVMwv9E2Cl3DrgPdxIonc8bGQ=;
        b=qa+QaAAGS7iSaRck7nFs4X9Kh1gVsUec/pb/VSI5Zil3EMZ6E5QwvFM5Sp3KvLSz/W
         fcLsFMtPXEFcF0JFXmVDEIBT0+S4gdllqM0b6VkjixHR28S8bitkUUMgpi6ufjUQmvDm
         ODMClL24cfvhKUtaaBKOV0H1YmGCLFD7swBCwHIMQIwl2OS3mTCBYWv1z8ssb9r2zwQ4
         /AxedYiA7WX8dEa7v138DEWTYjsDBq+OMmSC9CyvS+BK/TFjPDkSBJllYYt6QXKgra7D
         70cXUY5XmM9vzYoIIYGqqwQSOx9R9KKmnXxG4w8HBrq4m5R1hEP+7D1/aOs0sErer9hj
         9zNA==
X-Gm-Message-State: AOAM5300G2kHCxPIq7wbPxdh/ghDXeBz18Btd4f/NmIcBe60mP96/Pjd
        qTr/I38AIJt1UwmuCmhlNlYoVwu/
X-Google-Smtp-Source: ABdhPJwodjVwERbd9IbT6+7c3t6iPtNjLkkwJVDncWF6oaZ/MtkezkiKEFsDJCsEzoaJBToaLSlodw==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr3731402wma.87.1590692803224;
        Thu, 28 May 2020 12:06:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p7sm6953516wro.26.2020.05.28.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:06:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH] spi: bcm2835: Implement shutdown callback
Date:   Thu, 28 May 2020 12:06:05 -0700
Message-Id: <20200528190605.24850-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make sure we clear the FIFOs, stop the block, disable the clock and
release the DMA channel.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 20d8581fdf88..237bd306c268 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1391,6 +1391,15 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void bcm2835_spi_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = bcm2835_spi_remove(pdev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to shutdown\n");
+}
+
 static const struct of_device_id bcm2835_spi_match[] = {
 	{ .compatible = "brcm,bcm2835-spi", },
 	{}
@@ -1404,6 +1413,7 @@ static struct platform_driver bcm2835_spi_driver = {
 	},
 	.probe		= bcm2835_spi_probe,
 	.remove		= bcm2835_spi_remove,
+	.shutdown	= bcm2835_spi_shutdown,
 };
 module_platform_driver(bcm2835_spi_driver);
 
-- 
2.17.1

