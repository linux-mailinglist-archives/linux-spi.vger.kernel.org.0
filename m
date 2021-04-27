Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65736C037
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhD0Hi2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 03:38:28 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:49828 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhD0Hi1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 03:38:27 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id C2753F39DC;
        Tue, 27 Apr 2021 15:37:36 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2750T140648996910848S1619509055243892_;
        Tue, 27 Apr 2021 15:37:36 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f0a9583a3d3d3cde6d2d70a5018492a6>
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
Subject: [PATCH v2 1/8] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
Date:   Tue, 27 Apr 2021 15:37:26 +0800
Message-Id: <20210427073733.31419-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The error here is to calculate the width as 8 bits. In fact, 16 bits
should be considered.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 52d6259d96ed..406ea3c6abd9 100644
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



