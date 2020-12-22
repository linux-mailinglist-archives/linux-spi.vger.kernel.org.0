Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1EB2E0E5C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLVSqK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:46:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54408 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLVSqJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:46:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiWMo015098;
        Tue, 22 Dec 2020 12:44:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662672;
        bh=Cl95KK0DmwpZMTWIjZUAGICKHjvbYSLMRkQKI8fTV0Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gbYt/eu6v2w+MOIzkrGiz7Mu6q061kECXDDYLlC4udpJdPPX2gNW2FiwD5eKSmrFX
         GNhi09l88sAp63kn3E6uYdqCuhnBNO9+aLVWbN0A5RBHYJnm0A3EayXZ3lcqwZfD1t
         7STqoPDBE/PMsgTZvP3y3mU4K2PTIyFxYV/DcOqI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIiWvT000527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:32 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:32 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQba003761;
        Tue, 22 Dec 2020 12:44:30 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] spi: cadence-quadspi: Abort read if dummy cycles required are too many
Date:   Wed, 23 Dec 2020 00:14:20 +0530
Message-ID: <20201222184425.7028-3-p.yadav@ti.com>
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

The controller can only support up to 31 dummy cycles. If the command
requires more it falls back to using 31. This command is likely to fail
because the correct number of cycles are not waited upon. Rather than
silently issuing an incorrect command, fail loudly so the caller can get
a chance to find out the command can't be supported by the controller.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ea3890c7d9ff..5efb1f929be0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -461,7 +461,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	/* Setup dummy clock cycles */
 	dummy_clk = op->dummy.nbytes * 8;
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
-		dummy_clk = CQSPI_DUMMY_CLKS_MAX;
+		return -EOPNOTSUPP;
 
 	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
-- 
2.28.0

