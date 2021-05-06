Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C1375334
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEFLua (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 07:50:30 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60258 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhEFLua (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 07:50:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UXz.63r_1620301769;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UXz.63r_1620301769)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 19:49:30 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     thesven73@gmail.com, linus.walleij@linaro.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v1] spi: fix client driver can't register success when use GPIO as CS
Date:   Thu,  6 May 2021 19:49:28 +0800
Message-Id: <424d37007b7e298cf9bca5ac38d45a723e0976ee.1620301297.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When i was testing the TPM2 device, I found that the driver
always failed to register which used SPI bus and GPIO as CS
signal, i found that the reason for the error was that CS could
not be set correctly, so there fixed it.

Fixes: 766c6b63aa044e ("spi: fix client driver breakages when using
GPIO descriptors")
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..d4342909c1c8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -826,7 +826,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 			if (spi->cs_gpiod)
 				/* polarity handled by gpiolib */
 				gpiod_set_value_cansleep(spi->cs_gpiod,
-							 enable1);
+							 !enable);
 			else
 				/*
 				 * invert the enable line, as active low is
-- 
2.31.0

