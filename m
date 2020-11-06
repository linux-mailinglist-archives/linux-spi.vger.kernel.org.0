Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E702A8C3E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbgKFBnW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 20:43:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6747 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgKFBnV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 20:43:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CS37N2v5YzkYXv;
        Fri,  6 Nov 2020 09:43:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 09:43:12 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] spi: stm32-qspi: fix reference leak in stm32 qspi operations
Date:   Fri, 6 Nov 2020 09:53:57 +0800
Message-ID: <20201106015357.141235-1-zhangqilong3@huawei.com>
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
reference leak in two callers(stm32_qspi_exec_op and
stm32_qspi_setup), so we should fix it.

Fixes: 9d282c17b023a ("spi: stm32-qspi: Add pm_runtime support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-stm32-qspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index a900962b4336..947e6b9dc9f4 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -434,8 +434,10 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 
 	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(qspi->dev);
 		return ret;
+	}
 
 	mutex_lock(&qspi->lock);
 	ret = stm32_qspi_send(mem, op);
@@ -462,8 +464,10 @@ static int stm32_qspi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(qspi->dev);
 		return ret;
+	}
 
 	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
 
-- 
2.17.1

