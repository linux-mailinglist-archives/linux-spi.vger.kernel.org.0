Return-Path: <linux-spi+bounces-7938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E74AACD63
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3654A7AB3
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFC28643B;
	Tue,  6 May 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXyl2JuC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CB1D5ADC;
	Tue,  6 May 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556626; cv=none; b=PWZ6KXT1cynquRER573sMLF6U7EOHx0GFzBLiy8+6srp3sc5LPWZUawdWmdoWuIO3DS/jF33a6QLb6EzWmRLL7yrX47pj9HDMV3J9YCkG8fGgskxRXAFITp/ahSbwuditLJ/ZJEYSqBmufb9JQ633Aor64Q6eLokfQAGWxYlAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556626; c=relaxed/simple;
	bh=VPN3CYOPSJElSKB5YL3erOKXcLAZVNE6IXlCcyuNueA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S+2kwQ0vgokAIfKSDvsPsuOQvNF1V+/rwi7A1/3g+m1yj9I3Gy4LJtEEjlQ0KZNGMS5LeUcLA1gCd8JeD5mQeAq4PLAKJInVOZlSM7XdRuBNEK3qvCFHgJ+hHPZkWTdRs699jtW8zc+38kvArZc13zP9/mIyFNjeo3WwUOPNT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXyl2JuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A84BC4CEEF;
	Tue,  6 May 2025 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746556625;
	bh=VPN3CYOPSJElSKB5YL3erOKXcLAZVNE6IXlCcyuNueA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZXyl2JuCaoRm/k8vqvz+FWYtutFwBh+AeejLzveDiEUxSU10Qz3UrDLGDO1Y7Bw4s
	 EnEJOTcvCIKiUhyh6aaiPQAtPGdUuT7ouS0I4YBocz2RjeI8PK6MeC0y6vtUAFRAGV
	 g1gHr142uHDKu6GW30Pq5ifvdgD/35AuAmHjbeD9c/uLY3l8+P0PMw9skkF9/VoWyC
	 x7JCxyGr07t8zuLTtYukmU80KRPPAxlbAPstmo7ihvUH3soNvGU5bkgWKr6vxxDbKR
	 p/D8gSYGyMhyLo+VZCyaWLYsin2SDj0flVcYRKK331TJAHE6bc1MQBx/F5zSAITqUt
	 4I/OZfOWjLzKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B961C3ABBC;
	Tue,  6 May 2025 18:37:05 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 06 May 2025 13:36:59 -0500
Subject: [PATCH] spi: tegra114: Use value to check for invalid delays
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMtWGmgC/x2MQQ5AMBAAv9Ls2SbbohVfEQd0sReaFpGIv2scJ
 5OZBxJH4QSteiDyJUn2LYMuFEzrsC2M4jODIVNTTRZTEDx4iYPWFc5ynwH9OFtXkh+pcZDDEDm
 Lf9r17/sBsguP3GQAAAA=
X-Change-ID: 20250506-spi-tegra114-fixup-dbf6730db087
To: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746556624; l=1451;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Hw03YaXk/WZ6EX96VNFe6W5UJoy0p3RB6GhwI2lDOas=;
 b=CEGKjV7XRxmWJqtCmKGXcQ1HRrEygIotyDIVa2P8UldIcnnCCRRgM51WuUQ6TYSNQoHyZ0ZnP
 mzcTFoaFAUQCEtiHeb0NckUCgy8uofM8thOYzVHLVLhG2C2EQN9sG7r
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

A delay unit of 0 is a valid entry, thus it is not valid to check for
unused delays. Instead, check the value field; if that is zero, the
given delay is unset.

Fixes: 4426e6b4ecf6 ("spi: tegra114: Don't fail set_cs_timing when delays are zero")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 2a8bb798e95b954fe573f1c50445ed2e7fcbfd78..795a8482c2c700c3768bd50bf59971256893a486 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+	if ((setup->value && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->value && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->value && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);

---
base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
change-id: 20250506-spi-tegra114-fixup-dbf6730db087

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



