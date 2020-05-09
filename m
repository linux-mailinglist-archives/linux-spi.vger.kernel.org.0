Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F831CBC8A
	for <lists+linux-spi@lfdr.de>; Sat,  9 May 2020 04:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEICbH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 22:31:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbgEICbG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 22:31:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B16A4E27C976C060B50E;
        Sat,  9 May 2020 10:31:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:30:55 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <huangdaode@hisilicon.com>,
        <f.fangjian@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH] spi: dw-mmio: Do not add acpi modalias when CONFIG_ACPI is not enabled
Date:   Sat, 9 May 2020 10:29:51 +0800
Message-ID: <1588991392-24219-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reduce unnecessary static memory allocation when CONFIG_ACPI is not enabled.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-dw-mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 384a3ab..ad26283 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -233,11 +233,13 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
 	{"HISI0173", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
+#endif
 
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
-- 
2.7.4

