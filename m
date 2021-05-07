Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81837673D
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhEGOwc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 10:52:32 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33345 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234601AbhEGOwc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 10:52:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UY3o8Jd_1620399079;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UY3o8Jd_1620399079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 22:51:30 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] spi: set right CS polarity depend on gpiolib
Date:   Fri,  7 May 2021 22:51:17 +0800
Message-Id: <20210507145117.43221-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After a kernel upgrade from 4.19 to 5.10, we found that tpm flow control
always causes TIMEOUT which caused by wrong CS polarity setting depend
on gpiolib.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba425b9c7700..9ee2b92b4506 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -816,7 +816,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 		if (!(spi->mode & SPI_NO_CS)) {
 			if (spi->cs_gpiod)
 				/* polarity handled by gpiolib */
-				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
+				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
 			else
 				/*
 				 * invert the enable line, as active low is
-- 
2.19.1.6.gb485710b

