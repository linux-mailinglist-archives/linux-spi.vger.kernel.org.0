Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC46D2EF72B
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbhAHSQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 13:16:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48078 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbhAHSQh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 13:16:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108IF0lV106593;
        Fri, 8 Jan 2021 12:15:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610129700;
        bh=KpVH0T45ukV3JB85id8uO0iEDiN+mFCps3nC6zX2Kx4=;
        h=From:To:CC:Subject:Date;
        b=ytFv0HIIxSs0y36sEf2SO/SX2MbUQpYmrNAif5XJz10hkHKspKZJQjVOBzUTRWjUi
         zZ0+/iH5ChoIoZYu/klaRU90fDHsevisx+HKcC10MtvpXRAFK7iqUvV57UkcMXYX7W
         D1fi2vRaNlwbm2eHidk70I8sjsl/HP6sbVGiLKQQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108IF02r056201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 12:15:00 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 12:15:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 12:14:59 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108IEwVm113769;
        Fri, 8 Jan 2021 12:14:58 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] spi: cadence-quadspi: Fix build warning on 32-bit platforms
Date:   Fri, 8 Jan 2021 23:44:57 +0530
Message-ID: <20210108181457.30291-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The kernel test robot reports the following warning.

drivers/spi/spi-cadence-quadspi.c:966:24: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (500UL) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                                            msecs_to_jiffies(max(len, 500UL)))) {
                                                             ^~~~~~~~~~~~~~~
   include/linux/minmax.h:58:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:42:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:32:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:18:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.

This happens because size_t is unsigned long on 64-bit platforms like
arm64 but it is unsigned int on 32-bit platforms like arm. Omitting the
"UL" would result in a warning on 64-bit platforms. Squash it by type
casting the arguments to size_t using max_t(). This way builds on both
type of platforms can be satisfied. There is no chance of any truncation
since 500 is small enough to fit into both int and long.

Fixes: f453f293979f ("spi: cadence-quadspi: Wait at least 500 ms for direct reads")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 06a65e9a8a60..af13c0025bf5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,

 	dma_async_issue_pending(cqspi->rx_chan);
 	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(max(len, 500UL)))) {
+					 msecs_to_jiffies(max_t(size_t, len, 500)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
--
2.28.0

