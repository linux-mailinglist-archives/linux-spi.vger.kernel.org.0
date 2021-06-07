Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8439DAFC
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFGLUi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 07:20:38 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:50274 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhFGLUh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 07:20:37 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 96ADFC8187;
        Mon,  7 Jun 2021 19:18:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32529T140357062862592S1623064720154033_;
        Mon, 07 Jun 2021 19:18:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c1840adc70ee8f719f3e259865f74c97>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
Date:   Mon,  7 Jun 2021 19:18:34 +0800
Message-Id: <20210607111837.31074-4-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607111837.31074-1-jon.lin@rock-chips.com>
References: <20210607111837.31074-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The error here is to calculate the width as 8 bits. In fact, 16 bits
should be considered.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index bbeed3ae4ee1..0887b19ef3ad 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -540,8 +540,8 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	 * interrupt exactly when the fifo is full doesn't seem to work,
 	 * so we need the strict inequality here
 	 */
-	if (xfer->len < rs->fifo_len)
-		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
+	if ((xfer->len / rs->n_bytes) < rs->fifo_len)
+		writel_relaxed(xfer->len / rs->n_bytes - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 	else
 		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-- 
2.17.1



