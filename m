Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D43F0D02
	for <lists+linux-spi@lfdr.de>; Wed, 18 Aug 2021 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHRU4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 16:56:38 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:31927 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHRU4h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Aug 2021 16:56:37 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d40 with ME
        id j8vy250093riaq2038vzRl; Wed, 18 Aug 2021 22:56:01 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 18 Aug 2021 22:56:01 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org, zhangqing@loongson.cn
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: coldfire-qspi: Use clk_disable_unprepare in the remove function
Date:   Wed, 18 Aug 2021 22:55:56 +0200
Message-Id: <ee91792ddba61342b0d3284cd4558a2b0016c4e7.1629319838.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'clk_prepare_enable()' is used in the probe, so 'clk_disable_unprepare()'
should be used in the remove function to be consistent.

Fixes: 499de01c5c0b ("spi: coldfire-qspi: Use clk_prepare_enable and clk_disable_unprepare")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-coldfire-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 8996115ce736..263ce9047327 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -444,7 +444,7 @@ static int mcfqspi_remove(struct platform_device *pdev)
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
 	mcfqspi_cs_teardown(mcfqspi);
-	clk_disable(mcfqspi->clk);
+	clk_disable_unprepare(mcfqspi->clk);
 
 	return 0;
 }
-- 
2.30.2

