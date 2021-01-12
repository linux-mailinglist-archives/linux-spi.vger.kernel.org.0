Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE122F2C3B
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390409AbhALKHl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 05:07:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10958 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbhALKHl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jan 2021 05:07:41 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DFR6q1dkgzj5Pf;
        Tue, 12 Jan 2021 18:06:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 12 Jan 2021 18:06:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 1/1] spi: cadence-quadspi: Fix a compilation warning for 64-bit platform
Date:   Tue, 12 Jan 2021 18:06:37 +0800
Message-ID: <20210112100637.747-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210112100637.747-1-thunder.leizhen@huawei.com>
References: <20210112100637.747-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The __typecheck() requires that the two arguments of max() must be of the
same type. For the current max(), the type of the first parameter "len" is
size_t. But the type of size_t is not fixed, it's "unsigned int" on 32-bit
platforms and "unsigned long" on 64-bit platforms. So both the suffix "U"
and "UL" are not appropriate for the second constant parameter. Therefore,
forcible type conversion is used.

Fixes: 8728a81b8f10 ("spi: Fix distinct pointer types warning for ARCH=mips")
Fixes: 0920a32cf6f2 ("spi: cadence-quadspi: Wait at least 500 ms for direct reads")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 576610ba11184c6..eb40b8d46b56b0c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,

 	dma_async_issue_pending(cqspi->rx_chan);
 	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(max(len, 500U)))) {
+				 msecs_to_jiffies(max_t(size_t, len, 500)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
--
1.8.3


