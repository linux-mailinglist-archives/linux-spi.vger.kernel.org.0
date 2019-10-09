Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839B6D04C6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2019 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfJIAaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 20:30:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJIAaP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 20:30:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 746D587CF0B4D07EB8B3;
        Wed,  9 Oct 2019 08:30:13 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 08:30:06 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <geert@linux-m68k.org>,
        <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH v2 1/2] spi: omap-100k: Remove set but not used variable 'dataH'
Date:   Wed, 9 Oct 2019 08:37:16 +0800
Message-ID: <1570581437-104549-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570581437-104549-1-git-send-email-zhengbin13@huawei.com>
References: <1570581437-104549-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/spi/spi-omap-100k.c: In function spi100k_read_data:
drivers/spi/spi-omap-100k.c:140:6: warning: variable dataH set but not used [-Wunused-but-set-variable]

It is not used since commit 35c9049b2704 ("Add OMAP spi100k driver")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-omap-100k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b955ca8..43a4785 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -128,7 +128,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)

 static int spi100k_read_data(struct spi_master *master, int len)
 {
-	int dataH, dataL;
+	int dataL;
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);

 	/* Always do at least 16 bits */
@@ -146,7 +146,7 @@ static int spi100k_read_data(struct spi_master *master, int len)
 	udelay(1000);

 	dataL = readw(spi100k->base + SPI_RX_LSB);
-	dataH = readw(spi100k->base + SPI_RX_MSB);
+	readw(spi100k->base + SPI_RX_MSB);
 	spi100k_disable_clock(master);

 	return dataL;
--
2.7.4

