Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4494D1A313E
	for <lists+linux-spi@lfdr.de>; Thu,  9 Apr 2020 10:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgDIIvq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Apr 2020 04:51:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDIIvq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Apr 2020 04:51:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B51C658B19EB8263FEEF;
        Thu,  9 Apr 2020 16:51:43 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:51:36 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] spi: spi-mtk-nor: make mtk_nor_exec_op() statuc
Date:   Thu, 9 Apr 2020 16:50:09 +0800
Message-ID: <20200409085009.44971-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following sparse warning:

drivers/spi/spi-mtk-nor.c:394:5: warning: symbol 'mtk_nor_exec_op' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/spi/spi-mtk-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index c15a9910549f..7bc302b50396 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -391,7 +391,7 @@ static int mtk_nor_pp_unbuffered(struct mtk_nor *sp,
 	return mtk_nor_cmd_exec(sp, MTK_NOR_CMD_WRITE, 6 * BITS_PER_BYTE);
 }
 
-int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
 	int ret;
-- 
2.17.2

