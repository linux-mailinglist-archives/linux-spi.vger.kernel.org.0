Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626BC1EED4B
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFDV22 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFDV21 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 17:28:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFEC08C5C0;
        Thu,  4 Jun 2020 14:28:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so4132275pgk.1;
        Thu, 04 Jun 2020 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iU5iJUMELFSmlK8SfH+sUjldtPgarSfrCWNEy+Lwh4g=;
        b=QE+bsATF+II22srCA4SunF483vWK3hPQloPGHtKJMsAqxkrApCeA2q8IjOX5YK0e+5
         ZXlp/g3KsxcDttj5VwjRGOkBRkSoj6YJ9tJrPQmm+y9dyDkxD7ttGagUEmU3+VMFhNGf
         LxNHi3ZQe+gI8lyUPJlVLuU+W+X2N40RrRWQOit7emXK3AqqURP8kqdcFzZgfQGckmsQ
         7o/gTtnw/zxdiRHRCi2u5Wt2xFxLHncLUE0fhjAkT/toViE/gGlDH8XXhekp0+BpsbdO
         MTiuIbNDLDlC/l+yvIh0PYPi1OP70l7N7bqlXB7vr+W5XC+Zc8A17OpZo7AwivgH3M2h
         ytNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iU5iJUMELFSmlK8SfH+sUjldtPgarSfrCWNEy+Lwh4g=;
        b=FpxRkyIOshoaJqmEp4SMnNeDKi/7mJrU5j0tguAzpPXn0aI9101q56IkDZIgtySJbW
         yvNWjxWoA63t+sLaDQbr+cJuFPdOhjTBv2v4hMplaSTNAfs2hh4fRYM0VwVzpGzPvgzQ
         /fkBttXVJCPWEwRXlMc7W6o/YQ9/1qmLLsH0SrLzNd/W4LNDsQ00LeRHJsNrPYfqit2U
         qUEPy6uF4iJULAVyVYxH5dUNc96TzP0XQtdmOCr0TOJXcLbctOG5GkrwiyjxDsFgryWI
         k1XNEb9f25Sxgwn0NTYv8QxCE5MyhaG2InQKr5Lqp7Z34agC7ZpuX/2jVrBWSSgNSsba
         UvpQ==
X-Gm-Message-State: AOAM533wY9HkHnkrYZVnK/iw36LhVk9yKchjGzXePFSiHxWDlAsLtlKz
        zLK9jBWqTojfZoqKlsJNVp3MtvZd
X-Google-Smtp-Source: ABdhPJxBusojGAIYyVfGCb3/XjJGxG2X3jcM+yG/UzlvGT5gG9FuSfqFsFQdcDZ+EowRT+0Iv8WYpg==
X-Received: by 2002:a62:e916:: with SMTP id j22mr6017327pfh.85.1591306106783;
        Thu, 04 Jun 2020 14:28:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v129sm5317416pfv.18.2020.06.04.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:28:25 -0700 (PDT)
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
Subject: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Date:   Thu,  4 Jun 2020 14:28:19 -0700
Message-Id: <20200604212819.715-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 4 SPI controller instances added in BCM2711 and BCM7211 SoCs (SPI3,
SPI4, SPI5 and SPI6) share the same interrupt line with SPI0.

For the BCM2835 case which is deemed performance critical, we would like
to continue using an interrupt handler which does not have the extra
comparison on BCM2835_SPI_CS_INTR.

To support that requirement the common interrupt handling code between
the shared and non-shared interrupt paths is split into a
bcm2835_spi_interrupt_common() and both bcm2835_spi_interrupt() as well
as bcm2835_spi_shared_interrupt() make use of it.

During probe, we determine if there is at least another instance of this
SPI controller, and if there is, then we install a shared interrupt
handler.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- identify other available SPI nodes to determine if we need to set-up
  interrupt sharing. This needs to happen for the very first instance
  since we cannot know for the first instance whether interrupt sharing
  is needed or not.

 drivers/spi/spi-bcm2835.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 237bd306c268..0288b5b3de1e 100644
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
+static irqreturn_t bcm2835_spi_shared_interrupt(int irq, void *dev_id)
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
@@ -1287,12 +1307,37 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id bcm2835_spi_match[] = {
+	{ .compatible = "brcm,bcm2835-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
+	irq_handler_t bcm2835_spi_isr_func = bcm2835_spi_interrupt;
 	struct spi_controller *ctlr;
+	unsigned long flags = 0;
+	struct device_node *dn;
 	struct bcm2835_spi *bs;
 	int err;
 
+	/* On BCM2711 there can be multiple SPI controllers enabled sharing the
+	 * same interrupt line, but we also want to minimize the overhead if
+	 * there is no need to support interrupt sharing. If we find at least
+	 * another available instane (not counting the one we are probed from),
+	 * then we assume that interrupt sharing is necessary.
+	 */
+	for_each_compatible_node(dn, NULL, bcm2835_spi_match[0].compatible) {
+		err = of_device_is_available(dn) && dn != pdev->dev.of_node;
+		of_node_put(dn);
+		if (err) {
+			flags = IRQF_SHARED;
+			bcm2835_spi_isr_func = bcm2835_spi_shared_interrupt;
+			break;
+		}
+	}
+
 	ctlr = spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
 						  dma_get_cache_alignment()));
 	if (!ctlr)
@@ -1344,8 +1389,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-			       dev_name(&pdev->dev), ctlr);
+	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_isr_func,
+			       flags, dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_dma_release;
@@ -1400,12 +1445,6 @@ static void bcm2835_spi_shutdown(struct platform_device *pdev)
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

