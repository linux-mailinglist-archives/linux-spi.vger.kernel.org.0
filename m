Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC62A4736
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgKCODI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 09:03:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7136 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKCOCa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 09:02:30 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQWgf16V8z15MBt;
        Tue,  3 Nov 2020 22:02:22 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 22:02:21 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: tegra114: fix reference leak in tegra spi ops
Date:   Tue, 3 Nov 2020 22:13:06 +0800
Message-ID: <20201103141306.5607-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to pm_runtime_put_noidle will result in
reference leak in two callers(tegra_spi_setup and
tegra_spi_resume), so we should fix it.

Fixes: f333a331adfac ("spi/tegra114: add spi driver")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-tegra114.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index ca6886aaa519..a2e5907276e7 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -966,6 +966,7 @@ static int tegra_spi_setup(struct spi_device *spi)
 
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(tspi->dev);
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
 		if (cdata)
 			tegra_spi_cleanup(spi);
@@ -1474,6 +1475,7 @@ static int tegra_spi_resume(struct device *dev)
 
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
-- 
2.17.1

