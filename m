Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34A2D0BE4
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLGImC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGImC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:42:02 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBCDC0613D0
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:41:21 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 258A2280001A5;
        Mon,  7 Dec 2020 09:41:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4B347CD2; Mon,  7 Dec 2020 09:41:20 +0100 (CET)
Message-Id: <36ad42760087952fb7c10aae7d2628547c26a7ec.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:13 +0100
Subject: [PATCH 13/17] spi: mt7621: Disable clock in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 702b15cb9712 ("spi: mt7621: fix missing clk_disable_unprepare()
on error in mt7621_spi_probe") sought to disable the SYS clock on probe
errors, but only did so for 2 of 3 potentially failing calls:  The clock
needs to be disabled on failure of devm_spi_register_controller() as
well.

Moreover, the commit purports to fix a bug in commit cbd66c626e16 ("spi:
mt7621: Move SPI driver out of staging") but in reality the bug has
existed since the driver was first introduced.

Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.17+: 702b15cb9712: spi: mt7621: fix missing clk_disable_unprepare() on error in mt7621_spi_probe
Cc: <stable@vger.kernel.org> # v4.17+
Cc: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/spi/spi-mt7621.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 2cdae7994e2a..e227700808cb 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -382,7 +382,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_spi_register_controller(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, master);
+	if (ret)
+		clk_disable_unprepare(clk);
+
+	return ret;
 }
 
 static int mt7621_spi_remove(struct platform_device *pdev)
-- 
2.29.2

