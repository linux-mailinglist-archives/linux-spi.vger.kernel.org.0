Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36053F0C24
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2019 03:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfKFCgj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Nov 2019 21:36:39 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:40950 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfKFCgj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Nov 2019 21:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZFXpLVG5uThs7vf3Kv
        ZYYNRN+s4SQE8rWXfbVnccwms=; b=hrVyVY3fAg3vDNzXzKQTC3krID75xcW+g0
        nZG0maYhqi/nF1PXSbISVVPTGcBxTjyHzw2Gq/i8cHu68bfaM2gqDSoKrQHzv1PX
        dcWDoAjH/ouzu6B4cLW0akhPRaO2vdFDGIEpJWDZ68O54BqUl9PXlEMXAponzoiJ
        e7ZHUVC+4=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgB35LacMcJdwsA2BA--.329S3;
        Wed, 06 Nov 2019 10:36:35 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] spi: img-spfi: fix potential double release
Date:   Wed,  6 Nov 2019 10:36:09 +0800
Message-Id: <1573007769-20131-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgB35LacMcJdwsA2BA--.329S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrury5Zr48Ar4DGFWxJF4xWFg_yoWDGFXE9r
        48Wws7Cr10yrWjgF17KrW8JryaqF98X3Z8J3Z2qFZxt34DAFn2v34qqr1vg348uw47CFZ8
        CFs5Xa4rury3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbO6ptUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQBNlclSIdHxr6gAAsR
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The channels spfi->tx_ch and spfi->rx_ch are not set to NULL after they
are released. As a result, they will be released again, either on the
error handling branch in the same function or in the corresponding
remove function, i.e. img_spfi_remove(). This patch fixes the bug by
setting the two members to NULL.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/spi/spi-img-spfi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 439b01e4a2c8..f4a8f470aecc 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -673,6 +673,8 @@ static int img_spfi_probe(struct platform_device *pdev)
 			dma_release_channel(spfi->tx_ch);
 		if (spfi->rx_ch)
 			dma_release_channel(spfi->rx_ch);
+		spfi->tx_ch = NULL;
+		spfi->rx_ch = NULL;
 		dev_warn(spfi->dev, "Failed to get DMA channels, falling back to PIO mode\n");
 	} else {
 		master->dma_tx = spfi->tx_ch;
-- 
2.7.4

