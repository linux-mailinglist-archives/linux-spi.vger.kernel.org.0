Return-Path: <linux-spi+bounces-6808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF363A34E27
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAF916D439
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205C242914;
	Thu, 13 Feb 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVD+8ciD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5E24169B;
	Thu, 13 Feb 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473249; cv=none; b=H+RCx/6i9aNFwSthUuEqg83oTbFpMiydeSlAFV0aqAGJ2uBNBLTa3kNtz3kbWBqRt5hrorGkn1gfKWA4ZTstZs2t5JOnft8qYZgDcU/MvDwx9BsadtomMgAqFcD7QmptzIBHIn0g91uLe6BzCDXetmRvXIWstcxr35mcYhGd6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473249; c=relaxed/simple;
	bh=JaHqVJvQmb7a9rZUyK0wHWtLTa86pNWN6s+bx1cJ1Ak=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Ur7bIz4FmQipKuKR8jgseaAh6MEt6+CFhoH+33G5af+/9emu8PUEA4jmoF4xIbvFl0r9vk7XvUlRPipO+V+c8fqzDaEB3c0HnR9pfluT5GaiySas3zWyyA5OQJZGfGZQcyOL9NeXzUR0Di72l1d11rTylSdBO5INjqXuGy4RHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVD+8ciD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E4BC4CED1;
	Thu, 13 Feb 2025 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739473249;
	bh=JaHqVJvQmb7a9rZUyK0wHWtLTa86pNWN6s+bx1cJ1Ak=;
	h=From:To:Cc:Subject:Date:From;
	b=qVD+8ciDjC4HxvjB4K5vtw6D1T+EDoaKITEtvnQLbyjI1WqyyOTvkQWSSTSP293XY
	 3r+v8KH48E6uqM78U2ToujHudNIjb/MG0m0UP6MyAUQqCv0Mi5Vuc0YLysstiMh79/
	 LLHnx3BsOte6vtmxgoccY/0QKzQC/56S8QWBYiISI4HtNqQ4vF4NkGnxNJtmQm7aJv
	 lCjzURexykJwFFl8D+ryiTVYz6Uq8TbKE/MTIBDKHBP6k1xDEgyZH+KR/xAyCanZmc
	 ORt9esb0+sPzc39x3zAXjiKZMOOHmMc/tMHRd01Z3afJvU2wUhWR+Hwse/wYxCJvWC
	 58NZtkl483WBw==
Message-ID: <2b29351684e99c02491f86ee5cce20a6.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.14-rc2
Date: Thu, 13 Feb 2025 19:00:31 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc2

for you to fetch changes up to 3588b1c0fde2f58d166e3f94a5a58d64b893526c:

  spi: sn-f-ospi: Fix division by zero (2025-02-06 11:33:51 +0000)

----------------------------------------------------------------
spi: Fixes for v6.14

A small collection of driver specific fixes, none standing out in
particular.

----------------------------------------------------------------
Bence Csókás (1):
      spi: atmel-quadspi: Fix warning in doc-comment

Kunihiko Hayashi (1):
      spi: sn-f-ospi: Fix division by zero

Mark Lord (1):
      spi: pxa2xx: Fix regression when toggling chip select on LPSS devices

 drivers/spi/atmel-quadspi.c | 4 ++--
 drivers/spi/spi-pxa2xx.c    | 2 +-
 drivers/spi/spi-sn-f-ospi.c | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

