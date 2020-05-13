Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2104B1D16C2
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgEMOAv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:51 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48473 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbgEMOAt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378449; x=1620914449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vowUNbP3S5lXJc8g2i7fvP/xMewlWoQteI1QXHomxRg=;
  b=Dkxxsx7ys9jt8N2poRllmk0CF+Rao+H/M16WPyqXeXfxow7qV0WhR9GF
   QD/+xdK9z8AcRJpV/6hN8/NhyrWvPsvVUoDsL+aPKJXF9zvGzjx99Y65b
   LFHm9FKEeg5ZPwezdjl2j6CDyvoJfvPEeWbor4/p/7q/aJRpqzjIU9iqm
   bkI3oS52dgPnEg3YkS+Qt+B0CCT1DFEa5dwDEn/CR75FWdw7XNR5LL9c0
   zIJZ1wsij6s07CMEkPuT9UwikP40WYqldPFV6JMlw7A2OLFNR9UlHJOmS
   CQQMwPYtpPbJyv47wb8gCvM18j9+pYq6rqdmOX9nLyqQGRLO2X1//w0Q3
   g==;
IronPort-SDR: 4D+Er6POtXMlAwo49Pt9+FrHQxpT0FtL6XCAFrdjh8D85kr8b+ihfNzJkVyJV57ueigB/6nmES
 HZkzzmLvPZFbhOnNn5afasAvzj7rCLYCOzzftWzS3RXF1BTi5Ilg0QwQSm8tPZ2BZQEragPEjs
 lNomrfglmmjicbZ0fKgO8e8NiYrWAn2EHZw00uB81vfMrsGlogID8sGmmvO3oqyQK5nAQYNRcv
 6JnDeHwLAJduSg9hyvpSL+NntsrEMOarv8k6x0mbAfZBjtBve0O4aPFcINEIQptD03XfwmVBvC
 9T4=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="79447467"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:50 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:46 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 03/10] spi: dw: Add support for client driver memory operations
Date:   Wed, 13 May 2020 16:00:24 +0200
Message-ID: <20200513140031.25633-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This minor change allow dw-spi drivers to register
spi_controller_mem_ops memory operations if the platform supports it.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 32997f28fa5bb..d0c611c42421e 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -527,6 +527,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	/* Basic HW init */
 	spi_hw_init(dev, dws);

+	/* Memory ops? */
+	master->mem_ops = dws->mem_ops;
+
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
 		ret = dws->dma_ops->dma_init(dws);
 		if (ret) {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index ed6e47b3f50da..8ecccbde10a20 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -3,6 +3,7 @@
 #define DW_SPI_HEADER_H

 #include <linux/io.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/scatterlist.h>

 /* Register offsets */
@@ -116,6 +117,7 @@ struct dw_spi {
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
+	const struct spi_controller_mem_ops *mem_ops;

 	/* Current message transfer state info */
 	size_t			len;
--
2.26.2
