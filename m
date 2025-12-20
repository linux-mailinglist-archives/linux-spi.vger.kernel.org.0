Return-Path: <linux-spi+bounces-12061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A7CD38A2
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 23:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21FC33007DB6
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FB2F747D;
	Sat, 20 Dec 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+wu+UMQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78323EA99;
	Sat, 20 Dec 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766271497; cv=none; b=CGuADan8vvcYcVp3VzDwdnxfEb9IcqZlgXm9W3D+eySxbEfOpPYVBFRKJj9K7UXXZ2ZDr4x54PY7C6V2ffIa4q8WEzILsBi2tuSdyian2QVsS62lHsDpihYjsja5dVvNGZzpzrahiWJ+DJ2VfPvWAMGY2CK5blqOPVtvjMK4qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766271497; c=relaxed/simple;
	bh=cXR6zSzmlZeYEl/EqxOLr5BkxApHfSL700FWSxz0tVE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Hp3XhkT6WUHcANfXwBRMrNMFu8Yd0wcU7Qdc/7Xmrf0lIK+z/Yz7mFeA3Yx+FE7UVC7JAidjDuIL/Q1RHp2x2isMaPAaIsW7LYL827ZOCgWxEXjaEbYKU1dHSBsxMpLNOsRB96ynN0DAfrF/D6+Hnfk3qylRMuf6GownkpQjSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+wu+UMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E0AC4CEF5;
	Sat, 20 Dec 2025 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766271496;
	bh=cXR6zSzmlZeYEl/EqxOLr5BkxApHfSL700FWSxz0tVE=;
	h=From:To:Cc:Subject:Date:From;
	b=K+wu+UMQyBUmaFvDIQztYVh/lF1k1U7KmqGTS+pXPkzzPmtCXDdi+WNBPQCxsSnbM
	 0vPHCURamd8MHRl342hNJHUsIBFfnYSTxpqFqF6Czc0KEPQLnycwIfX/uzSgn9T4sc
	 cJa3dphkFtEbakfbH+lg4W9Z1Qx/B1EiVx0kfaxhx8lsRLZOUD+dvHpmPLKMwgMYoc
	 UiFy1lXY3xlNriDRICSYPK1WFAY0iUmFZdtfZJQHMoQ+GTE7EWyzVhVgO8PpLAbHF+
	 od/pjRd1r76uf6WWD/e4b0SwbIzGEYr6HwM8h+dk1Fg41PZpbw0iDxkg9COPRindKI
	 NwozJj4ZUSZrQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4BEE51AC56B2; Sun, 21 Dec 2025 07:58:12 +0900 (JST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.19-rc1
Date: Sat, 20 Dec 2025 22:58:07 +0000
Message-Id: <20251220225812.4BEE51AC56B2@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc1

for you to fetch changes up to 9d651a6c62832ac8d1c445f5fa8c61a03ebfb649:

  spi: cadence-quadspi: Fix probe error path and logging (2025-12-18 08:34:00 +0000)

----------------------------------------------------------------
spi: Fixes for v6.19

A small collection of fixes for various SPI drivers, plus a relaxation
of constraints in the DT for the DesignWare controller to reflect
hardware that's been seen.  There's several fixes for the Cadence
QuadSPI driver since a fix during the last release made some existing
issues with error handling during probe more readily visible.

----------------------------------------------------------------
Anurag Dutta (2):
      spi: cadence-quadspi: Add error logging for DMA request failure
      spi: cadence-quadspi: Fix clock disable on probe failure path

Christophe JAILLET (1):
      spi: mpfs: Fix an error handling path in mpfs_spi_probe()

Christophe Leroy (1):
      spi: fsl-cpm: Check length parity before switching to 16 bit mode

Fei Shao (1):
      spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ

Mark Brown (1):
      spi: cadence-quadspi: Fix probe error path and logging

Rob Herring (Arm) (1):
      spi: dt-bindings: snps,dw-abp-ssi: Allow up to 16 chip-selects

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 +++---
 drivers/spi/spi-cadence-quadspi.c                          | 8 ++++++--
 drivers/spi/spi-fsl-spi.c                                  | 2 +-
 drivers/spi/spi-mpfs.c                                     | 1 +
 drivers/spi/spi-mt65xx.c                                   | 2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

