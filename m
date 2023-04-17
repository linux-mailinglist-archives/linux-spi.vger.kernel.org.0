Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316F6E4350
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDQJKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjDQJKt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 05:10:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B64184
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 02:10:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33H9Aeeo074935;
        Mon, 17 Apr 2023 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681722640;
        bh=djsfRLtJu+oPMbnsgsWcD0rMfU9D4nVXsTjgpcSvFLk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ArqxgP/dStID3aR0LcMffpiac4Vdo+UkWv5MJndxIYM4zTiW+KOtwm4awpRgLj+gm
         GE76uSAyI5KgryZ7H36ukQWkT9YJvPe9miwj1PY/50mU/eAS66uBlAiHulLVg22+eD
         cUzvkdYqvOuUxFxbBHL+sBLDgZ22B3fgvw9msnYU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33H9AeLI005866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 04:10:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 04:10:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 04:10:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33H9Adj2102013;
        Mon, 17 Apr 2023 04:10:39 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 1/2] spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
Date:   Mon, 17 Apr 2023 14:40:26 +0530
Message-ID: <20230417091027.966146-2-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417091027.966146-1-d-gole@ti.com>
References: <20230417091027.966146-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

.suspend = cqspi_suspend, \
.resume = cqspi_resume, \
.freeze = suspend_fn, \
.thaw = resume_fn, \
.poweroff = suspend_fn, \
.restore = resume_fn,

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 79ab7e309644..d47e954fe809 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1829,10 +1829,7 @@ static int cqspi_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops cqspi__dev_pm_ops = {
-	.suspend = cqspi_suspend,
-	.resume = cqspi_resume,
-};
+static SIMPLE_DEV_PM_OPS(cqspi__dev_pm_ops, cqspi_suspend, cqspi_resume);
 
 #define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
 #else
-- 
2.25.1

