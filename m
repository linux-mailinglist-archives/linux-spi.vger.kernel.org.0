Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC3129D22
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 04:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXDoz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfLXDoz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D5603C2F448158B442B;
        Tue, 24 Dec 2019 11:44:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:44:45 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 1/3] spi: fsl-lpspi: use true,false for bool variable
Date:   Tue, 24 Dec 2019 11:52:04 +0800
Message-ID: <1577159526-33689-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
References: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes coccicheck warning:

drivers/spi/spi-fsl-lpspi.c:472:2-19: WARNING: Assignment of 0/1 to bool variable
drivers/spi/spi-fsl-lpspi.c:474:2-19: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2cc0ddb..56855d5 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -469,9 +469,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 		fsl_lpspi->watermark = fsl_lpspi->txfifosize;

 	if (fsl_lpspi_can_dma(controller, spi, t))
-		fsl_lpspi->usedma = 1;
+		fsl_lpspi->usedma = true;
 	else
-		fsl_lpspi->usedma = 0;
+		fsl_lpspi->usedma = false;

 	return fsl_lpspi_config(fsl_lpspi);
 }
--
2.7.4

