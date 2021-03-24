Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5935734717E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhCXGQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:16:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13675 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhCXGQY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4yby5DJKznVGC;
        Wed, 24 Mar 2021 14:13:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:14 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 03/11] spi: pxa2xx: Fix checkpatch spacing errors
Date:   Wed, 24 Mar 2021 14:16:34 +0800
Message-ID: <1616566602-13894-4-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix checkpatch errors:

  ERROR: space prohibited before that ',' (ctx:WxW)
  #255: FILE: spi-pxa2xx-pci.c:255:
  +	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
 	                                                  ^
  ERROR: "foo* bar" should be "foo *bar"
  #621: FILE: spi-pxa2xx.c:621:
  +static void int_error_stop(struct driver_data *drv_data, const char* msg)

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 2 +-
 drivers/spi/spi-pxa2xx.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 14fc41e..1833f58 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -252,7 +252,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp->irq = pci_irq_vector(dev, 0);
 
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
-	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
+	ssp->clk = clk_register_fixed_rate(&dev->dev, buf, NULL, 0,
 					   c->max_clk_rate);
 	 if (IS_ERR(ssp->clk))
 		return PTR_ERR(ssp->clk);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0cc7672..b83f325f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -618,7 +618,7 @@ static void reset_sccr1(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char* msg)
+static void int_error_stop(struct driver_data *drv_data, const char *msg)
 {
 	/* Stop and reset SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
-- 
2.7.4

