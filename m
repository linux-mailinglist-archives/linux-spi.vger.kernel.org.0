Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5D2F4699
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 09:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbhAMIet (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 03:34:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10654 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbhAMIet (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jan 2021 03:34:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DG10x6V74z15rsT;
        Wed, 13 Jan 2021 16:33:05 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 13 Jan 2021 16:33:59 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] spi: hisi-sfc-v3xx: extend version checking compatibility
Date:   Wed, 13 Jan 2021 16:31:56 +0800
Message-ID: <1610526716-14882-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently we use concrete version to determine the max_cmd_dword.
New entries should be added for compatible hardwares of new version
or on new platform, otherwise the device will use 16 dwords instead
of 64 even if it supports, which will degrade the performance.
This will decrease the compatibility and the maintainability.

Drop the switch-case statement of the version checking. Only version
less than 0x351 supports maximum 16 command dwords.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: John Garry <john.garry@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4650b48..832b80e 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -465,14 +465,10 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 
 	version = readl(host->regbase + HISI_SFC_V3XX_VERSION);
 
-	switch (version) {
-	case 0x351:
+	if (version >= 0x351)
 		host->max_cmd_dword = 64;
-		break;
-	default:
+	else
 		host->max_cmd_dword = 16;
-		break;
-	}
 
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-- 
2.8.1

