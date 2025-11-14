Return-Path: <linux-spi+bounces-11215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A6C5DA85
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC793B5AAE
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1A32694F;
	Fri, 14 Nov 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INOOvdRz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA5325732;
	Fri, 14 Nov 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131393; cv=none; b=rwAeykab3/qSygNIH/g0+ZCzU+nRaAMDkJbzcV6gvSqfNvuiUQpm9klfnK9S1TkPBLaFAWSMMLBbq9U658qNxR4KCuEnjcx2hrSLip0sAp9Fly4Az164Lz+oSF+hqqF3mHEC8Tp9PPGCDRgu6jZqDELafSrjt9NWiMxSah84qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131393; c=relaxed/simple;
	bh=T0dTODCoA5+VBMpv+FGrbC6oYlQX+mrG/AORN8XJJfg=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ng5GDmhhHEFt/cNWvoQ7eyCP+6c4+YpgNens8MZYtlQR0vEJnki453pXWvSjKhldgEyFxAsCL0Tcyy+YGF2mIsrTVDdmRrFI70G1OAvZ14zI30USoR6S/NWgVJgIBdPiV2z/gaSHLbrroFKPRWKR1fODFRDHBUPfAghjd51U5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INOOvdRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA25DC4CEF8;
	Fri, 14 Nov 2025 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763131393;
	bh=T0dTODCoA5+VBMpv+FGrbC6oYlQX+mrG/AORN8XJJfg=;
	h=From:To:Cc:Subject:Date:From;
	b=INOOvdRz9Pm/HoBJXDoziw9PyggMSKXL3AWuamKCqqS7/ju2klcyl6PPTe5oU6SfS
	 1hBLYO0rBXgRlv1e1ce9GGmT86X9Gu+ZBZQL6qbKOSBwNYK9uF1QY38bHRZGNrJOj1
	 oggJ+m6/U2ob4ifdX34kQ5sFeZc1kX1ngjEY25mUdBLhz7jFEK5GTslYVXxUUZUGJ7
	 wucdXKFzPkyA9FiP9BcbJCmpL3XZ4/8pQ9vRdq7Ou8fVjqXn4Hj9c5Qvqcra5Fn+bo
	 BIEwlKqA+4vN1sDC48kirK82BK9G5TbKEwv+qXR/TGikpSY1y4u6oE5L9u9XAjob3X
	 rXPazXntnyqog==
Message-ID: <fb5ead855a2851d4068598461ca74593@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.18-rc5
Date: Fri, 14 Nov 2025 14:43:01 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc5

for you to fetch changes up to 66e9feb03e7cf8983b1d0c540e2dad90d5146d48:

  spi: Add TODO comment about ACPI GPIO setup (2025-11-10 14:03:53 +0000)

----------------------------------------------------------------
spi: Fixes for v6.18

A few standard fixes here, plus one more interesting one from Hans which
addresses an issue where a move in when we requested GPIOs on ACPI
systems caused us to stop doing pinmuxing and leave things floating that
we'd really rather not have floating.

----------------------------------------------------------------
Alvaro Gamez Machado (1):
      spi: xilinx: increase number of retries before declaring stall

Hans de Goede (2):
      spi: Try to get ACPI GPIO IRQ earlier
      spi: Add TODO comment about ACPI GPIO setup

Robin Gong (1):
      spi: imx: keep dma request disabled before dma transfer setup

 drivers/spi/spi-imx.c    | 15 +++++++++++----
 drivers/spi/spi-xilinx.c |  2 +-
 drivers/spi/spi.c        | 12 ++++++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

