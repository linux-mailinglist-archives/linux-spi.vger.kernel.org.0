Return-Path: <linux-spi+bounces-4272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5195CA37
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106F11F26D14
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5F185B73;
	Fri, 23 Aug 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RktEO2id"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649516DEA7;
	Fri, 23 Aug 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408060; cv=none; b=f3tB4qMbs739lepDiHrGsnNUoc+XHZoRHOOwxTxz/5EGMk0nuepJoZIvGalvsQMczPbHrHRw1IWFqyES3jbZD3XBBmlnKDhrdVvf2eDTSo25OQ8rdL11LO+F+ID/OFQfGYoJW2dIZ2xIFNAtDrCrCmKutMTA5q91Q5LAF0nRb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408060; c=relaxed/simple;
	bh=u5lw8UspajSFqGtayZeIbVel7rKthz8PEhaJjxm3L7w=;
	h=Message-ID:From:To:Cc:Subject:Date; b=eev94ohQC6vyfixKFb+hOWpfVhGpgKY0n/Up91IjRIuRiqnpEYpZg2JTd5XdvQiWGMQWYyWwyJbev/JMYRQVqEj1QzPJWdOIFKMU6BgE6d4WfAhgqEFJXt3J5F+tf7Nj3mhOeCOOJmeUAfva8uNWth2LXE8tQyeFLPl1g/rUQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RktEO2id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDADC32786;
	Fri, 23 Aug 2024 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724408059;
	bh=u5lw8UspajSFqGtayZeIbVel7rKthz8PEhaJjxm3L7w=;
	h=From:To:Cc:Subject:Date:From;
	b=RktEO2idr5o/1XLIgVXMrmqb368+rqLqe7n9sDJIkjCJUwZ5N8jWhvARk+X/2yqtZ
	 P+0zfWH9Q998CHHJ0ylQ/DLopezwsCgimB0vijMI9bqSRmu2A82y4eqHBFS5PGwwJm
	 34PQfZZuO+TnLwosALqDljRp9JGabKiq/N6gQf4R14m5FVPAXbpbJagdxe6V621Zxf
	 4R2zrfNvDTofJ1WYdZANi6+gRQUXqwwbkrOb1/mT/eYAg9+z4nJQ9a3XNE1oxC7x5h
	 S+eFDt4UO1whYU9SDv640fDL3KZoKv5xCssU+tQ64MY/fnLEVb6Mq1FMDprLEv8A6C
	 LC89y4sN21ItQ==
Message-ID: <b0ca6a6ee44947633df125a567524286.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.11-rc3
Date: Fri, 23 Aug 2024 11:13:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc3

for you to fetch changes up to e17465f78eb92ebb4be17e35d6c0584406f643a0:

  spi: pxa2xx: Move PM runtime handling to the glue drivers (2024-08-22 13:34:06 +0100)

----------------------------------------------------------------
spi: Fixes for v6.11

A small collection of fixes here, all driver specific and none of them
too serious.  For whatever reason runtime PM seems to have been causing
a bunch of issues recently.

----------------------------------------------------------------
Andy Shevchenko (2):
      spi: pxa2xx: Do not override dev->platform_data on probe
      spi: pxa2xx: Move PM runtime handling to the glue drivers

Carlos Song (1):
      spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register

Sean Anderson (1):
      spi: zynqmp-gqspi: Scale timeout by data size

Vignesh Raghavendra (1):
      spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume

 drivers/spi/spi-cadence-quadspi.c | 14 +++++++++++++-
 drivers/spi/spi-fsl-lpspi.c       | 31 +++++++++++++++++++++++++++++--
 drivers/spi/spi-pxa2xx-pci.c      | 15 ++++++++++++++-
 drivers/spi/spi-pxa2xx-platform.c | 26 +++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.c          | 20 +++-----------------
 drivers/spi/spi-pxa2xx.h          |  3 ++-
 drivers/spi/spi-zynqmp-gqspi.c    | 30 ++++++++++++++++++++++++------
 7 files changed, 106 insertions(+), 33 deletions(-)

