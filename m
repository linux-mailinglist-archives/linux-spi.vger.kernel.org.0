Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639A42A8C29
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgKFBlh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 20:41:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7596 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFBlh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 20:41:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS35P2VrXzLrWD;
        Fri,  6 Nov 2020 09:41:29 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 09:41:33 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] spi: stm32: fix reference leak in stm32_spi_resume
Date:   Fri, 6 Nov 2020 09:52:17 +0800
Message-ID: <20201106015217.140476-1-zhangqilong3@huawei.com>
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
reference leak in stm32_spi_resume, so we should fix it.

Fixes: db96bf976a4fc ("spi: stm32: fixes suspend/resume management")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2cc850eb8922..471dedf3d339 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2062,6 +2062,7 @@ static int stm32_spi_resume(struct device *dev)
 
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
 		dev_err(dev, "Unable to power device:%d\n", ret);
 		return ret;
 	}
-- 
2.17.1

