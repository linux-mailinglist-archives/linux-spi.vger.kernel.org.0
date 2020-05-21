Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C129B1DCC0B
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEULYV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 07:24:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728922AbgEULYU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 07:24:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0389779028A765082C68;
        Thu, 21 May 2020 19:24:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 19:24:07 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <john.garry@huawei.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: [RFC PATCH 2/3] mtd: spi-nor: Add prepare/unprepare support for spimem device
Date:   Thu, 21 May 2020 19:23:50 +0800
Message-ID: <1590060231-23242-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi-nor flash's read/write/erase/lock/unlock may be composed of a set
of operations, and some prepare/unprepare works need to be done before/
after these operations in spi_nor_{lock, unlock}_and_{prep, unprep}().
Previously we only call spi-nor controllers' prepare/unprepare method
in the functions, without spimem devices'.

Add spimem devices' prepare/unprepare support. Call spi_mem_{prepare,
unprepare}() function if it's a spimem device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/mtd/spi-nor/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc68ea8..3a7e40a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1103,7 +1103,9 @@ int spi_nor_lock_and_prep(struct spi_nor *nor)
 
 	mutex_lock(&nor->lock);
 
-	if (nor->controller_ops &&  nor->controller_ops->prepare) {
+	if (nor->spimem) {
+		ret = spi_mem_prepare(nor->spimem);
+	} else if (nor->controller_ops &&  nor->controller_ops->prepare) {
 		ret = nor->controller_ops->prepare(nor);
 		if (ret) {
 			mutex_unlock(&nor->lock);
@@ -1115,7 +1117,9 @@ int spi_nor_lock_and_prep(struct spi_nor *nor)
 
 void spi_nor_unlock_and_unprep(struct spi_nor *nor)
 {
-	if (nor->controller_ops && nor->controller_ops->unprepare)
+	if (nor->spimem)
+		spi_mem_unprepare(nor->spimem);
+	else if (nor->controller_ops && nor->controller_ops->unprepare)
 		nor->controller_ops->unprepare(nor);
 	mutex_unlock(&nor->lock);
 }
-- 
2.8.1

