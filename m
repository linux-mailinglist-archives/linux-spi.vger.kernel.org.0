Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBD39C71C
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFEJta (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Jun 2021 05:49:30 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:54628 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFEJt2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Jun 2021 05:49:28 -0400
Received: from localhost (unknown [192.168.167.105])
        by lucky1.263xmail.com (Postfix) with ESMTP id 701A4BA2D6;
        Sat,  5 Jun 2021 17:47:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26721T140686913419008S1622886424373318_;
        Sat, 05 Jun 2021 17:47:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <adbfd022b643fee383bbe3358d3d3bdb>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v3 2/8] spi: rockchip: Wait for STB status in slave mode tx_xfer
Date:   Sat,  5 Jun 2021 17:46:53 +0800
Message-Id: <20210605094659.13507-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210605094659.13507-1-jon.lin@rock-chips.com>
References: <20210605094659.13507-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After ROCKCHIP_SPI_VER2_TYPE2, SR->STB is a more accurate judgment
bit for spi slave transmition.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 406ea3c6abd9..73b89a7ae69f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -116,13 +116,14 @@
 #define BAUDR_SCKDV_MIN				2
 #define BAUDR_SCKDV_MAX				65534
 
-/* Bit fields in SR, 5bit */
-#define SR_MASK						0x1f
+/* Bit fields in SR, 6bit */
+#define SR_MASK						0x3f
 #define SR_BUSY						(1 << 0)
 #define SR_TF_FULL					(1 << 1)
 #define SR_TF_EMPTY					(1 << 2)
 #define SR_RF_EMPTY					(1 << 3)
 #define SR_RF_FULL					(1 << 4)
+#define SR_SLAVE_TX_BUSY				(1 << 5)
 
 /* Bit fields in ISR, IMR, ISR, RISR, 5bit */
 #define INT_MASK					0x1f
@@ -197,13 +198,19 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
-static inline void wait_for_idle(struct rockchip_spi *rs)
+static inline void wait_for_tx_idle(struct rockchip_spi *rs, bool slave_mode)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
 
 	do {
-		if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
-			return;
+		if (slave_mode) {
+			if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_SLAVE_TX_BUSY) &&
+			    !((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY)))
+				return;
+		} else {
+			if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
+				return;
+		}
 	} while (!time_after(jiffies, timeout));
 
 	dev_warn(rs->dev, "spi controller is in busy state!\n");
@@ -383,7 +390,7 @@ static void rockchip_spi_dma_txcb(void *data)
 		return;
 
 	/* Wait until the FIFO data completely. */
-	wait_for_idle(rs);
+	wait_for_tx_idle(rs, ctlr->slave);
 
 	spi_enable_chip(rs, false);
 	spi_finalize_current_transfer(ctlr);
@@ -545,7 +552,7 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(rs->fifo_len / 2, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(rockchip_spi_calc_burst_size(xfer->len / rs->n_bytes) - 1,
 		       rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
-- 
2.17.1



