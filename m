Return-Path: <linux-spi+bounces-3180-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A98D677F
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1211F272FA
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975516FF26;
	Fri, 31 May 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg5hW8D5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292815CD7F;
	Fri, 31 May 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174567; cv=none; b=JrllN3mqFCMDNI+t4cTyAGPbIAmaHUuv47ZhwM2mYe835UI8hHVMCMCt2nwKCUTuabfD7os5cpoz6gBkWBgtaE723rSiE72iP8bQTaTQuqhTBgGAef/FFJIlCr59P0gl7/j/ZeeE/6hw/VwKLRoN+Jz+En/EgB3OAlm4keagvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174567; c=relaxed/simple;
	bh=WUvmVdpJgJRxIaSCRIfJr52zfPAGi08QjQmVCOZydiE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=KOmFTuCb2HnrRhSEBTWxzoUOqYOHxSNDzF7Xmgv2Bfe77d5kGsSED5WNchCBD6eNf3aVIyQ5/gC+WT0lbbLyNhchLw4aaA9HEPBsf2SWr1yNlI7XTr+0iUNpUHsO57zTnNUyB1RWo0joBP0tCsG7xglzUV26StaZV1uhg0sZzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg5hW8D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E7C116B1;
	Fri, 31 May 2024 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174566;
	bh=WUvmVdpJgJRxIaSCRIfJr52zfPAGi08QjQmVCOZydiE=;
	h=From:To:Cc:Subject:Date:From;
	b=Yg5hW8D5kWN2vVcj1mQ5dwY2nTsIcg8Fgevp0WahsMiOfZnKkL/OS6PYdPLPjSOHo
	 hWnZpbo3BZ2/PRul/A1BnGDyZhL0Ymzb9WoQaxevwq2FgoEXo/UT3QGNY3T0+vizbd
	 o5RaMo+Pzw7/411mvYcdciTMfInw4IEhTIii61RHtVTv3XSHxgsim36vnbJEH0LNrI
	 Y2nfZjusX5pCdxpJb+FwA1sbiKQV1l9WWADM3wPZsDnegoLzUK8pJ4kqCMgIyViWlj
	 6nclj5tMosEXJsKTaekkNAisfYHpnmWKoGiiqG7NbXkyLkw591m+8nQH4qJfHcMm2O
	 OfJW5uuWCsjaw==
Message-ID: <a606dc99619c387713bc312d3222c98f.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.10-rc1
Date: Fri, 31 May 2024 17:55:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit d6e7ffd4820f8894eb865890c96852085d3640e1:

  spi: dw: Bail out early on unsupported target mode (2024-05-09 17:48:06 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc1

for you to fetch changes up to 95d7c452a26564ef0c427f2806761b857106d8c4:

  spi: stm32: Don't warn about spurious interrupts (2024-05-29 19:12:09 +0100)

----------------------------------------------------------------
spi: Fixes for v6.10

A series of fixes that came in since the merge window, the main thing
being the fixes Andy did for DMA sync where we were calling into the DMA
API in suprising ways and causing issues as a result, the main thing
being confusing the IOMMU code.

We've also got some fairly important fixes for the stm32 driver, it
supports a wide range of hardware and some optimisations that were done
recently have broken on some systems, and a fix to prevent glitched
signals on the bus in the cadence driver.

----------------------------------------------------------------
Andy Shevchenko (3):
      spi: Don't mark message DMA mapped when no transfer in it is
      spi: Check if transfer is mapped before calling DMA sync APIs
      spi: Assign dummy scatterlist to unidirectional transfers

Mark Brown (1):
      soi: Don't call DMA sync API when not needed

Uwe Kleine-König (2):
      spi: stm32: Revert change that enabled controller before asserting CS
      spi: stm32: Don't warn about spurious interrupts

Witold Sadowski (1):
      spi: cadence: Ensure data lines set to low during dummy-cycle period

 drivers/spi/spi-axi-spi-engine.c      |  2 +-
 drivers/spi/spi-cadence-xspi.c        | 20 +++++++++++++++-----
 drivers/spi/spi-hisi-kunpeng.c        |  2 --
 drivers/spi/spi-microchip-core-qspi.c |  1 +
 drivers/spi/spi-stm32.c               |  2 +-
 drivers/spi/spi.c                     | 32 +++++++++++++++++++++++++++-----
 6 files changed, 45 insertions(+), 14 deletions(-)

