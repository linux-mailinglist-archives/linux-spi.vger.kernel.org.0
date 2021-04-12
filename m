Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FF35C5DC
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhDLMBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 08:01:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16447 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbhDLMBc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Apr 2021 08:01:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJnMP4mW7zqTRX;
        Mon, 12 Apr 2021 19:58:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 20:01:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/2] spi: hisi-sfc-v3xx: drop unnecessary ACPI_PTR and related ifendif protection
Date:   Mon, 12 Apr 2021 19:58:28 +0800
Message-ID: <1618228708-37949-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
References: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We use ACPI_PTR() and related ifendif protection for the id table.
This is unnecessary as the struct acpi_device_id is defined in
mod_devicetable.h and doesn't rely on ACPI. The driver doesn't
use any ACPI apis, so it can be compiled in the ACPI=n case
with no warnings.

So remove the ACPI_PTR and related ifendif protection, also
replace the header acpi.h with mod_devicetable.h.

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

