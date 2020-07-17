Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65162223482
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQGaa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:10212 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQGaa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:30 -0400
IronPort-SDR: Cfx5WmuYM9d2CALIgsoPKeGdVAifmtHr4orAdr/19dKEZWDkAlDida8DQKwWMaHyh6CyenHfLa
 69yWP5H7coKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137006242"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="137006242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:29 -0700
IronPort-SDR: UstrEUAEOS5WbWF6+q1Dv4sbthHyr85FF7NRBvh50qLVkVm2uqWqeqVXa6CqDcG0sPfguSkryb
 zufQbxwUEmqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="269458022"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2020 23:30:26 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 1/8] spi: lantiq: fix: Rx overflow error in full duplex mode
Date:   Fri, 17 Jul 2020 14:27:50 +0800
Message-Id: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In full duplex mode, rx overflow error is observed. To overcome the error,
wait until the complete data got received and proceed further.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 1fd7ee53d4510..44600fb71c484 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -184,6 +184,7 @@ struct lantiq_ssc_spi {
 	unsigned int			tx_fifo_size;
 	unsigned int			rx_fifo_size;
 	unsigned int			base_cs;
+	unsigned int			fdx_tx_level;
 };
 
 static u32 lantiq_ssc_readl(const struct lantiq_ssc_spi *spi, u32 reg)
@@ -481,6 +482,7 @@ static void tx_fifo_write(struct lantiq_ssc_spi *spi)
 	u32 data;
 	unsigned int tx_free = tx_fifo_free(spi);
 
+	spi->fdx_tx_level = 0;
 	while (spi->tx_todo && tx_free) {
 		switch (spi->bits_per_word) {
 		case 2 ... 8:
@@ -509,6 +511,7 @@ static void tx_fifo_write(struct lantiq_ssc_spi *spi)
 
 		lantiq_ssc_writel(spi, data, LTQ_SPI_TB);
 		tx_free--;
+		spi->fdx_tx_level++;
 	}
 }
 
@@ -520,6 +523,13 @@ static void rx_fifo_read_full_duplex(struct lantiq_ssc_spi *spi)
 	u32 data;
 	unsigned int rx_fill = rx_fifo_level(spi);
 
+	/*
+	 * Wait until all expected data to be shifted in.
+	 * Otherwise, rx overrun may occur.
+	 */
+	while (rx_fill != spi->fdx_tx_level)
+		rx_fill = rx_fifo_level(spi);
+
 	while (rx_fill) {
 		data = lantiq_ssc_readl(spi, LTQ_SPI_RB);
 
-- 
2.11.0

