Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8612F30B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2020 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgACCwR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 21:52:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgACCwQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jan 2020 21:52:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89861D7AD9A991B85F6D;
        Fri,  3 Jan 2020 10:52:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 10:52:04 +0800
From:   Xinwei Kong <kong.kongxinwei@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        fengsheng <fengsheng5@huawei.com>
Subject: [PATCH V2] spi: dw: use "smp_mb()" to avoid sending spi data error
Date:   Fri, 3 Jan 2020 10:52:10 +0800
Message-ID: <1578019930-55858-1-git-send-email-kong.kongxinwei@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Because of out-of-order execution about some CPU architecture,
In this debug stage we find Completing spi interrupt enable ->
prodrucing TXEI interrupt -> running "interrupt_transfer" function
will prior to set "dw->rx and dws->rx_end" data, so this patch add
memory barrier to enable dw->rx and dw->rx_end to be visible and
solve to send SPI data error.
eg:
it will fix to this following low possibility error in testing environment
which using SPI control to connect TPM Modules

kernel: tpm tpm0: Operation Timed out
kernel: tpm tpm0: tpm_relinquish_locality: : error -1

Signed-off-by: fengsheng <fengsheng5@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/spi/spi-dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5c..9396eb5 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -288,6 +288,9 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
 
+	/* Ensure dw->rx and dw->rx_end are visible */
+	smp_mb();
+
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-- 
2.7.4

