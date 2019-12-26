Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67F412AB2F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2019 10:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLZJVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 04:21:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfLZJVo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Dec 2019 04:21:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D85C7F4F8B1FEB2C7C16;
        Thu, 26 Dec 2019 17:21:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 26 Dec 2019 17:21:32 +0800
From:   Xinwei Kong <kong.kongxinwei@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        fengsheng <fengsheng5@huawei.com>
Subject: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date:   Thu, 26 Dec 2019 17:21:28 +0800
Message-ID: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch will add memory barrier to ensure this "struct dw_spi *dws"
to complete data setting before enabling this SPI hardware interrupt.
eg:
it will fix to this following low possibility error in testing environment
which using SPI control to connect TPM Modules

kernel: tpm tpm0: Operation Timed out
kernel: tpm tpm0: tpm_relinquish_locality: : error -1

Signed-off-by: fengsheng <fengsheng5@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/spi/spi-dw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5c..d0d77a2 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
 
+	smp_mb();
+
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-- 
2.7.4

