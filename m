Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BE2A3DEB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKCHnv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 02:43:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7448 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgKCHns (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 02:43:48 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQMGn33GyzhfTt;
        Tue,  3 Nov 2020 15:43:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:43:36 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] spi: mt7621: fix missing clk_disable_unprepare() on error in mt7621_spi_probe
Date:   Tue, 3 Nov 2020 15:49:12 +0800
Message-ID: <20201103074912.195576-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from mt7621_spi_probe in the error handling case.

Fixes: cbd66c626e16 ("spi: mt7621: Move SPI driver out of staging")
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/spi/spi-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 2c3b7a2a1..2cdae7994 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -353,6 +353,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
 	if (!master) {
 		dev_info(&pdev->dev, "master allocation failed\n");
+		clk_disable_unprepare(clk);
 		return -ENOMEM;
 	}
 
@@ -377,6 +378,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	ret = device_reset(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "SPI reset failed!\n");
+		clk_disable_unprepare(clk);
 		return ret;
 	}
 
-- 
2.23.0

