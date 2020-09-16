Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA4026C1B0
	for <lists+linux-spi@lfdr.de>; Wed, 16 Sep 2020 12:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIPKcf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbgIPKae (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3966698C6E92998A58D5;
        Wed, 16 Sep 2020 18:13:54 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.232) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 18:13:43 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] spi: lantiq: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 16 Sep 2020 22:10:42 +1200
Message-ID: <20200916101042.21860-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.232]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Running in hardIRQ, disabling irq is redundant.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/spi/spi-lantiq-ssc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 3cbecb2d8fc0..bcb52601804a 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -625,9 +625,8 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 	struct lantiq_ssc_spi *spi = data;
 	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 val = lantiq_ssc_readl(spi, hwcfg->irncr);
-	unsigned long flags;
 
-	spin_lock_irqsave(&spi->lock, flags);
+	spin_lock(&spi->lock);
 	if (hwcfg->irq_ack)
 		lantiq_ssc_writel(spi, val, hwcfg->irncr);
 
@@ -652,12 +651,12 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 		}
 	}
 
-	spin_unlock_irqrestore(&spi->lock, flags);
+	spin_unlock(&spi->lock);
 	return IRQ_HANDLED;
 
 completed:
 	queue_work(spi->wq, &spi->work);
-	spin_unlock_irqrestore(&spi->lock, flags);
+	spin_unlock(&spi->lock);
 
 	return IRQ_HANDLED;
 }
@@ -668,12 +667,11 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
 	u32 val = lantiq_ssc_readl(spi, hwcfg->irncr);
-	unsigned long flags;
 
 	if (!(stat & LTQ_SPI_STAT_ERRORS))
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&spi->lock, flags);
+	spin_lock(&spi->lock);
 	if (hwcfg->irq_ack)
 		lantiq_ssc_writel(spi, val, hwcfg->irncr);
 
@@ -697,7 +695,7 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	if (spi->master->cur_msg)
 		spi->master->cur_msg->status = -EIO;
 	queue_work(spi->wq, &spi->work);
-	spin_unlock_irqrestore(&spi->lock, flags);
+	spin_unlock(&spi->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1


