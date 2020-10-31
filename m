Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F82A1359
	for <lists+linux-spi@lfdr.de>; Sat, 31 Oct 2020 04:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJaDbQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 23:31:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6999 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgJaDbP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 23:31:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CNPpn3SjWzhd7P;
        Sat, 31 Oct 2020 11:31:13 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 11:31:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <frieder.schrempf@exceet.de>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
Date:   Sat, 31 Oct 2020 11:30:42 +0800
Message-ID: <20201031033042.42892-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix smatch warning:

drivers/spi/spi-mem.c:746 spi_mem_probe() warn: passing zero to 'PTR_ERR'

Fixes: 5d27a9c8ea9e ("spi: spi-mem: Extend the SPI mem interface to set a custom memory name")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ef53290b7d24..a1b4d085834a 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -743,7 +743,7 @@ static int spi_mem_probe(struct spi_device *spi)
 		mem->name = dev_name(&spi->dev);
 
 	if (IS_ERR_OR_NULL(mem->name))
-		return PTR_ERR(mem->name);
+		return PTR_ERR_OR_ZERO(mem->name);
 
 	spi_set_drvdata(spi, mem);
 
-- 
2.17.1

