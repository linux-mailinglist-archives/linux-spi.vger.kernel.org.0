Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0B3E5DAB
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhHJOW2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 10:22:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17002 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhHJOSb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Aug 2021 10:18:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GkZhN34Tzzb0WH;
        Tue, 10 Aug 2021 22:14:28 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 22:18:06 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 22:18:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <zhengxunli@mxic.com.tw>
Subject: [PATCH -next] spi: mxic: add missing braces
Date:   Tue, 10 Aug 2021 22:24:05 +0800
Message-ID: <20210810142405.2221540-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following waring:

drivers/spi/spi-mxic.c: In function ‘mxic_spi_mem_exec_op’:
drivers/spi/spi-mxic.c:401:3: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
   if (op->data.dir == SPI_MEM_DATA_IN)
   ^~
drivers/spi/spi-mxic.c:403:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
    if (op->data.dtr)
    ^~

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-mxic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 32e757a04f14..45889947afed 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -398,10 +398,11 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	if (op->data.nbytes) {
 		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
 			   (op->data.dtr ? OP_DATA_DDR : 0);
-		if (op->data.dir == SPI_MEM_DATA_IN)
+		if (op->data.dir == SPI_MEM_DATA_IN) {
 			ss_ctrl |= OP_READ;
 			if (op->data.dtr)
 				ss_ctrl |= OP_DQS_EN;
+		}
 	}
 
 	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
-- 
2.25.1

