Return-Path: <linux-spi+bounces-9051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AEEAF965A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9307B9C56
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF012BE7A0;
	Fri,  4 Jul 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3NL+i4G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425628B518;
	Fri,  4 Jul 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641641; cv=none; b=LzYPgkVXfNvywpZd3BftTv65pLWNKi59maxj/1LcexxxtyKQtwyL/6xNZSwFd7tiSVflkCrqKeJwu2Oj7KFpfp5ClKP2Lq1o2r1jyiJAEu+EGEqjCTl96AFSSvY1PJxtlCSMsEIhJ9hdsYNHgoVbNs0gAKBQ/UXlpguGa2p9r/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641641; c=relaxed/simple;
	bh=ukAKM+xwwkXTirgfsAR9KlRjq4Dana8wYKEmQtIvP+M=;
	h=Message-ID:From:To:Cc:Subject:Date; b=udLojf3OzQdddegc7wcoRhsdtx0ppVIYc7e4akEu8ySU/qy9SgTpGnOtNlZMi4lIzF6n8eHgxAZsh3kuXFiF3BSFjGwyyWT79x+rKVuxT8Dv35TJ7cZmDjU19EgInsHZH+4pKKSGx61VG6XHKBkShamfMEjSCTmOUsa5mNP6ITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3NL+i4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9DC4CEE3;
	Fri,  4 Jul 2025 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751641640;
	bh=ukAKM+xwwkXTirgfsAR9KlRjq4Dana8wYKEmQtIvP+M=;
	h=From:To:Cc:Subject:Date:From;
	b=V3NL+i4GmB9apvk5ImKEDzSexSxvO9Ww7reKcyEANXPTnuEsnc9gvq1O6kvsAPewo
	 8F+MubXRj76muDnts9ipiVeB/r0W9L31kgxAFOpO25zfi6ZQUyVQHMvakqDOw4D2Tl
	 3nAADeTfjtkhVW0k6zjICuBBsBmgsk+WHt19ohZOUuxNwL2O2jynqzNmn1yaNNNuth
	 jTodiUiCNUpr22SMoR2CK1lGCM1nAz25Ya5eARV+rxBBeAyvp+qq3DYUyG4uQvohxc
	 ccnxcMGwdtciqKnB3WvnAQhVvUQ1hSuNV7GuU2itlKUtRxHSq3KvwN+7cDtFpIs7zK
	 0Vc43Q7/xUynA==
Message-ID: <36262b502dd08b5d5c602f7c7a1d6449.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc4
Date: Fri, 04 Jul 2025 16:07:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc4

for you to fetch changes up to 04a8ff1bc3514808481ddebd454342ad902a3f60:

  spi: cadence-quadspi: fix cleanup of rx_chan on failure paths (2025-07-01 14:02:26 +0100)

----------------------------------------------------------------
spi: Fixes for v6.16

As well as a few driver specific fixes we've got a core change here
which raises the hard coded limit on the number of devices we can
support on one SPI bus since some FPGA based systems are running into
the existing limit.  This is not a good solution but it's one suitable
for this point in the release cycle, we should dynamically size the
relevant data structures which I hope will happen in the next couple of
merge windows.

We also pull in a MTD fix for the Qualcomm SNAND driver, the two fixes
cover the same issue and merging them together minimises bisection
issues.

----------------------------------------------------------------
Gabor Juhos (2):
      spi: spi-qpic-snand: reallocate BAM transactions
      mtd: nand: qpic_common: prevent out of bounds access of BAM arrays

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Khairul Anuar Romli (1):
      spi: cadence-quadspi: fix cleanup of rx_chan on failure paths

Marc Kleine-Budde (1):
      spi: Raise limit on number of chip selects to 24

Mark Brown (1):
      spi: spi-qpic-snand: avoid memory corruption

 drivers/mtd/nand/qpic_common.c       | 30 ++++++++++++++++++++++++++----
 drivers/spi/spi-cadence-quadspi.c    |  5 -----
 drivers/spi/spi-fsl-dspi.c           | 11 ++++++++++-
 drivers/spi/spi-qpic-snand.c         | 16 ++++++++++++++++
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 include/linux/spi/spi.h              |  2 +-
 6 files changed, 61 insertions(+), 11 deletions(-)

