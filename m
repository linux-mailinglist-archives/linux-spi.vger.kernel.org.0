Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D52E6E50
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 06:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL2FdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 00:33:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:18331 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgL2FdP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 00:33:15 -0500
IronPort-SDR: N/YoS4JcLs7Jkjkg0bF+Nv8KSTZlyzUtffqt0mwYjM4r0EWOxPm85SQGibAHYhRaoc5sUyUCrL
 FZU1hmwmC0vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="164170715"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="164170715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:32:22 -0800
IronPort-SDR: wYUKWdjiIGe7lfoob99IpQgmWqox1+/F5B5dBO+wlfSk9+Dh1F4C3/DyDGGn+DCF5qmMB35JqO
 936D53M2RgVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="395307700"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2020 21:32:20 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: altera: fix return value for altera_spi_txrx()
Date:   Tue, 29 Dec 2020 13:27:41 +0800
Message-Id: <1609219662-27057-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes the return value for altera_spi_txrx. It should return
1 for interrupt transfer mode, and return 0 for polling transfer mode.

The altera_spi_txrx() implements the spi_controller.transfer_one
callback. According to the spi-summary.rst, the transfer_one should
return 0 when transfer is finished, return 1 when transfer is still in
progress.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/spi/spi-altera.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 809bfff..cbc4c28 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -189,24 +189,26 @@ static int altera_spi_txrx(struct spi_master *master,
 
 		/* send the first byte */
 		altera_spi_tx_word(hw);
-	} else {
-		while (hw->count < hw->len) {
-			altera_spi_tx_word(hw);
 
-			for (;;) {
-				altr_spi_readl(hw, ALTERA_SPI_STATUS, &val);
-				if (val & ALTERA_SPI_STATUS_RRDY_MSK)
-					break;
+		return 1;
+	}
+
+	while (hw->count < hw->len) {
+		altera_spi_tx_word(hw);
 
-				cpu_relax();
-			}
+		for (;;) {
+			altr_spi_readl(hw, ALTERA_SPI_STATUS, &val);
+			if (val & ALTERA_SPI_STATUS_RRDY_MSK)
+				break;
 
-			altera_spi_rx_word(hw);
+			cpu_relax();
 		}
-		spi_finalize_current_transfer(master);
+
+		altera_spi_rx_word(hw);
 	}
+	spi_finalize_current_transfer(master);
 
-	return t->len;
+	return 0;
 }
 
 static irqreturn_t altera_spi_irq(int irq, void *dev)
-- 
2.7.4

