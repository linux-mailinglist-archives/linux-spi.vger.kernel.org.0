Return-Path: <linux-spi+bounces-9192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC1B12CA6
	for <lists+linux-spi@lfdr.de>; Sat, 26 Jul 2025 23:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AEA5425DA
	for <lists+linux-spi@lfdr.de>; Sat, 26 Jul 2025 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BAE19F135;
	Sat, 26 Jul 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5X/MBRF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06E1401B;
	Sat, 26 Jul 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753565887; cv=none; b=Zgzi7aI0q0CxiOyDCElnR18SaSi2EL4UeP8cuCqShzQq1qq1e/fUBftRSQ6ZEmH79iJgQKaoe1hOS+3a1H0QuVX2xQcc0jiEi/rrexR6khQYnB9xhIHbanx9mNKm/CBcjDDE9A2/7FV/RLU0nmMZAtzKQYLYeCcw0yyvb/heypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753565887; c=relaxed/simple;
	bh=98GHAVEf2WRxlSwrC3lF+z3VnyUMJjTHblcbiixYtUQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=eYdwp0J+qk0fzEDZVVZhl5gNkv+NGiUJ4T+uh+Z8HrfuWkjJPROFHvvvp+NfSpZjMAMQmLgWBgvraHgUlS3JiAG/xTyC/sOMPQGHaRyWc99vlnuKE19envdDpHM2RzfVKpF+a3kY8Fa102pZma+6NIHK0cEZfY4esVqPzKqqGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5X/MBRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC25C4CEED;
	Sat, 26 Jul 2025 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753565887;
	bh=98GHAVEf2WRxlSwrC3lF+z3VnyUMJjTHblcbiixYtUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=l5X/MBRFRMAj2xTMBS1DVdiFFFkEekJ4RrEeWojWPuonABuwaK1Ei5MMZyHZEEO3i
	 HqG3Ju80QLxE2jqK6SOCP/6Zzs525TSuFB6iHTi6OsJNqHeEubP0gChVcCJj2IFrO8
	 r7c70komj+7oNsUrkvf6MWmHd/gNhsRMozxf6+eTwBXkp+TTEgDEGTAAEdfx48dHA+
	 qQWYUq/d2dbFx+C6NLjVC+VpqS/B3YULd2xy5riLiIDmHgkPVOtS2mGFXiu63awRC8
	 YWW4fQxMXjYK6uTL+cbMTGeLR2d/qZmElhr7NcmPJzQuYO6sgF5ogJewiZumuFlJzE
	 Qjkub+JOKfy8g==
Message-ID: <7ab95b9a2a3ad939ab24c1c8c4175096.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc7
Date: Sat, 26 Jul 2025 22:37:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 710505212e3272396394f8cf78e3ddfd05df3f22:

  spi: Add check for 8-bit transfer with 8 IO mode support (2025-07-14 14:44:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc7

for you to fetch changes up to f820034864dd463cdcd2bebe7940f2eca0eb4223:

  spi: spi-qpic-snand: don't hardcode ECC steps (2025-07-23 13:04:03 +0100)

----------------------------------------------------------------
spi: Fix for v6.16

One last fix for v6.16, removing some hard coding to avoid data
corruption on some NAND devices in the QPIC driver.

----------------------------------------------------------------
Gabor Juhos (1):
      spi: spi-qpic-snand: don't hardcode ECC steps

 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

