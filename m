Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6CF2A4727
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 14:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgKCN7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 08:59:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7590 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgKCN6d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 08:58:33 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQWb72WXSzLt8Y;
        Tue,  3 Nov 2020 21:58:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 21:58:25 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: spi-mem: fix reference leak in spi_mem_access_start
Date:   Tue, 3 Nov 2020 22:09:10 +0800
Message-ID: <20201103140910.3482-1-zhangqilong3@huawei.com>
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
reference leak in spi_mem_access_start, so we should fix it.

Fixes: f86c24f479530 ("spi: spi-mem: Split spi_mem_exec_op() code")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ef53290b7d24..4682f49dc733 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -243,6 +243,7 @@ static int spi_mem_access_start(struct spi_mem *mem)
 
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
 		if (ret < 0) {
+			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			return ret;
-- 
2.17.1

