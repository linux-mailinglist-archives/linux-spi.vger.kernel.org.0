Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED069223485
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGQGad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:36357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQGad (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:33 -0400
IronPort-SDR: eOAgvwNVPU2UIMNm0XUId69rJ032JntmN50i05ReQd4bO1+wxHTbw6AOHEtzdwoKYqrHwWy+R3
 Oy3Dpk/9o9kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234396381"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="234396381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:32 -0700
IronPort-SDR: Lj4qFW8tzWRNVv9EKIP7QNrp+S18tBsSR7F8uqXKPlwmlGFAQ/An+gHJhAmtvg8u8Q4cDxh/j7
 PmFu08l2J9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="325352362"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 23:30:29 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 2/8] spi: lantiq: Add SMP support
Date:   Fri, 17 Jul 2020 14:27:51 +0800
Message-Id: <d6663296b41f102c582fda08e71f62b72ca05d5d.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Existing driver supports only single core SoC. New multicore platforms uses
the same driver/IP so SMP support is required. This patch adds multicore
support in the driver.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 44600fb71c484..1073a70a4beba 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -623,7 +623,9 @@ static void rx_request(struct lantiq_ssc_spi *spi)
 static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 {
 	struct lantiq_ssc_spi *spi = data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&spi->lock, flags);
 	if (spi->tx) {
 		if (spi->rx && spi->rx_todo)
 			rx_fifo_read_full_duplex(spi);
@@ -645,10 +647,12 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 		}
 	}
 
+	spin_unlock_irqrestore(&spi->lock, flags);
 	return IRQ_HANDLED;
 
 completed:
 	queue_work(spi->wq, &spi->work);
+	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -657,10 +661,12 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 {
 	struct lantiq_ssc_spi *spi = data;
 	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
+	unsigned long flags;
 
 	if (!(stat & LTQ_SPI_STAT_ERRORS))
 		return IRQ_NONE;
 
+	spin_lock_irqsave(&spi->lock, flags);
 	if (stat & LTQ_SPI_STAT_RUE)
 		dev_err(spi->dev, "receive underflow error\n");
 	if (stat & LTQ_SPI_STAT_TUE)
@@ -681,6 +687,7 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	if (spi->master->cur_msg)
 		spi->master->cur_msg->status = -EIO;
 	queue_work(spi->wq, &spi->work);
+	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return IRQ_HANDLED;
 }
-- 
2.11.0

