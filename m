Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E6CF4F8
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2019 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfJHIYh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 04:24:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730393AbfJHIYg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 04:24:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BDD9EA1F9DCAC2506AF;
        Tue,  8 Oct 2019 16:24:34 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 16:24:27 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/2] spi: npcm: Remove set but not used variable 'val'
Date:   Tue, 8 Oct 2019 16:31:37 +0800
Message-ID: <1570523497-112804-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com>
References: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/spi/spi-npcm-pspi.c: In function npcm_pspi_handler:
drivers/spi/spi-npcm-pspi.c:296:6: warning: variable val set but not used [-Wunused-but-set-variable]

It is not used since commit 2a22f1b30cee ("spi:
npcm: add NPCM PSPI controller driver")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-npcm-pspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index b191d57..aff7059 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -293,7 +293,6 @@ static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
 static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
 {
 	struct npcm_pspi *priv = dev_id;
-	u16 val;
 	u8 stat;

 	stat = ioread8(priv->base + NPCM_PSPI_STAT);
@@ -303,7 +302,6 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)

 	if (priv->tx_buf) {
 		if (stat & NPCM_PSPI_STAT_RBF) {
-			val = ioread8(NPCM_PSPI_DATA + priv->base);
 			if (priv->tx_bytes == 0) {
 				npcm_pspi_disable(priv);
 				complete(&priv->xfer_done);
--
2.7.4

