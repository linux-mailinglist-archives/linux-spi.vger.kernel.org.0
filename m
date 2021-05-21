Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D938C3C2
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhEUJtb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 05:49:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47381 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234162AbhEUJtS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 May 2021 05:49:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UZbTwtj_1621590467;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZbTwtj_1621590467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 May 2021 17:47:53 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     daniel@zonque.org
Cc:     haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] spi: pxa2xx: Fix inconsistent indenting
Date:   Fri, 21 May 2021 17:47:45 +0800
Message-Id: <1621590465-73594-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Eliminate the follow smatch warning:

drivers/spi/spi-pxa2xx-pci.c:260 pxa2xx_spi_pci_probe() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 9c9992d..2e134eb 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -257,7 +257,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
 	ssp->clk = clk_register_fixed_rate(&dev->dev, buf, NULL, 0,
 					   c->max_clk_rate);
-	 if (IS_ERR(ssp->clk))
+	if (IS_ERR(ssp->clk))
 		return PTR_ERR(ssp->clk);
 
 	memset(&pi, 0, sizeof(pi));
-- 
1.8.3.1

