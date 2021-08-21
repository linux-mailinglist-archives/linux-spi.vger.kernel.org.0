Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D183F3AB2
	for <lists+linux-spi@lfdr.de>; Sat, 21 Aug 2021 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhHUMu1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 21 Aug 2021 08:50:27 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:34844 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHUMu1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 21 Aug 2021 08:50:27 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C3B4BD772A;
        Sat, 21 Aug 2021 20:49:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P704T139881080669952S1629550173496538_;
        Sat, 21 Aug 2021 20:49:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c71ec8a5484971490f56a865178e1d83>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Jon Lin <jon.lin@rock-chips.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: rockchip-sfc: Remove redundant IO operations
Date:   Sat, 21 Aug 2021 20:49:25 +0800
Message-Id: <20210821124925.6066-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Coherent dma buffer is uncached and memcpy is enough.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 7c4d47fe80c2..81154a8836fc 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -453,7 +453,7 @@ static int rockchip_sfc_xfer_data_dma(struct rockchip_sfc *sfc,
 	dev_dbg(sfc->dev, "sfc xfer_dma len=%x\n", len);
 
 	if (op->data.dir == SPI_MEM_DATA_OUT)
-		memcpy_toio(sfc->buffer, op->data.buf.out, len);
+		memcpy(sfc->buffer, op->data.buf.out, len);
 
 	ret = rockchip_sfc_fifo_transfer_dma(sfc, sfc->dma_buffer, len);
 	if (!wait_for_completion_timeout(&sfc->cp, msecs_to_jiffies(2000))) {
@@ -462,7 +462,7 @@ static int rockchip_sfc_xfer_data_dma(struct rockchip_sfc *sfc,
 	}
 	rockchip_sfc_irq_mask(sfc, SFC_IMR_DMA);
 	if (op->data.dir == SPI_MEM_DATA_IN)
-		memcpy_fromio(op->data.buf.in, sfc->buffer, len);
+		memcpy(op->data.buf.in, sfc->buffer, len);
 
 	return ret;
 }
-- 
2.17.1



