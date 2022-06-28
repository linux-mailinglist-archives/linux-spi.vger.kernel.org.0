Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB38C55C1AF
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiF1C3p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiF1C1q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 22:27:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729A11817;
        Mon, 27 Jun 2022 19:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C2F9B81C1C;
        Tue, 28 Jun 2022 02:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AFEC341CD;
        Tue, 28 Jun 2022 02:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656383122;
        bh=AXOpLtmygDQSaGsn8bHuAaZY/nOQEAeexroHpfGGBtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhlCC3m24Nzai1QTCZGhKrjbjodvbdMVyFyI9gUyKu1fHNVW9mozBabqF53DrPivO
         MyPUFxY7MTM+GvFKuVSNX0Yq9Jz/3yszBgigtEmFWHVlqSppwPrzkH05c11uS3gyY/
         XaWomj+dnoXQ4U8iV0VBWr/xihw0xsnx4wO0nURM56N68rQSNGPXAQGJv135M9SeDs
         fQ1wARLMnF+gbEb7VCWBytZyK2BrQkrWMylxIZqdMZnSp4Wwl2FgPSRgEO+N8bq9Eg
         EskKqLSxTP3EbzQsNj/MQnRZSnIh9MZWfJccovS0iTxL1HaOMGD/CxxQICndTabLZs
         tEkh8lj7Cs98Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/22] spi: cadence: Detect transmit FIFO depth
Date:   Mon, 27 Jun 2022 22:24:57 -0400
Message-Id: <20220628022518.596687-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022518.596687-1-sashal@kernel.org>
References: <20220628022518.596687-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 7b40322f7183a92c4303457528ae7cda571c60b9 ]

The depth of the transmit FIFO for the Cadence SPI controller is currently
hardcoded to 128. But the depth is a synthesis configuration parameter of
the core and can vary between different SoCs.

If the configured FIFO size is less than 128 the driver will busy loop in
the cdns_spi_fill_tx_fifo() function waiting for FIFO space to become
available.

Depending on the length and speed of the transfer it can spin for a
significant amount of time. The cdns_spi_fill_tx_fifo() function is called
from the drivers interrupt handler, so it can leave interrupts disabled for
a prolonged amount of time.

In addition the read FIFO will also overflow and data will be discarded.

To avoid this detect the actual size of the FIFO and use that rather than
the hardcoded value.

To detect the FIFO size the FIFO threshold register is used. The register
is sized so that it can hold FIFO size - 1 as its maximum value. Bits that
are not needed to hold the threshold value will always read 0. By writing
0xffff to the register and then reading back the value in the register we
get the FIFO size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/r/20220527091143.3780378-1-lars@metafoo.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ea7ba502c1eb..405f4fdbc42c 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -97,9 +97,6 @@
 #define CDNS_SPI_ER_ENABLE	0x00000001 /* SPI Enable Bit Mask */
 #define CDNS_SPI_ER_DISABLE	0x0 /* SPI Disable Bit Mask */
 
-/* SPI FIFO depth in bytes */
-#define CDNS_SPI_FIFO_DEPTH	128
-
 /* Default number of chip select lines */
 #define CDNS_SPI_DEFAULT_NUM_CS		4
 
@@ -115,6 +112,7 @@
  * @rx_bytes:		Number of bytes requested
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
+ * @tx_fifo_depth:	Depth of the TX FIFO
  */
 struct cdns_spi {
 	void __iomem *regs;
@@ -128,6 +126,7 @@ struct cdns_spi {
 	int rx_bytes;
 	u8 dev_busy;
 	u32 is_decoded_cs;
+	unsigned int tx_fifo_depth;
 };
 
 struct cdns_spi_device_data {
@@ -313,7 +312,7 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 {
 	unsigned long trans_cnt = 0;
 
-	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
+	while ((trans_cnt < xspi->tx_fifo_depth) &&
 	       (xspi->tx_bytes > 0)) {
 
 		/* When xspi in busy condition, bytes may send failed,
@@ -534,6 +533,24 @@ static void cdns_spi_cleanup(struct spi_device *spi)
 
 }
 
+/**
+ * cdns_spi_detect_fifo_depth - Detect the FIFO depth of the hardware
+ * @xspi:	Pointer to the cdns_spi structure
+ *
+ * The depth of the TX FIFO is a synthesis configuration parameter of the SPI
+ * IP. The FIFO threshold register is sized so that its maximum value can be the
+ * FIFO size - 1. This is used to detect the size of the FIFO.
+ */
+static void cdns_spi_detect_fifo_depth(struct cdns_spi *xspi)
+{
+	/* The MSBs will get truncated giving us the size of the FIFO */
+	cdns_spi_write(xspi, CDNS_SPI_THLD, 0xffff);
+	xspi->tx_fifo_depth = cdns_spi_read(xspi, CDNS_SPI_THLD) + 1;
+
+	/* Reset to default */
+	cdns_spi_write(xspi, CDNS_SPI_THLD, 0x1);
+}
+
 /**
  * cdns_spi_probe - Probe method for the SPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -608,6 +625,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		xspi->is_decoded_cs = 0;
 
+	cdns_spi_detect_fifo_depth(xspi);
+
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
-- 
2.35.1

