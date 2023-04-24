Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C16ECA49
	for <lists+linux-spi@lfdr.de>; Mon, 24 Apr 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjDXK23 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjDXK2E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 06:28:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7AC59FF
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 03:26:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OAPpUM029107;
        Mon, 24 Apr 2023 05:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682331951;
        bh=Cb+/JcSw+bD6FbluacUYXpN/XT18TEBmAiwqOoMD4fc=;
        h=From:To:CC:Subject:Date;
        b=yMHBekZrpGO9yf+meAvJw8M+QL1GjBqVihJjHJEMN0glkj9MsLgwQziHgCX4etByP
         zLH4FHPLRn6ixOLYY+xSVI4Mkkgi8Mp3kDcd/aUjDMc18nAYMevbeSd7fR2LjWK+6m
         v+cTaW7cqpW0d29MwObufR7eyU2tioOlF+tAHxZg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OAPpBG008649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 05:25:51 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 05:25:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 05:25:51 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OAPov9071282;
        Mon, 24 Apr 2023 05:25:50 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Jonas Gorski <jonas.gorski@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS
Date:   Mon, 24 Apr 2023 15:55:46 +0530
Message-ID: <20230424102546.1604484-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Using this macro makes the code more readable.
It also inits the members of dev_pm_ops in the following manner
without us explicitly needing to:

.suspend = bcm63xx_spi_suspend, \
.resume = bcm63xx_spi_resume, \
.freeze = bcm63xx_spi_suspend, \
.thaw = bcm63xx_spi_resume, \
.poweroff = bcm63xx_spi_suspend, \
.restore = bcm63xx_spi_resume

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-bcm63xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 99395932074c..9aecb77c3d89 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -644,9 +644,7 @@ static int bcm63xx_spi_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(bcm63xx_spi_suspend, bcm63xx_spi_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm63xx_spi_pm_ops, bcm63xx_spi_suspend, bcm63xx_spi_resume);
 
 static struct platform_driver bcm63xx_spi_driver = {
 	.driver = {
-- 
2.25.1

