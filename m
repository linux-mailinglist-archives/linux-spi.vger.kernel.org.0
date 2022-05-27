Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF1535D75
	for <lists+linux-spi@lfdr.de>; Fri, 27 May 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbiE0JdR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 May 2022 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349617AbiE0JdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 May 2022 05:33:15 -0400
X-Greylist: delayed 1277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 02:33:14 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C293056F
        for <linux-spi@vger.kernel.org>; Fri, 27 May 2022 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2KENB/wyLji4a4mmkeA6tfkVslizT3V4TXr8Z6HlsW4=; b=Kp8uKmu0uyV3/rXRym37FuBFeR
        kWFgOHQX1Q7uboTZAFFJrueN+DHpQ8sihu/073FL/Mi/cWSdXnteQRkpw8oV9XUZpX5jAXQV70Pwd
        As/SMJ5mfzCyHtC+8N3AApSw+PgRet6klmT6MxWpwFS2LAS0FQE5YV+Dj46SJ1yKivsHWVjHMeWan
        TZhwfEI+tYUalSiHER59XvfwCByQXa5+hLoaR2iXRPcDVxFumB9AGqfPkWRN+WLwtCISKSHtfRjAX
        1vZrWSgLe+Q+OwHj4Bvx1B7f+Bs/27limZ0Yo8w98uNKrkj/0TZOOXQkswsLBQp9vHYokiol1KeoI
        BUrl6yWA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nuW0e-000Ejr-HW; Fri, 27 May 2022 11:11:52 +0200
Received: from [2001:a61:2ba3:7b01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nuW0e-000EbJ-Ah; Fri, 27 May 2022 11:11:52 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Janek Kotas <jank@cadence.com>, linux-spi@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] spi: cadence: Detect transmit FIFO depth
Date:   Fri, 27 May 2022 11:11:43 +0200
Message-Id: <20220527091143.3780378-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26554/Fri May 27 10:04:35 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
---
 drivers/spi/spi-cadence.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index a23d4f6329f5..2a70cdcc051e 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -92,9 +92,6 @@
 #define CDNS_SPI_ER_ENABLE	0x00000001 /* SPI Enable Bit Mask */
 #define CDNS_SPI_ER_DISABLE	0x0 /* SPI Disable Bit Mask */
 
-/* SPI FIFO depth in bytes */
-#define CDNS_SPI_FIFO_DEPTH	128
-
 /* Default number of chip select lines */
 #define CDNS_SPI_DEFAULT_NUM_CS		4
 
@@ -110,6 +107,7 @@
  * @rx_bytes:		Number of bytes requested
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
+ * @tx_fifo_depth:	Depth of the TX FIFO
  */
 struct cdns_spi {
 	void __iomem *regs;
@@ -123,6 +121,7 @@ struct cdns_spi {
 	int rx_bytes;
 	u8 dev_busy;
 	u32 is_decoded_cs;
+	unsigned int tx_fifo_depth;
 };
 
 /* Macros for the SPI controller read/write */
@@ -304,7 +303,7 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 {
 	unsigned long trans_cnt = 0;
 
-	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
+	while ((trans_cnt < xspi->tx_fifo_depth) &&
 	       (xspi->tx_bytes > 0)) {
 
 		/* When xspi in busy condition, bytes may send failed,
@@ -463,6 +462,24 @@ static int cdns_unprepare_transfer_hardware(struct spi_master *master)
 	return 0;
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
@@ -535,6 +552,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		xspi->is_decoded_cs = 0;
 
+	cdns_spi_detect_fifo_depth(xspi);
+
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
-- 
2.30.2

