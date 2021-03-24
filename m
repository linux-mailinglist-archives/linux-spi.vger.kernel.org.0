Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2134717C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhCXGQa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:16:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14442 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhCXGQX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd03hzbzkf6V;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:14 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 04/11] spi: omap-100k: Fix checkpatch spacing errors
Date:   Wed, 24 Mar 2021 14:16:35 +0800
Message-ID: <1616566602-13894-5-git-send-email-f.fangjian@huawei.com>
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
  #113: FILE: spi-omap-100k.c:113:
  +	writew(data , spi100k->base + SPI_TX_MSB);
 	            ^
  ERROR: space prohibited before that ',' (ctx:WxW)
  #249: FILE: spi-omap-100k.c:249:
  +	writew(0x3e , spi100k->base + SPI_SETUP1);
 	            ^
  ERROR: space prohibited before that ',' (ctx:WxW)
  #250: FILE: spi-omap-100k.c:250:
  +	writew(0x00 , spi100k->base + SPI_STATUS);
 	            ^
  ERROR: space prohibited before that ',' (ctx:WxW)
  #251: FILE: spi-omap-100k.c:251:
  +	writew(0x3e , spi100k->base + SPI_CTRL);
 	            ^

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-omap-100k.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 36a4922..189fd2d 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -110,7 +110,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 	}
 
 	spi100k_enable_clock(master);
-	writew(data , spi100k->base + SPI_TX_MSB);
+	writew(data, spi100k->base + SPI_TX_MSB);
 
 	writew(SPI_CTRL_SEN(0) |
 	       SPI_CTRL_WORD_SIZE(len) |
@@ -246,9 +246,9 @@ static int omap1_spi100k_setup_transfer(struct spi_device *spi,
 	cs->word_len = word_len;
 
 	/* SPI init before transfer */
-	writew(0x3e , spi100k->base + SPI_SETUP1);
-	writew(0x00 , spi100k->base + SPI_STATUS);
-	writew(0x3e , spi100k->base + SPI_CTRL);
+	writew(0x3e, spi100k->base + SPI_SETUP1);
+	writew(0x00, spi100k->base + SPI_STATUS);
+	writew(0x3e, spi100k->base + SPI_CTRL);
 
 	return 0;
 }
-- 
2.7.4

