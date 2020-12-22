Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66322E0E5D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgLVSqN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:46:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54422 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLVSqN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:46:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiaV9015122;
        Tue, 22 Dec 2020 12:44:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662676;
        bh=+5MUFx6m4aRjz+9UKgH8r17yzKrXbsPFbYTO9PLMrh0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PHgffoGaDBO1NCMGl9e9rmXzQ0I9MFZ0zS+nwywnkZBvDIQV/zmmDJ/191cPhOjCL
         5/oZiyzKkmpEdVVNK2oUV8t6DtJTc+r1vBLkE24YSQn6gSrWWZjrfNTLprA1/qipvW
         EfVw6Y4JO50CpbLTxjbMcXqJ/kyiraHVRhphLtSE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIiaEb098649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:36 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:36 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbc003761;
        Tue, 22 Dec 2020 12:44:34 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1
Date:   Wed, 23 Dec 2020 00:14:22 +0530
Message-ID: <20201222184425.7028-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201222184425.7028-1-p.yadav@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI MEM deals with dummy bytes but the controller deals with dummy
cycles. Multiplying bytes by 8 is correct if the dummy phase uses 1S
mode since 1 byte will be sent in 8 cycles. But if the dummy phase uses
4S mode then 1 byte will be sent in 2 cycles.

To correctly translate dummy bytes to dummy cycles, the dummy buswidth
also needs to be taken into account. Divide 8 by the buswidth to get the
correct multiplier for getting the number of cycles.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6a778014ff60..376abef43530 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -294,7 +294,7 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
 {
 	unsigned int dummy_clk;
 
-	dummy_clk = op->dummy.nbytes * 8;
+	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
 
 	return dummy_clk;
 }
-- 
2.28.0

