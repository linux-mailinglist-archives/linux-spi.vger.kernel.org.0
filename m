Return-Path: <linux-spi+bounces-2806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0E8C2412
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF18C1C20DA6
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E316E87D;
	Fri, 10 May 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Are0CCm4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95A16DED7;
	Fri, 10 May 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342315; cv=none; b=TiR8PKSVsZQcs3I3+vX1FlRYpz9X6eMgFVach810CEP/aotqqpPAElqoAhZV0MAI81qHNn8uY/jD3N8uNLMJBWrHTwscAyFr1sGzhxgbXDezHsSJ/2iLyBZ0+ycKL66l5mRrefbCtI0TzRKu44H3fsZ+X7Schc2jUmxQ4HX7mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342315; c=relaxed/simple;
	bh=w1n9f5zQ5v+scTfOQWdmcNEIJEkb7jEiVN5I/WVfYso=;
	h=Message-ID:From:To:Cc:Subject:Date; b=aFNa2DqrQP35vUW1RkQ5uro0p4CQu6gHpIF9gAfNST+NLFNpvyq5//f+Al8QInk1ZgwfgmDaXfuCI8EU/uehekVTbQXKFoKxa/JW775z4rGh9jLhCHMdeG2/l6sKf39Z/JbrhDRebd9SHmxtKeTRq6wFmaDJ8DeQzPRB0A2F8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Are0CCm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EA0C2BBFC;
	Fri, 10 May 2024 11:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715342315;
	bh=w1n9f5zQ5v+scTfOQWdmcNEIJEkb7jEiVN5I/WVfYso=;
	h=From:To:Cc:Subject:Date:From;
	b=Are0CCm4YtKsAswCho792G2n/Vn9YCo0MwAI7O1FTVlvtkuO/HDl9JHtjGrDHuaHf
	 ZgVfxXw6aWH5dNjJHIuODOJxjTdqL8X1IvCkfBW+qdVeDCKhTgxgkBlFBnqhT1wBx6
	 XUjlvJQW4AtjrWAJ0ppxR7ZO+5jZglKcKUyo9VtNONMXjN7qFgLcv42tcojXEMyV5C
	 cg39gL6o+z1hbTPCjqyGYYIRZOhevFmktTnbJ5oCG4X83m2XeXVJCYSaFaHuSjnib5
	 Mdk7Sf9xxHEkCQhSnPZPBVcSpZ5HhZ0aoVTpJohrlMWdr8J6BRDVcrM1LE8auEPc0+
	 ZAVgdJR+yIIYg==
Message-ID: <275b918bbf12753d81537f9697615900.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.9-rc7
Date: Fri, 10 May 2024 12:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 4756fa529b2f12b7cb8f21fe229b0f6f47190829:

  spi: fix null pointer dereference within spi_sync (2024-05-01 11:02:48 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc7

for you to fetch changes up to ef13561d2b163ac0ae6befa53bca58a26dc3320b:

  spi: microchip-core-qspi: fix setting spi bus clock rate (2024-05-09 06:59:19 +0200)

----------------------------------------------------------------
spi: Fixes for v6.9

Two device specific fixes here, one avoiding glitches on chip select
with the STM32 driver and one for incorrectly configured clocks on the
Microchip QSPI controller.

----------------------------------------------------------------
Ben Wolsieffer (1):
      spi: stm32: enable controller before asserting CS

Conor Dooley (1):
      spi: microchip-core-qspi: fix setting spi bus clock rate

 drivers/spi/spi-microchip-core-qspi.c |  1 +
 drivers/spi/spi-stm32.c               | 14 ++------------
 2 files changed, 3 insertions(+), 12 deletions(-)

