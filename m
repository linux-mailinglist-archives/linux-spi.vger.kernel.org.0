Return-Path: <linux-spi+bounces-2373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0E8A6F7F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 17:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB6283E4B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F5130A69;
	Tue, 16 Apr 2024 15:16:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79791130491
	for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280608; cv=none; b=TzK3r/5dXPcpPedeBLSVOaUrrd0CSwUKZU+13VnVCgBamz6VATqHK9qlbBdTVpVN4CJwUvmMweRAqdIcY9CHIhru/7g3HeCrgD6y3lYo1uJIZHsyCTRDRiXbAp99EiunvtmRN36fP0mWtzKSR7UDwi0mqQFAyEENr8Dzo8KvbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280608; c=relaxed/simple;
	bh=nX24++Y/SpRn/H8pwQbhV7LIRud/WSkCXVAgXdCiryQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jag0kxMMd1Epmg89DKnl1mqf+1vedEJugUM60Ij/+lZZL3VkLBAbUZCIJgC4qmKmcmlME6ADVXPHdixG3NI/fej4WHGY5qnHLjwOZECv3KvOW3gzOu0ovSCbDPq9lAk0fKDtDMT7K/nrPi6+Cq6l8eyQ+XrfaCa/aUWfal0twe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id BrGl2C0080SSLxL06rGlTD; Tue, 16 Apr 2024 17:16:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwkXZ-008FA9-PR;
	Tue, 16 Apr 2024 17:16:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwkY9-00EbMz-51;
	Tue, 16 Apr 2024 17:16:45 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] spi: sh-msiof: Remove unneeded compatible values
Date: Tue, 16 Apr 2024 17:16:43 +0200
Message-Id: <f7746870b392197d176c492d174599e025dd3af8.1713280353.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Clock-Synchronized Serial Interfaces with FIFO (MSIOF) driver
matches against both SoC-specific and family-specific compatible values
to maintain backwards-compatibility with old DTBs predating the
introduction of the family-specific compatible values.

For RZ/G1, the SoC-specific compatible match entry can be removed from
the driver: their DT always had the family-specific compatible values,
and thus there was never a need to add the SoC-specific compatible
values to the driver.

For R-Car Gen2 and M3-W, the SoC-specific compatible match entries can
be removed, too, as there are a few points in time where DT
backwards-compatibility was broken for other reasons:
  - Legacy DT clock support is no longer supported since commit
    58256143cff7c2e0 ("clk: renesas: Remove R-Car Gen2 legacy DT clock
    support") in v5.5, and the addition of "renesas,rcar-gen2-msiof" to
    DTS in v4.11 predates the completion of the clock conversion in
    v4.15,
  - Legacy DT LVDS support is no longer supported since commit
    841281fe52a769fe ("drm: rcar-du: Drop LVDS device tree backward
    compatibility") in v5.18, and the addition of
    "renesas,rcar-gen3-msiof" in commit 8b51f97138ca22b6 ("arm64: dts:
    r8a7796: Use R-Car Gen 3 fallback binding for msiof nodes") in v4.11
    predates the LVDS conversion in commit 58e8ed2ee9abe718 ("arm64:
    dts: renesas: Convert to new LVDS DT bindings") in v4.20.

For R-Car H3, the SoC-specific compatible match entry cannot be removed,
as its purpose is to handle an SoC-specific quirk.

Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6f12e4fb2e2e184f..a10a2ae317c2825b 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1087,16 +1087,8 @@ static const struct sh_msiof_chipdata rcar_r8a7795_data = {
 
 static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
-	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7745",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7790",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7791",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7792",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
-	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7795",   .data = &rcar_r8a7795_data },
-	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
-- 
2.34.1


