Return-Path: <linux-spi+bounces-9587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D183B302C8
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404AC5E85B4
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF5346A1E;
	Thu, 21 Aug 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNOLn0wR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168A3451D8;
	Thu, 21 Aug 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804091; cv=none; b=o9EKL407w7ZBUFe2BF6/0j9t4tbv1tbuI0FytfayS6QdpBqrJyfb1aa8DlRGd0swh/OhdF9ooA3D2lunmME7Mup6+1B1gUecL3es39ha+NWA+rEblwBTrPTNeEtXiP2B7OqbCxPKBHnrT9caLEiGfCd+VmKuPAEdL0sb5JGWUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804091; c=relaxed/simple;
	bh=pqMWhXabVVr7GDT84VaN0dAMqcMxMqYZumqAB5XIQTY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SU3TehYwkxa7s+D75CHO8ku3mN+9DRr4RjR1cGerMELNC4M2DP44XEjFSTPfl9+SyJ4UvrudIWHKqguBeaCqjOgDwyHTOdDc9ILJkP3W0KoaijNOgIm3nC3lkyqkypShP2dt075F3R3jut4O8DUtDGeeUoIP0PeAU+TLWmySMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNOLn0wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41088C4CEEB;
	Thu, 21 Aug 2025 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755804091;
	bh=pqMWhXabVVr7GDT84VaN0dAMqcMxMqYZumqAB5XIQTY=;
	h=From:To:Cc:Subject:Date:From;
	b=jNOLn0wRorVogxwgA70h/waSk3E6FrZO6IeX9S9TuzklGNf5rZ9redHsR6kcyyaVO
	 GTTa3CMOwNXXmTNBnIMgr3urwrDi2qas/BrdlKKWVnh/sWQc7vwtS42QPYmF54QQnV
	 k1OJBTCuI9H42mmeDDk4UkTDGkiD16gZZLeJ9WAgrzWNQJHMd3fkHn9TKPvvkP56nx
	 X35w1lj53d1pgxZcmDYj5TfnsQalPWC36J7kDymEQdiDTM3pfn+39C4l9B+3mKdCIP
	 FB0NWrZuyjBR1JkPVEmIUkPV3JZ/hOjHQB4Gbp445QXh76ZonQi+UnwY+NwNTV9zbK
	 u15q9NDStIGhQ==
Message-ID: <df4a6a9145a7c42a25af15e9dff7fef9.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.17-rc2
Date: Thu, 21 Aug 2025 20:21:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667:

  spi: cs42l43: Property entry should be a null-terminated array (2025-08-01 14:36:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-rc2

for you to fetch changes up to 7c7cda81159b1abe7d50bcef2ccc6f662e225c8b:

  spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP (2025-08-21 13:14:10 +0100)

----------------------------------------------------------------
spi: Fixes for v6.17

A small collection of fixes that came in during the past week, a few
driver specifics plus one fix for the spi-mem core where we weren't
taking account of the frequency capabilities of the system when
determining if it can support an operation.

----------------------------------------------------------------
Gabor Juhos (2):
      spi: spi-qpic-snand: use correct CW_PER_PAGE value for OOB write
      spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties

Miquel Raynal (1):
      spi: spi-mem: Add missing kdoc argument

Raphael Gallais-Pou (1):
      spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Clamp too high speed_hz

Tianyu Xu (1):
      spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()

 drivers/spi/spi-fsl-lpspi.c  |  8 +++-----
 drivers/spi/spi-mem.c        |  4 ++++
 drivers/spi/spi-qpic-snand.c | 22 +++++++++++++++-------
 drivers/spi/spi-st-ssc4.c    | 10 +++++-----
 4 files changed, 27 insertions(+), 17 deletions(-)

