Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A835CA6E
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbhDLPuy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 11:50:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhDLPux (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Apr 2021 11:50:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJtRJ1r2HzPqLV;
        Mon, 12 Apr 2021 23:47:40 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 23:50:25 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] spi: spi-zynqmp-gqspi: Fix missing unlock on error in zynqmp_qspi_exec_op()
Date:   Mon, 12 Apr 2021 16:00:25 +0000
Message-ID: <20210412160025.194171-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the missing unlock before return from function zynqmp_qspi_exec_op()
in the error handling case.

Fixes: a0f65be6e880 ("spi: spi-zynqmp-gqspi: add mutex locking for exec_op")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9494da9aea40..1670b0aeaa23 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -965,8 +965,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 
 	if (op->cmd.opcode) {
 		tmpbuf = kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
-		if (!tmpbuf)
+		if (!tmpbuf) {
+			mutex_unlock(&xqspi->op_lock);
 			return -ENOMEM;
+		}
 		tmpbuf[0] = op->cmd.opcode;
 		reinit_completion(&xqspi->data_completion);
 		xqspi->txbuf = tmpbuf;

