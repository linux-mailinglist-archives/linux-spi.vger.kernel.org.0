Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D22D0BAF
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLGIXZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgLGIXZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:23:25 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78352C0613D1
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:22:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C9C44105E9584;
        Mon,  7 Dec 2020 09:22:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 786D510A8; Mon,  7 Dec 2020 09:22:43 +0100 (CET)
Message-Id: <dfa1d8c41b8acdfad87ec8654cd124e6e3cb3f31.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:02 +0100
Subject: [PATCH 02/17] spi: spi-geni-qcom: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_geni_remove() accesses the driver's private data after calling
spi_unregister_master() even though that function releases the last
reference on the spi_master and thereby frees the private data.

Moreover, since commit 1a9e489e6128 ("spi: spi-geni-qcom: Use OPP API to
set clk/perf state"), spi_geni_probe() leaks the spi_master allocation
if the calls to dev_pm_opp_set_clkname() or dev_pm_opp_of_add_table()
fail.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound and also
avoids the spi_master leak on probe.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.20+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.20+
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..0e3d8e6c08f4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -603,7 +603,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	spi = spi_alloc_master(dev, sizeof(*mas));
+	spi = devm_spi_alloc_master(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
 
@@ -673,7 +673,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
-	spi_master_put(spi);
 	dev_pm_opp_of_remove_table(&pdev->dev);
 put_clkname:
 	dev_pm_opp_put_clkname(mas->se.opp_table);
-- 
2.29.2

