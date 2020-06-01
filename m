Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2D1E9EBF
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgFAHFa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 03:05:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39682 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgFAHF3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 03:05:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05175KIw014670;
        Mon, 1 Jun 2020 02:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590995120;
        bh=DUFl627kK2rb7/uEE5GWcOlEqxucdiP2Tok55deLo7Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C3cbcYq00LzFeOHu1+mFHrZvYhvVvw11zIgJ8odnCFrz1ku4t6ArSlLDG4BCz+Uur
         zmEfF52x+Vb+XdRZWcgc4KQsNHp/XDg+aDxI86u+om6oUrU0YCm4Pc9gWMCSKZqtFO
         nWIHje/qIVZbzZvWfzUR7DgGXYnU1Ju7JrLlvMuA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05175KIS061922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 02:05:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 02:05:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 02:05:20 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 051758s4016257;
        Mon, 1 Jun 2020 02:05:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: [RESEND PATCH v3 2/8] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
Date:   Mon, 1 Jun 2020 12:34:38 +0530
Message-ID: <20200601070444.16923-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601070444.16923-1-vigneshr@ti.com>
References: <20200601070444.16923-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently direct access mode is used on platforms that have AHB window
(memory mapped window) larger than flash size. This feature is limited
to TI platforms as non TI platforms have < 1MB of AHB window.
Therefore introduce a driver quirk to disable DAC mode and set it for
non TI compatibles. This is in preparation to move to spi-mem framework
where flash geometry cannot be known.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
index 9b8554d44fac8..8a9e17f79d8d9 100644
--- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
@@ -34,6 +34,7 @@
 
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
+#define CQSPI_DISABLE_DAC_MODE		BIT(1)
 
 /* Capabilities mask */
 #define CQSPI_BASE_HWCAPS_MASK					\
@@ -1261,7 +1262,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 
 		f_pdata->registered = true;
 
-		if (mtd->size <= cqspi->ahb_size) {
+		if (mtd->size <= cqspi->ahb_size &&
+		    !(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
 			f_pdata->use_direct_mode = true;
 			dev_dbg(nor->dev, "using direct mode for %s\n",
 				mtd->name);
@@ -1457,6 +1459,7 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
+	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
 static const struct cqspi_driver_platdata k2g_qspi = {
-- 
2.26.2

