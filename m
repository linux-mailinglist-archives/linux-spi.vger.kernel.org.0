Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9C22A3CC
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jul 2020 02:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgGWAoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 20:44:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:58982 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733150AbgGWAoI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 20:44:08 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 43ADDC571D;
        Thu, 23 Jul 2020 08:44:02 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17009T140099499042560S1595465038112439_;
        Thu, 23 Jul 2020 08:44:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f73ad779b029db30ddd48caac0ab4cfc>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v3 2/3] spi: rockchip: Support 64-location deep FIFOs
Date:   Thu, 23 Jul 2020 08:43:55 +0800
Message-Id: <20200723004356.6390-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723004356.6390-1-jon.lin@rock-chips.com>
References: <20200723004356.6390-1-jon.lin@rock-chips.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The FIFO depth of SPI V2 is 64 instead of 32, add support for it.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 63593a5b87fa..a451dacab5cf 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -39,8 +39,9 @@
 #define ROCKCHIP_SPI_RISR			0x0034
 #define ROCKCHIP_SPI_ICR			0x0038
 #define ROCKCHIP_SPI_DMACR			0x003c
-#define ROCKCHIP_SPI_DMATDLR		0x0040
-#define ROCKCHIP_SPI_DMARDLR		0x0044
+#define ROCKCHIP_SPI_DMATDLR			0x0040
+#define ROCKCHIP_SPI_DMARDLR			0x0044
+#define ROCKCHIP_SPI_VERSION			0x0048
 #define ROCKCHIP_SPI_TXDR			0x0400
 #define ROCKCHIP_SPI_RXDR			0x0800
 
@@ -156,6 +157,8 @@
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
+#define ROCKCHIP_SPI_VER2_TYPE1			0x05EC0002
+#define ROCKCHIP_SPI_VER2_TYPE2			0x00110002
 
 struct rockchip_spi {
 	struct device *dev;
@@ -206,17 +209,17 @@ static inline void wait_for_idle(struct rockchip_spi *rs)
 
 static u32 get_fifo_len(struct rockchip_spi *rs)
 {
-	u32 fifo;
+	u32 ver;
 
-	for (fifo = 2; fifo < 32; fifo++) {
-		writel_relaxed(fifo, rs->regs + ROCKCHIP_SPI_TXFTLR);
-		if (fifo != readl_relaxed(rs->regs + ROCKCHIP_SPI_TXFTLR))
-			break;
-	}
-
-	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_TXFTLR);
+	ver = readl_relaxed(rs->regs + ROCKCHIP_SPI_VERSION);
 
-	return (fifo == 31) ? 0 : fifo;
+	switch (ver) {
+	case ROCKCHIP_SPI_VER2_TYPE1:
+	case ROCKCHIP_SPI_VER2_TYPE2:
+		return 64;
+	default:
+		return 32;
+	}
 }
 
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
-- 
2.17.1



