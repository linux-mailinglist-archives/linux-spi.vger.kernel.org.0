Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB62E0E59
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLVSqH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:46:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLVSqH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:46:07 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiU2Y015056;
        Tue, 22 Dec 2020 12:44:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662670;
        bh=5tzANjfyu5Rj3wctVJuHxVcRtYnBIWKhBasMbV22tSs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FKmpbofBaZ7GLJGhHsEgsQvGfGVFMUX+qYDVH5dhXXCMoWIv7qUQWfoL1HOHcRGBG
         Gjlo2ZdyjaXjf7qRg2mTKAcmJOb52r4HoVzUYWiomD8+WwdsKznD/1dPgpx4R4gIH8
         qdrkWEL7GWyYGxsz7iqfyRPRnxd4UxfeRcRG1e60=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIiUD8000502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:30 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:30 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbZ003761;
        Tue, 22 Dec 2020 12:44:28 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] spi: cadence-quadspi: Set master max_speed_hz
Date:   Wed, 23 Dec 2020 00:14:19 +0530
Message-ID: <20201222184425.7028-2-p.yadav@ti.com>
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

As of commit 9326e4f1e5dd ("spi: Limit the spi device max speed to
controller's max speed"), the SPI device max speed is set to the
controller's max speed if it is larger. The Cadence QSPI controller does
not set the controller's max speed so it is left at its initial value of
0. This means the SPI device max speed is always set to 0.

The SPI device max speed is used to calculate the baud rate divider when
performing an operation. If this speed is 0, the default divider of 32
is used. No matter what speed is specified by the device tree property
'spi-max-frequency', the device will always operate at ref_clk / 32.

Fix this by setting master->max_speed_hz to the ref clock speed so the
correct divider can be calculated.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ba7d40c2922f..ea3890c7d9ff 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1279,6 +1279,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_deassert(rstc_ocp);
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
+	master->max_speed_hz = cqspi->master_ref_clk_hz;
 	ddata  = of_device_get_match_data(dev);
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
-- 
2.28.0

