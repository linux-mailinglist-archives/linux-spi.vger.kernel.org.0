Return-Path: <linux-spi+bounces-11857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD8CB45DF
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 01:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3663009418
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05821D599;
	Thu, 11 Dec 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTWOlb2V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DF1B4244;
	Thu, 11 Dec 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765414157; cv=none; b=qLkkBSwxW75Njhopx3G9JvIKlmy4EQ7YNHFGH75S4EzCxFNqwCl5q/54HvEs363tkL0IY/7ttH+4+h5FB+m/WxGftsYH9OuhUbcXvrL55F8A9VjMf8wptjKV7/DmJy4QsP1o7tvTHgI8JTybCfm8HWpAlbg6E9+ibE+26v0R+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765414157; c=relaxed/simple;
	bh=nLKca+NPoQZLf8cfFiJ6NzpJzla+3ro2s9OSsgKLC9k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J6RZg+VFl02+8wyL8rMG0X/URz5xDsBrfOvN8PGw2+/t6x4MIQkindacSVfpniBKTK0SXcWNXPaYkJoTc2oP1f5vPr22uM1rcQnLcpd3I59WOVxaZze/h+/XHDCU4RqzgHb9agX6+s0u8muH82RR2daDc/4imst6uUcJcTPLZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTWOlb2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D9DC4CEF1;
	Thu, 11 Dec 2025 00:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765414157;
	bh=nLKca+NPoQZLf8cfFiJ6NzpJzla+3ro2s9OSsgKLC9k=;
	h=From:To:Cc:Subject:Date:From;
	b=JTWOlb2Va12P+2C9+APitH+qbY/cC7UZ9VxQOQWDeaKOkk7uw4fs+9fWqTBfYuO7B
	 srnGOtzNvRHlr7Vb647RIfoYRJpkU9hKj/zspinuWXYZe+gH4nGl7w4Xoooumd7wm4
	 ROiuUKNNR/lU+c2T3Wf4jY0nn5X/AGdkVAmmUuOFQpN19mbNrXIljtRMAbQn2/ua1v
	 AXrWJlIGs7DA7jSr121ASQOLJxx40ABGfrfvnqiQy6JRfoRCfJONOED7DBrpn47si5
	 1K+DCiB21fgUMxRifLdqgGPDko3ZHAWbVQlCbSNFwten1u0hjYHf20rXXEl5o7I7qD
	 DbQ89lyWxJhLw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 47AD71ACB974; Thu, 11 Dec 2025 00:49:15 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.19-merge-window
Date: Thu, 11 Dec 2025 09:49:09 +0900
Message-Id: <20251211004915.47AD71ACB974@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit cb5c2eb459f4c98d584eaf3d3ea7c3612385d081:

  spi: microchip-core: Refactor FIFO read and write handlers (2025-11-28 18:03:43 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-merge-window

for you to fetch changes up to 8cef9b451dc6fdf86b92c7a35d55a47465d500db:

  spi: microchip-core: Fix an error handling path in mchp_corespi_probe() (2025-12-09 10:01:32 +0900)

----------------------------------------------------------------
spi: Fixes for v6.19

A few small fixes for SPI that came in during the merge window, nothing
too exciting here.

----------------------------------------------------------------
Ali Tariq (1):
      spi: cadence-qspi: Fix runtime PM imbalance in probe

Christophe JAILLET (1):
      spi: microchip-core: Fix an error handling path in mchp_corespi_probe()

 drivers/spi/spi-cadence-quadspi.c    | 1 -
 drivers/spi/spi-microchip-core-spi.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

