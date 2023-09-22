Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDC7AAD79
	for <lists+linux-spi@lfdr.de>; Fri, 22 Sep 2023 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjIVJI6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Sep 2023 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIVJIr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Sep 2023 05:08:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF1114
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 02:08:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M5WpYx008217;
        Fri, 22 Sep 2023 04:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=y
        izn0r10iI29v+zVmw8nMMn+wYeTIFDsyIjdc/irnZQ=; b=iWmLGrQ059RoqFl3f
        coBkIY7jex0jeqNc5FuW6LylObrZIzXuMbTgTLV2NPEU5qzIw720thT45+/mKCDX
        8CZ0T3MC0ZUdU2uvjIlNAUgBMQeNHbnXfs1PdLbAKhjcV9o7lJWfy9Qk8vRRxdMP
        jvjeZ9jznnrv7yTVQr9rCo+3CJyU2TXFtQzjXVpzi2DMpYKauTWuUOuFvYVYQOv2
        FgJkKWuEB6tsMb7dI6YPasN3OPPymE5q9TlEKj7U7wBFen/JhVGsFx43bQYN6mW/
        qpHu0BAH9IqWJGIlel1OG47hp2Df5Yd0rk4GS04RAMDWwlKH3vQ15wQ4it/JMwkE
        CJ3sQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t8tvhrxd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 04:08:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 22 Sep
 2023 10:08:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 22 Sep 2023 10:08:29 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CA8F415B6;
        Fri, 22 Sep 2023 09:08:29 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Remove spurious pm_runtime_disable
Date:   Fri, 22 Sep 2023 10:08:29 +0100
Message-ID: <20230922090829.1467594-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gMMdIGQTHS5_yMaY-afZv_wyQmCtzyVj
X-Proofpoint-GUID: gMMdIGQTHS5_yMaY-afZv_wyQmCtzyVj
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A pm_runtime_disable was left in when the driver was ported to use
devm_pm_runtime_enable, remove it.

Fixes: ef75e767167a ("spi: cs42l43: Add SPI controller support")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 453a9b37ce785..d239fc5a49ccc 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -256,7 +256,6 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
-		pm_runtime_disable(priv->dev);
 		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
 	}
 
-- 
2.39.2

