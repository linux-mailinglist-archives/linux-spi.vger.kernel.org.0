Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579D74F6BC
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jul 2023 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGKRSM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjGKRSH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 13:18:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFB1BB;
        Tue, 11 Jul 2023 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689095886; x=1720631886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rM83K+8cJkJE4xGj15BlfW6NeYwJQps/lMnHrXNpxyE=;
  b=OPvLu4hQ37rJm1W7IhBY0c6FKbYQfOUmJNidnwwLOHrVaY2byqQceNAS
   PJNMPQGYMocMU+OOG5AJddyYFd39dUAmkkEzX+2jqtUg7/83z3ORH35Zy
   MeWPyJVCE1Ba/AQJzDn9liwFrZPdjnnF8HVwT4GZ9HV69A6EUt3J2FmnH
   PqkIBlsKWbKXQYpZYVbZuwCV6r4OMC1honQ+QH/hs1LgRLdlKMxNju2Fu
   jLvpO27TrHrq/zNbJiwoHVzc2DEP1tiPxM7J4a8fBRgvQU7TY+cNqIlR3
   1aPaDnyPzxRiVtIw6rDWautTWt7Zodcmsy1988etn34GLWM867Y0XsgJ9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451045013"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="451045013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698501378"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="698501378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2023 10:18:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE50B718; Tue, 11 Jul 2023 20:17:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 10/14] spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
Date:   Tue, 11 Jul 2023 20:17:52 +0300
Message-Id: <20230711171756.86736-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
References: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the users from SPI_MASTER_NO_TX and/or SPI_MASTER_NO_RX
to SPI_CONTROLLER_NO_TX and/or SPI_CONTROLLER_NO_RX respectively
and kill the not used anymore definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-bitbang-txrx.h  | 16 ++++++++--------
 drivers/spi/spi-bitbang.c       |  2 +-
 drivers/spi/spi-gpio.c          |  8 ++++----
 drivers/spi/spi-lp8841-rtc.c    |  8 ++++----
 drivers/spi/spi-xtensa-xtfpga.c |  2 +-
 include/linux/spi/spi.h         |  2 --
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 2dcbe166df63..0cab48b7875b 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -57,7 +57,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & (1 << 31)) != oldbit) {
 				setmosi(spi, word & (1 << 31));
 				oldbit = word & (1 << 31);
@@ -70,7 +70,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 
 		/* sample MSB (from slave) on leading edge */
 		word <<= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi);
 		setsck(spi, cpol);
 	}
@@ -90,7 +90,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & (1 << 31)) != oldbit) {
 				setmosi(spi, word & (1 << 31));
 				oldbit = word & (1 << 31);
@@ -103,7 +103,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* sample MSB (from slave) on trailing edge */
 		word <<= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi);
 	}
 	return word;
@@ -122,7 +122,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 	for (; likely(bits); bits--) {
 
 		/* setup LSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & 1) != oldbit) {
 				setmosi(spi, word & 1);
 				oldbit = word & 1;
@@ -135,7 +135,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 
 		/* sample LSB (from slave) on leading edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi) << rxbit;
 		setsck(spi, cpol);
 	}
@@ -156,7 +156,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 
 		/* setup LSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & 1) != oldbit) {
 				setmosi(spi, word & 1);
 				oldbit = word & 1;
@@ -169,7 +169,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 
 		/* sample LSB (from slave) on trailing edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi) << rxbit;
 	}
 	return word;
diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 27d0087f8688..862f209cada1 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -248,7 +248,7 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spi->mode & SPI_3WIRE) {
 		unsigned flags;
 
-		flags = t->tx_buf ? SPI_MASTER_NO_RX : SPI_MASTER_NO_TX;
+		flags = t->tx_buf ? SPI_CONTROLLER_NO_RX : SPI_CONTROLLER_NO_TX;
 		return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t, flags);
 	}
 	return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t, 0);
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 092afc7679d4..85e149ec2910 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -170,7 +170,7 @@ static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 
 /*
  * These functions do not call setmosi or getmiso if respective flag
- * (SPI_MASTER_NO_RX or SPI_MASTER_NO_TX) is set, so they are safe to
+ * (SPI_CONTROLLER_NO_RX or SPI_CONTROLLER_NO_TX) is set, so they are safe to
  * call when such pin is not present or defined in the controller.
  * A separate set of callbacks is defined to get highest possible
  * speed in the generic case (when both MISO and MOSI lines are
@@ -416,11 +416,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
 		 *
-		 * No setting SPI_MASTER_NO_RX here - if there is only
+		 * No setting SPI_CONTROLLER_NO_RX here - if there is only
 		 * a MOSI pin connected the host can still do RX by
 		 * changing the direction of the line.
 		 */
-		master->flags = SPI_MASTER_NO_TX;
+		master->flags = SPI_CONTROLLER_NO_TX;
 	}
 
 	master->bus_num = pdev->id;
@@ -438,7 +438,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master->flags & SPI_MASTER_NO_TX) {
+	if (master->flags & SPI_CONTROLLER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 2d436541d6c2..ccaa7a946359 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -75,14 +75,14 @@ bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
 	for (; likely(bits); bits--) {
 
 		/* setup LSB (to slave) on leading edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0)
 			setmosi(data, (word & 1));
 
 		usleep_range(usecs, usecs + 1);	/* T(setup) */
 
 		/* sample LSB (from slave) on trailing edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= (getmiso(data) << 31);
 
 		setsck(data, !cpol);
@@ -113,7 +113,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 		while (likely(count > 0)) {
 			word = *tx++;
 			bitbang_txrx_be_cpha0_lsb(data, 1, 0,
-					SPI_MASTER_NO_RX, word, 8);
+					SPI_CONTROLLER_NO_RX, word, 8);
 			count--;
 		}
 	} else if (rx) {
@@ -121,7 +121,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 		writeb(data->state, data->iomem);
 		while (likely(count > 0)) {
 			word = bitbang_txrx_be_cpha0_lsb(data, 1, 0,
-					SPI_MASTER_NO_TX, word, 8);
+					SPI_CONTROLLER_NO_TX, word, 8);
 			*rx++ = word;
 			count--;
 		}
diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 24dc845b940e..dbd85d7a1526 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -87,7 +87,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->flags = SPI_MASTER_NO_RX;
+	master->flags = SPI_CONTROLLER_NO_RX;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	master->bus_num = pdev->dev.id;
 	master->dev.of_node = pdev->dev.of_node;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 35fd61070d9b..39e6271b5003 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1626,8 +1626,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 #define spi_master			spi_controller
 
 #define SPI_MASTER_HALF_DUPLEX		SPI_CONTROLLER_HALF_DUPLEX
-#define SPI_MASTER_NO_RX		SPI_CONTROLLER_NO_RX
-#define SPI_MASTER_NO_TX		SPI_CONTROLLER_NO_TX
 #define SPI_MASTER_MUST_RX		SPI_CONTROLLER_MUST_RX
 #define SPI_MASTER_MUST_TX		SPI_CONTROLLER_MUST_TX
 
-- 
2.40.0.1.gaa8946217a0b

