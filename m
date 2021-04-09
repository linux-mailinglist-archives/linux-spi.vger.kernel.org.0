Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0D359952
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIJg7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 05:36:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15649 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIJg7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 05:36:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGtHT2qLMzpWtJ;
        Fri,  9 Apr 2021 17:33:57 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 17:36:37 +0800
From:   Wang Li <wangli74@huawei.com>
To:     <broonie@kernel.org>, <han.xu@nxp.com>, <xiaoning.wang@nxp.com>,
        <frank.li@nxp.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Li <wangli74@huawei.com>
Subject: [PATCH -next] spi: fsl-lpspi: Fix PM reference leak in lpspi_prepare_xfer_hardware()
Date:   Fri, 9 Apr 2021 09:54:30 +0000
Message-ID: <20210409095430.29868-1-wangli74@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Li <wangli74@huawei.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a2886ee44e4c..5d98611dd999 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -200,7 +200,7 @@ static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 				spi_controller_get_devdata(controller);
 	int ret;
 
-	ret = pm_runtime_get_sync(fsl_lpspi->dev);
+	ret = pm_runtime_resume_and_get(fsl_lpspi->dev);
 	if (ret < 0) {
 		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
 		return ret;
-- 
2.17.1

