Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC461EDBE5
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 05:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFDDrH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 23:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgFDDrG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 23:47:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A7C08C5C0;
        Wed,  3 Jun 2020 20:47:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so2718072pfi.13;
        Wed, 03 Jun 2020 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QQ6Hyh/m2EhPIKuAygxezflBAl58W/VBXN+x76AFtqs=;
        b=B0/8qGwjkJ+zdXPjuEpW0NvP34Qn50UqLSD1UlkyU+uP+WAYx3+tL4pgemaok2OEzk
         CiHrVQVPFAhZTIbUm30Wz7K2a1Tm5uzc0CnG70c9RBzjCyJjTLUInaZBkVFAADTCdxEg
         wuSSJWKjxXHtlRxb7F3qDu81yDJCiVqbW/B5+CZom5dIBmCSQw6nCa6YindB3CDzleh7
         ufysFY89IT01nWs9e2loDh8njH2quflbkFG0ZwEH/v2Wh2ac0HK4/MM0zsigo7M/uryW
         wKVsoP4wsgjoIbs9n+45JNd8AyQaSqgmDd+ekrkcydGCguZbDPLW3GVY5ARUYWD+NQyv
         M3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QQ6Hyh/m2EhPIKuAygxezflBAl58W/VBXN+x76AFtqs=;
        b=WImZ94r0Dr1eA92KWf4zxT80YwVZJJu8IQUIooaFCj6UX3sLqIP3qP5M5uoKOiOVFc
         Eo9X1kLYPZwieeafE6SCrYufq61OrTVMVcGz4KQtXgTTl2FBnCWS6MeERO+WergZhj/3
         oeKNIra2q85cvyp1rRdscVRTZtcRWpZnMpayO7Vm4OUT7IWtPu9OfwAg5Fmkh58H8X5e
         sTYU2lO4QWv0hveOU9PX0tfZm14FLogVDWS2+vAV4BbM8dxlDeGlkAN5ulrXnoRnC5ar
         041kTc0t/zSkKZKYzeo2y/InulzdxuqEMlD+Cx5F7ml1Q7PF4YWBzFcv8xGNlTclhZ/D
         v+gg==
X-Gm-Message-State: AOAM533LwxRcl8/AJr3MilkWYRqoBhiIY/gD23bzLqvWEr/IETqF6hEZ
        ZK6OgaMZFQfFQ8cktEe+cRkgeJN7
X-Google-Smtp-Source: ABdhPJwbqlo5gRwaKOl0uPy+5X9nNBxzaPZErf6Kvavs7jP4lLEx9XgMSZvc12iLCbVBqhcgwHO+vQ==
X-Received: by 2002:a62:1885:: with SMTP id 127mr2292423pfy.258.1591242424241;
        Wed, 03 Jun 2020 20:47:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p19sm3083367pff.116.2020.06.03.20.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 20:47:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
Date:   Wed,  3 Jun 2020 20:46:55 -0700
Message-Id: <20200604034655.15930-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604034655.15930-1-f.fainelli@gmail.com>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controller found in the BCM2711 and BCM7211 SoCs is instantiated
5 times, with all instances sharing the same interrupt line. We
specifically match the two compatible strings here to determine whether
it is necessary to request the interrupt with the IRQF_SHARED flag and
to use an appropriate interrupt handler capable of returning IRQ_NONE.

For the BCM2835 case which is deemed performance critical, there is no
overhead since a dedicated handler that does not assume sharing is used.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 48 +++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 237bd306c268..2e73ec70ee80 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -361,11 +361,10 @@ static void bcm2835_spi_reset_hw(struct spi_controller *ctlr)
 	bcm2835_wr(bs, BCM2835_SPI_DLEN, 0);
 }
 
-static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
+static inline irqreturn_t bcm2835_spi_interrupt_common(struct spi_controller *ctlr,
+						       u32 cs)
 {
-	struct spi_controller *ctlr = dev_id;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/*
 	 * An interrupt is signaled either if DONE is set (TX FIFO empty)
@@ -394,6 +393,27 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *ctlr = dev_id;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	return bcm2835_spi_interrupt_common(ctlr, cs);
+}
+
+static irqreturn_t bcm2835_spi_sh_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *ctlr = dev_id;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	if (!(cs & BCM2835_SPI_CS_INTR))
+		return IRQ_NONE;
+
+	return bcm2835_spi_interrupt_common(ctlr, cs);
+}
+
 static int bcm2835_spi_transfer_one_irq(struct spi_controller *ctlr,
 					struct spi_device *spi,
 					struct spi_transfer *tfr,
@@ -1287,12 +1307,26 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id bcm2835_spi_match[] = {
+	{ .compatible = "brcm,bcm2835-spi", .data = &bcm2835_spi_interrupt },
+	{ .compatible = "brcm,bcm2711-spi", .data = &bcm2835_spi_sh_interrupt },
+	{ .compatible = "brcm,bcm7211-spi", .data = &bcm2835_spi_sh_interrupt },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
+	irqreturn_t (*bcm2835_spi_isr_func)(int, void *);
 	struct spi_controller *ctlr;
+	unsigned long flags = 0;
 	struct bcm2835_spi *bs;
 	int err;
 
+	bcm2835_spi_isr_func = of_device_get_match_data(&pdev->dev);
+	if (bcm2835_spi_isr_func == &bcm2835_spi_sh_interrupt)
+		flags = IRQF_SHARED;
+
 	ctlr = spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
 						  dma_get_cache_alignment()));
 	if (!ctlr)
@@ -1344,7 +1378,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
+	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_isr_func, flags,
 			       dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
@@ -1400,12 +1434,6 @@ static void bcm2835_spi_shutdown(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to shutdown\n");
 }
 
-static const struct of_device_id bcm2835_spi_match[] = {
-	{ .compatible = "brcm,bcm2835-spi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
-
 static struct platform_driver bcm2835_spi_driver = {
 	.driver		= {
 		.name		= DRV_NAME,
-- 
2.17.1

