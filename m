Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C259F11ABD1
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 14:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLKNQB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 08:16:01 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:48802 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfLKNQA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 08:16:00 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id cdFz2100F5USYZQ01dFzny; Wed, 11 Dec 2019 14:15:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1if1qR-0000mm-CX; Wed, 11 Dec 2019 14:15:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1if1qR-0006FB-B7; Wed, 11 Dec 2019 14:15:59 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Remove obsolete platform_device_id entries
Date:   Wed, 11 Dec 2019 14:15:53 +0100
Message-Id: <20191211131553.23960-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commits 05104c266ae9a167 ("ARM: shmobile: r7s72100: genmai: Remove
legacy board file") and a483dcbfa21f919c ("ARM: shmobile: lager: Remove
legacy board support", RZ/A1 and R-Car Gen2 SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
match platform devices by name anymore for these platforms, hence remove
the corresponding platform_device_id entries.

The platform_device_id entry for "rspi" is retained, as it is used by
the SH7757 platform, which hasn't been converted to DT yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Acked-by,
  - Merge two patches,
  - Explain "rspi".
---
 drivers/spi/spi-rspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7222c7689c3c4cea..74a12f4dee849125 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1314,8 +1314,6 @@ static int rspi_probe(struct platform_device *pdev)
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
-	{ "rspi-rz",	(kernel_ulong_t)&rspi_rz_ops },
-	{ "qspi",	(kernel_ulong_t)&qspi_ops },
 	{},
 };
 
-- 
2.17.1

