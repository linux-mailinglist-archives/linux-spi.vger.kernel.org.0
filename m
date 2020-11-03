Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B32A3DE6
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCHnn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 02:43:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7038 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 02:43:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQMGg5mvbzhXkR;
        Tue,  3 Nov 2020 15:43:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:43:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] spi: bcm63xx-hsspi: fix missing clk_disable_unprepare() on error in bcm63xx_hsspi_resume
Date:   Tue, 3 Nov 2020 15:49:11 +0800
Message-ID: <20201103074911.195530-1-miaoqinglang@huawei.com>
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
from bcm63xx_hsspi_resume in the error handling case when
fails to prepare and enable bs->pll_clk.

Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9909b18f3..1f08d7553 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -494,8 +494,10 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 
 	if (bs->pll_clk) {
 		ret = clk_prepare_enable(bs->pll_clk);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(bs->clk);
 			return ret;
+		}
 	}
 
 	spi_master_resume(master);
-- 
2.23.0

