Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D65797FC
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiGSKxi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiGSKxT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 06:53:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AC402C7
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 03:53:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDkqp-00042f-7i
        for linux-spi@vger.kernel.org; Tue, 19 Jul 2022 12:53:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 41DB7B3F7A
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 10:53:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BA255B3F74;
        Tue, 19 Jul 2022 10:53:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f2241ab7;
        Tue, 19 Jul 2022 10:53:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     kernel@pengutronix.de, Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Mark Brown <broonie@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] spi: bcm2835: enable shared interrupt support
Date:   Tue, 19 Jul 2022 12:53:05 +0200
Message-Id: <20220719105305.3076354-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

BCM2711 shares an interrupt betweem 5 SPI interfaces (0, 3, 4, 5 & 6).
Another interrupt is shared between SPI1, SPI2 and UART1, which also
affects BCM2835/6/7. Acting on an interrupt intended for another
interface ought to be harmless (although potentially inefficient), but
it can cause this driver to crash - presumably because some critical
state is not ready.

Add a test to the spi-bcm2835 interrupt service routine that
interrupts are enabled on this interface to avoid the crash and
improve efficiency.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Link: https://github.com/raspberrypi/linux/issues/5048
Suggested-by: https://github.com/boe-pi
Co-developed-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm picking up the work of Martin Sperl et al. to bring the shared
interrupt support for the bcm2835 driver to mainline.

The original version of this patch was added in ecfbd3cf3b8b ("spi:
bcm2835: Enable shared interrupt support"), but later reverted as
d62069c22eda ("spi: bcm2835: Remove shared interrupt support").

Here the original version causes transfer timeouts, which lead to
driver crashes. This is fixed by first checking if the interrupts are
actually enabled, before serving them. The fix has been taken from the
rapi downstream repo and squahed into this commit.

The updated version of the patch successfully runs with concurrent SPI
accesses on SPI0 and SPI3 without problems.

regards,
Marc

Changes since v1: https://lore.kernel.org/all/20200528185805.28991-1-nsaenzjulienne@suse.de
- check for if interrupts are enabled before serving IRQs

 drivers/spi/spi-bcm2835.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 775c0bf2f923..9bdb1b85ae08 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -372,6 +372,10 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	struct bcm2835_spi *bs = dev_id;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

+	/* Bail out early if interrupts are not enabled */
+	if (!(cs & BCM2835_SPI_CS_INTR))
+		return IRQ_NONE;
+
 	/*
 	 * An interrupt is signaled either if DONE is set (TX FIFO empty)
 	 * or if RXR is set (RX FIFO >= ¾ full).
@@ -1365,8 +1369,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);

-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-			       dev_name(&pdev->dev), bs);
+	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt,
+			       IRQF_SHARED, dev_name(&pdev->dev), bs);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_dma_release;

base-commit: a3fd35be0eda760610a63e179ad860189b890f0b
--
2.35.1

