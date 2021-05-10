Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93B378F09
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhEJNdE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:5890 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348523AbhEJMpx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:45:53 -0400
IronPort-SDR: LueaWjjqrskdZcHPwWkPWoYptpZW0C1yToo7HwoKe0QXdngmHzFymiPH7gmv/xUww+ST3oTpMv
 wEJenbIeYTAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="178772966"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="178772966"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:41:23 -0700
IronPort-SDR: fdqTii3nqf+1fQSYq4A30waKxFXx5bjHjOcm3TefMmsehQPVNpOqQVkVgGrZMBginsfE0Jm1xM
 HAEM1zzhGUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="621241356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 May 2021 05:41:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5184796; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
Date:   Mon, 10 May 2021 15:41:32 +0300
Message-Id: <20210510124134.24638-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are few places that repeat the logic of "read some bits from SSSR".
Extract read_SSSR_bits() helper to deduplicate that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c |  9 +++------
 drivers/spi/spi-pxa2xx.c     | 26 +++++++++++---------------
 drivers/spi/spi-pxa2xx.h     |  7 ++++++-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index e581027e99f9..f022d82dcb1b 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -34,11 +34,8 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 		 * might not know about the error yet. So we re-check the
 		 * ROR bit here before we clear the status register.
 		 */
-		if (!error) {
-			u32 status = pxa2xx_spi_read(drv_data, SSSR)
-				     & drv_data->mask_sr;
-			error = status & SSSR_ROR;
-		}
+		if (!error)
+			error = read_SSSR_bits(drv_data, drv_data->mask_sr) & SSSR_ROR;
 
 		/* Clear status & disable interrupts */
 		clear_SSCR1_bits(drv_data, drv_data->dma_cr1);
@@ -119,7 +116,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 {
 	u32 status;
 
-	status = pxa2xx_spi_read(drv_data, SSSR) & drv_data->mask_sr;
+	status = read_SSSR_bits(drv_data, drv_data->mask_sr);
 	if (status & SSSR_ROR) {
 		dev_err(drv_data->ssp->dev, "FIFO overrun\n");
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3a4ad16614f7..af3f01de8f5b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -247,7 +247,7 @@ static bool pxa2xx_spi_txfifo_full(const struct driver_data *drv_data)
 		break;
 	}
 
-	return (pxa2xx_spi_read(drv_data, SSSR) & mask) == mask;
+	return read_SSSR_bits(drv_data, mask) == mask;
 }
 
 static void pxa2xx_spi_clear_rx_thre(const struct driver_data *drv_data,
@@ -488,7 +488,7 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 	unsigned long limit = loops_per_jiffy << 1;
 
 	do {
-		while (pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+		while (read_SSSR_bits(drv_data, SSSR_RNE))
 			pxa2xx_spi_read(drv_data, SSDR);
 	} while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY) && --limit);
 	write_SSSR_CS(drv_data, SSSR_ROR);
@@ -523,8 +523,7 @@ static int null_reader(struct driver_data *drv_data)
 {
 	u8 n_bytes = drv_data->n_bytes;
 
-	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
-	       && (drv_data->rx < drv_data->rx_end)) {
+	while (read_SSSR_bits(drv_data, SSSR_RNE) && drv_data->rx < drv_data->rx_end) {
 		pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += n_bytes;
 	}
@@ -546,8 +545,7 @@ static int u8_writer(struct driver_data *drv_data)
 
 static int u8_reader(struct driver_data *drv_data)
 {
-	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
-	       && (drv_data->rx < drv_data->rx_end)) {
+	while (read_SSSR_bits(drv_data, SSSR_RNE) && drv_data->rx < drv_data->rx_end) {
 		*(u8 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		++drv_data->rx;
 	}
@@ -569,8 +567,7 @@ static int u16_writer(struct driver_data *drv_data)
 
 static int u16_reader(struct driver_data *drv_data)
 {
-	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
-	       && (drv_data->rx < drv_data->rx_end)) {
+	while (read_SSSR_bits(drv_data, SSSR_RNE) && drv_data->rx < drv_data->rx_end) {
 		*(u16 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += 2;
 	}
@@ -592,8 +589,7 @@ static int u32_writer(struct driver_data *drv_data)
 
 static int u32_reader(struct driver_data *drv_data)
 {
-	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
-	       && (drv_data->rx < drv_data->rx_end)) {
+	while (read_SSSR_bits(drv_data, SSSR_RNE) && drv_data->rx < drv_data->rx_end) {
 		*(u32 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += 4;
 	}
@@ -655,10 +651,11 @@ static void int_transfer_complete(struct driver_data *drv_data)
 
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 {
-	u32 irq_mask = (pxa2xx_spi_read(drv_data, SSCR1) & SSCR1_TIE) ?
-		       drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
+	u32 irq_status;
 
-	u32 irq_status = pxa2xx_spi_read(drv_data, SSSR) & irq_mask;
+	irq_status = read_SSSR_bits(drv_data, drv_data->mask_sr);
+	if (!(pxa2xx_spi_read(drv_data, SSCR1) & SSCR1_TIE))
+		irq_status &= ~SSSR_TFS;
 
 	if (irq_status & SSSR_ROR) {
 		int_error_stop(drv_data, "interrupt_transfer: fifo overrun", -EIO);
@@ -1110,8 +1107,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	pxa_ssp_enable(drv_data->ssp);
 
 	if (is_mmp2_ssp(drv_data)) {
-		u8 tx_level = (pxa2xx_spi_read(drv_data, SSSR)
-					& SSSR_TFL_MASK) >> 8;
+		u8 tx_level = read_SSSR_bits(drv_data, SSSR_TFL_MASK) >> 8;
 
 		if (tx_level) {
 			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index ed63f7165cd8..d2cb40f97c4b 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -110,11 +110,16 @@ static inline void clear_SSCR1_bits(const struct driver_data *drv_data, u32 bits
 	pxa2xx_spi_write(drv_data, SSCR1, pxa2xx_spi_read(drv_data, SSCR1) & ~bits);
 }
 
+static inline u32 read_SSSR_bits(const struct driver_data *drv_data, u32 bits)
+{
+	return pxa2xx_spi_read(drv_data, SSSR) & bits;
+}
+
 static inline void write_SSSR_CS(struct driver_data *drv_data, u32 val)
 {
 	if (drv_data->ssp_type == CE4100_SSP ||
 	    drv_data->ssp_type == QUARK_X1000_SSP)
-		val |= pxa2xx_spi_read(drv_data, SSSR) & SSSR_ALT_FRM_MASK;
+		val |= read_SSSR_bits(drv_data, SSSR_ALT_FRM_MASK);
 
 	pxa2xx_spi_write(drv_data, SSSR, val);
 }
-- 
2.30.2

