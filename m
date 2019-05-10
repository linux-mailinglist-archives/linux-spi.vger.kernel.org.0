Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7EA19A83
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEJJVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 05:21:21 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:26527 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEJJVV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 05:21:21 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4A9L6R3071177;
        Fri, 10 May 2019 18:21:06 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 10 May 2019 18:21:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from localhost (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4A9L1Bc071134
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 May 2019 18:21:06 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
From:   Nguyen An Hoan <na-hoan@jinso.co.jp>
To:     broonie@kernel.org, linux-rpi-kernel@lists.infradead.org,
        eric@anholt.net, stefan.wahren@i2se.com
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH] spi: bcm2835aux: Remove spi_alloc_master() error printing
Date:   Fri, 10 May 2019 18:21:00 +0900
Message-Id: <1557480060-15311-1-git-send-email-na-hoan@jinso.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

Printing an error on memory allocation failure is unnecessary,
as the memory allocation core code already takes care of that.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
---
 drivers/spi/spi-bcm2835aux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index f7e0548..64d17f7 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -430,10 +430,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	int err;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master) {
-		dev_err(&pdev->dev, "spi_alloc_master() failed\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, master);
 	master->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
-- 
2.7.4

