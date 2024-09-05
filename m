Return-Path: <linux-spi+bounces-4696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7696E59F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE61C2372E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 22:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF161990CD;
	Thu,  5 Sep 2024 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV7XQ44L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759414B95F;
	Thu,  5 Sep 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574188; cv=none; b=VLmiNuDvr6xsVF7jKT6Ncd44yu08F7uOhI6KjCrbs4aN6qPB46r7xUrejpCXwslabQKG5c0geWDjxGCQHmx9gIwUeSnJpE3IC/4Rab4phxn9qMfAlWgTlcVRCWQZGNWeRTWrI8ydbPsyHzJXmc7ozwGCW0/f24KtjF+ke3fa2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574188; c=relaxed/simple;
	bh=W7RYC1UyTeShUPnorjAlQ0QxnVv33EgdClbd0o4c4cM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=I5hq4c4EPZVkszazHYLxEBsxosLFmGBvUYhfGo2buq5dXAZ0hGi7GBClBbxPzO8iJZvIXK2+VIYoLAgJjxTcAW6KoAz/uf6lMez9dTV6jRt8A8wgw6OUg3a0PfgRnUXFw53FyoV8hOC/R4etuNFuPmcW14zwSg0phasygprB1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV7XQ44L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F78C4CEC3;
	Thu,  5 Sep 2024 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574187;
	bh=W7RYC1UyTeShUPnorjAlQ0QxnVv33EgdClbd0o4c4cM=;
	h=From:To:Cc:Subject:Date:From;
	b=pV7XQ44L7t36TyEhhrQVxT1myuRoT4DSkjG4E+HETDBv/V0f6IsvGCEeyf8xpYLTS
	 Ap04fdumIPuDvJpV77c7ROzSRbqYu+No1hlndHQa72UPZ0egVWvQJQZ33+pI7C1ZBP
	 vDD8OyrFc67xFCyK5elvlg/B6V4uEncfKcWOwbgKe8f/7pXtE3CLY9w4PwahofgsGW
	 U/Asolrr/GJDVeIxd+53HDUgeaTuLx2dfUNaSp6Q4G4moMM4c2CYazbWwEFnzmDtI/
	 8PJ4gYII/0dYCSnPskKtsoZZsKNkBSxPJSxnTvVZ3TkyrDU1SRAPf4qnc2uscB7y24
	 lYPODypRxkg0w==
Message-ID: <7f8f5f4771bfeba33bb62b2f6b60c254.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.11-rc6
Date: Thu, 05 Sep 2024 23:09:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc6

for you to fetch changes up to c9ca76e8239810ccb08825a7b847c39d367410a6:

  MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers (2024-09-05 19:15:45 +0100)

----------------------------------------------------------------
spi: Fixes for v6.11

A few small driver specific fixes (including some of the widespread work
on fixing missing ID tables for module autoloading and the revert of
some problematic PM work in spi-rockchip), some improvements to the
MAINTAINERS information for the NXP drivers and the addition of a new
device ID to spidev.

----------------------------------------------------------------
Brian Norris (1):
      spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Charles Han (1):
      spi: intel: Add check devm_kasprintf() returned value

Fabio Estevam (1):
      spi: spidev: Add an entry for elgin,jg10309-01

Frank Li (2):
      MAINTAINERS: SPI: Add freescale lpspi maintainer information
      MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for jg10309-01

Liao Chen (1):
      spi: bcm63xx: Enable module autoloading

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix off-by-one in prescale max

 MAINTAINERS                 | 11 +++++++++++
 drivers/spi/spi-bcm63xx.c   |  1 +
 drivers/spi/spi-fsl-lpspi.c |  4 ++--
 drivers/spi/spi-intel.c     |  3 +++
 drivers/spi/spi-rockchip.c  | 23 +++++++----------------
 drivers/spi/spidev.c        |  2 ++
 6 files changed, 26 insertions(+), 18 deletions(-)

