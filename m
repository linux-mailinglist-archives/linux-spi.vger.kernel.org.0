Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7363581FC
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDHLen (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 07:34:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16839 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhDHLem (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 07:34:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJyV1tjYz7tyG;
        Thu,  8 Apr 2021 19:32:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:34:20 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and related ifendif protection
Date:   Thu, 8 Apr 2021 19:31:45 +0800
Message-ID: <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
References: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ACPI_PTR() and related IS_ENABLED(CONFIG_ACPI) protection is
redundant, so drop them.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 0d9e103..d3a23b1 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -5,13 +5,13 @@
 // Copyright (c) 2019 HiSilicon Technologies Co., Ltd.
 // Author: John Garry <john.garry@huawei.com>
 
-#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/completion.h>
 #include <linux/dmi.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -508,18 +508,16 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id hisi_sfc_v3xx_acpi_ids[] = {
 	{"HISI0341", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, hisi_sfc_v3xx_acpi_ids);
-#endif
 
 static struct platform_driver hisi_sfc_v3xx_spi_driver = {
 	.driver = {
 		.name	= "hisi-sfc-v3xx",
-		.acpi_match_table = ACPI_PTR(hisi_sfc_v3xx_acpi_ids),
+		.acpi_match_table = hisi_sfc_v3xx_acpi_ids,
 	},
 	.probe	= hisi_sfc_v3xx_probe,
 };
-- 
2.8.1

