Return-Path: <linux-spi+bounces-8171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFEAB9D86
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19914A1465
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB5136347;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E94501A
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=pvEWf2FDulQLaj5l8pIOSDXEEeBmcP/KgDNxoGMifEVAhJdttAuOfbAzRbzrCg37ZSCzjeG3SyK9mJ/PSL9XVNxlsq0/vLzg/TWVxIRHBtqBQL13PvwFsSNDhW4ziKi9dDTX9oMZPRSNrWDR/bR47ZRMvTV+8eX/R3Odb+vUSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=/cXB1A29usrIPWaYswL8Jdkmruos7wG90yrJfDO7tVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdffNTgjwOTKH4EcmVcDFGB2E8Tax1gLTS/k9Qt4ynJIWwmyOdDGM/VBtUtyS1eUT62h2HtPaSWX30M4r3JaEXPPdI4noya8C2Ycqx25NvXGvjC6PsMUniXrKIcgLU5mo23fzi4ziu2x3JDN/9mDZPr9EveP1Xehx7fHON9gGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4ZzSgX5Cyfz4x33X
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 15:32:40 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by andre.telenet-ops.be with cmsmtp
	id ppYX2E00A3S8nz401pYXeu; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020iM-0ijn;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-00000001528-2LiP;
	Fri, 16 May 2025 15:32:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 02/22] spi: sh-msiof: Remove unneeded compatible values
Date: Fri, 16 May 2025 15:32:05 +0200
Message-ID: <d33393ac7536bc3f0f624b079f70d80dd19843db.1747401908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
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
This is a resend of a patch that never received any comments.

v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 325bd5890b78884d..15e42af35f7e4230 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1088,16 +1088,8 @@ static const struct sh_msiof_chipdata rcar_r8a7795_data = {
 
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
2.43.0


