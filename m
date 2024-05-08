Return-Path: <linux-spi+bounces-2783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01B8BFACE
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE92B21D41
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3271B39;
	Wed,  8 May 2024 10:20:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAD7A15C
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163652; cv=none; b=kBsFLQsfEVqeuKlAcMokiG1R5PwAHkgMslf/7j0px98BWqKm/cPdmJCmODJbFrio1RgzU34i7Y/6g+xWLz6oxzkcBUrvkQH/XZxaxRHk+c5b/fTJjiBCsnFRFZx06Qo42Tg0abjHTy3DX3hhZyeUsqYcY2Pmv0fYybIS0Nv02ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163652; c=relaxed/simple;
	bh=ahjA+0juf9hLepuCgc/v2mLeGGaSzdoy5yLH1oH30JE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv2yo/OeD4dt1Nu+2axPUgOdzbU/5vF2t2xZozmdIBmyhsOjXdUktZKZdtXW8C6UD04JcY7WooFbsptbgsxSBRpSQJrZ6Dalc47euPL0GSxgFU36o9DppWalgiNYeOmJGcabV30Hvk4MIPZxYtkwkcv8oZ+qUiirevZv8Jd2RTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:985a:f2a2:ae2e:5981])
	by andre.telenet-ops.be with bizsmtp
	id LaLi2C002241EGo01aLiat; Wed, 08 May 2024 12:20:42 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4eOv-00EEuA-L4;
	Wed, 08 May 2024 12:20:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4ePh-00HAxO-QT;
	Wed, 08 May 2024 12:20:41 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-riscv@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: dw: Bail out early on unsupported target mode
Date: Wed,  8 May 2024 12:20:27 +0200
Message-Id: <7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the DesignWare SPI controller driver supports only host mode.
However, spi2 on the Kendryte K210 SoC supports only target mode,
triggering an error message on e.g. SiPEED MAiXBiT since commit
98d75b9ef282f6b9 ("spi: dw: Drop default number of CS setting"):

    dw_spi_mmio 50240000.spi: error -22: problem registering spi host
    dw_spi_mmio 50240000.spi: probe with driver dw_spi_mmio failed with error -22

As spi2 rightfully has no "num-cs" property, num_chipselect is now zero,
causing spi_alloc_host() to fail to register the controller.  Before,
the driver silently registered an SPI host controller with 4 chip
selects.

Reject target mode early on and warn the user, getting rid of the
error message.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 98d75b9ef282f6b9 is in spi/for-next (next-20240508 and later).

Overview of all SPI controllers on K210:

    spi0 (52000000.spi):
	num_cs = <4> in k210.dtsi
	num_cs = <1> override in sipeed_maix*.dts and canaan_kd233.dts
	DW_SPI_SER says 0xf (but value is unused)

    spi1 (53000000.spi):
	num_cs = <4> in k210.dtsi
	num_cs = <1> override in sipeed_maix*.dts and canaan_kd233.dts
	DW_SPI_SER says 0xf (but value is unused)

    spi2 (53000000.spi):
	spi-slave
	no num_cs property
	DW_SPI_SER says 0
	dw_spi_mmio 50240000.spi: error -22: problem registering spi host
	dw_spi_mmio 50240000.spi: probe with driver dw_spi_mmio failed with error -22

    spi3 (54000000.spi):
	num_cs = <4> in k210.dtsi
	DW_SPI_SER says 0x1 (but value is unused)
	Used in sipeed_maix*.dts, unused in canaan_kd233.dts

See also "[PATCH 2/2] riscv: dts: canaan: Disable I/O devices unless
used"
https://lore.kernel.org/r/f85d460efd7ad85ec59c9253c989b10a07f2ff24.1715163174.git.geert+renesas@glider.be
---
 drivers/spi/spi-dw-mmio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index c56de35eca988ee4..819907e332c4b004 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -321,6 +321,11 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct dw_spi *dws;
 	int ret;
 
+	if (device_property_read_bool(&pdev->dev, "spi-slave")) {
+		dev_warn(&pdev->dev, "spi-slave is not yet supported\n");
+		return -ENODEV;
+	}
+
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
 	if (!dwsmmio)
-- 
2.34.1


