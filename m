Return-Path: <linux-spi+bounces-9325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECEB1ED8E
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80018167A6C
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6213A267F48;
	Fri,  8 Aug 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP/OrV+m"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7477082F;
	Fri,  8 Aug 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672562; cv=none; b=fVmPtPcil95/5BhO/VZN8cN8HezvlYdO+1vsvr9IpD/5bkHU9ViP+mFK2lHC+M8ERBFG0Ek5ArR1USkwgdzPoCScHIWRAF3rPrek0E6Ze6HYhH4ZZZgjjH00HBmC3/yLonH2RSbJn9MtlusZqAF+7P4MD/8CEDTcuHhmPl8c7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672562; c=relaxed/simple;
	bh=1lNnensga6TBPtqVjWcxWn53peNC+SIAsK+aDfwbj3Q=;
	h=Message-ID:From:To:Cc:Subject:Date; b=f3ZvFBZcqobU3lBSwS/GxWqheQdMzUux25SOYu8sV6BgddB39hs6rdrvsmRFhXG/nPblqrqyPNPWLyLlMgiTTbvBjeQ5diZ9ottOKDbITdlffCPp3KPdrYVucRee9obV87dDTVxUhV3eugkdNYqkY8v8O6jMxnrnO3fqGNy+vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP/OrV+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB0C4CEED;
	Fri,  8 Aug 2025 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754672561;
	bh=1lNnensga6TBPtqVjWcxWn53peNC+SIAsK+aDfwbj3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=nP/OrV+mkrLA+p4MQRdgAAaWBepZ84gm09dQP1gAFQ+8pFW/R2n3tNuRPwLhDLADJ
	 4uS+bPai9Qw/dlGN6HzUMzaaXbDz1hBJMpl2NDtkQS+zlqMBDE2lgvvIIPNWONuEki
	 E+X3RziQlGh4tzP2yZ1qN3wXyZrS+vKjJpd0qrtW+TCBlhfj0Tp/ZWE+qnfaCagcR9
	 TlcFzAzyH6+JU+xTyfzEjvu0fTTkXjpODjYHIKFnXCac5Wb9VFyEHe90CuQYWKqtAq
	 VPXFYhR8ERTlAx1ZwB0KqauVZ0njDRwHSly6OEj8kYq37vUKgqZNaTNJl20a1IHarC
	 jkL2jzN8QHPJw==
Message-ID: <748ae3828202bb22422d4947b740f43b.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.17-merge-window
Date: Fri, 08 Aug 2025 18:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 2d442a0c781403702de27ccfbc4bb233721585f5:

  spi: SPISG: Fix less than zero comparison on a u32 variable (2025-07-25 18:46:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.17-merge-window

for you to fetch changes up to ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667:

  spi: cs42l43: Property entry should be a null-terminated array (2025-08-01 14:36:21 +0100)

----------------------------------------------------------------
spi: Fixes for v6.17

There's one fix here for an issue with the CS42L43 where we were
allocating a single property for client devices as just that property
rather than a terminated array of properties like we are supposed to.
We also have an update to the MAINTAINERS file for some Renesas devices.

----------------------------------------------------------------
Fabrizio Castro (1):
      MAINTAINERS: Add entries for the RZ/V2H(P) RSPI

Simon Trimmer (1):
      spi: cs42l43: Property entry should be a null-terminated array

 MAINTAINERS               | 8 ++++++++
 drivers/spi/spi-cs42l43.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

