Return-Path: <linux-spi+bounces-9919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D08B46267
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40280564EEE
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97E2737E7;
	Fri,  5 Sep 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+RW3c6A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649F17F4F6;
	Fri,  5 Sep 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097608; cv=none; b=Q6RbNLdIOOiXbw0CX4MNK6e/2e8QbRFhhQNxO43v6pqDnMIULNQA0rPIYBOwcrlEhV54Uvl7cN7pnKZe3Cv3tF54utqsvYxw21RPnA/U5UopFO5dMVzLHsK6cHgtfwGXIZrbrDnKL+YoqlOfUWxyDogjwWw9fqnnNQ25UeKTOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097608; c=relaxed/simple;
	bh=zdC1Xxv0MGGZs2WHcfLnw5QwHC2Z86h7nWo8NjWIkwc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=sUxBSYYSrAw6Y1+n5rtPXgJAlupB0cC4vXmM/3LO7ZZxH4oij+T4Qqtk8ngx43t5lJ7oqwdsFML/aI/KCKuyQrurdlZTmjs4jXnJLn2oe3azmkyj8Q/YgeeW1IyQYfuGoEDkVqLFXAbSQmZ66XbX3IYbt7v3q/HK44aDWNOl0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+RW3c6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F7C4CEF1;
	Fri,  5 Sep 2025 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097606;
	bh=zdC1Xxv0MGGZs2WHcfLnw5QwHC2Z86h7nWo8NjWIkwc=;
	h=From:To:Cc:Subject:Date:From;
	b=R+RW3c6ASZjtYebiFncf0h9NC7j8Huoj3j88zyjJ/zBB97ShTEhG77dDBBSPjx3q8
	 6QPsgZHDRC7aghODKRSEilF8sN7gjnp6QDGs6Y7WOnKMCNhIPiajSoBCC66ZiV7vYu
	 RHIZk5v636uIbMrZ8Z2YpgJSp7L898R+THe7eFU0qIjrRxReqyPtf6wOA1ojtyD0wI
	 5WoCrwhC8np2PfvbAHUte9JBosM2cgpUp9jdMMLXOkTtKjAEwDrRyCYVWfqIkY8uc6
	 AQAoH+UPizrTC9ZpnyR0cr9WjkuG61INcxPKhPBTiODEeEDajxPxMUyQ73jxG2ANZK
	 um3u6zHKDef3w==
Message-ID: <279ce5a01bec4d9c300da6709a582e21@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.17-rc3
Date: Fri, 05 Sep 2025 19:39:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc3

for you to fetch changes up to 1991a458528588ff34e98b6365362560d208710f:

  spi: spi-qpic-snand: unregister ECC engine on probe error and device remove (2025-09-03 14:49:58 +0100)

----------------------------------------------------------------
spi: Fixes for v6.17

The largest batch of fixes here is a series of fixes for the Freescale
LPSPI driver which James Clark pulled out of their BSP while looking at
support for the NXP S32G version of the controller.  The majority of
this turned out to be bug fixes that affect existing systems with the
actual S32G support being just a small quirk that would be unremarkable
by itself, the whole series has had a good amount of testing and review
and the individual patches are all pretty straightforward by themselves.

We also have a few other driver specific fixes, including a relatively
large but simple one for the Cadence QuadSPI driver.

----------------------------------------------------------------
Conor Dooley (1):
      spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback

Gabor Juhos (1):
      spi: spi-qpic-snand: unregister ECC engine on probe error and device remove

James Clark (3):
      spi: spi-fsl-lpspi: Constify devtype datas
      spi: spi-fsl-lpspi: Treat prescale_max == 0 as no erratum
      spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware

Khairul Anuar Romli (1):
      spi: cadence-quadspi: Implement refcount to handle unbind during busy

Larisa Grigore (6):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module
      dt-bindings: lpspi: Document support for S32G
      spi: spi-fsl-lpspi: Add compatible for S32G

Mark Brown (1):
      spi: spi-fsl-lpspi: Generic fixes and support for

 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |  5 +++
 drivers/spi/spi-cadence-quadspi.c                  | 33 +++++++++++++++
 drivers/spi/spi-fsl-lpspi.c                        | 47 +++++++++++++---------
 drivers/spi/spi-microchip-core-qspi.c              | 12 ------
 drivers/spi/spi-qpic-snand.c                       |  6 ++-
 5 files changed, 70 insertions(+), 33 deletions(-)

