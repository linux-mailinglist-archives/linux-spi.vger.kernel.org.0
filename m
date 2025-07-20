Return-Path: <linux-spi+bounces-9138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BCB0B662
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496AE1887B27
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A221884A;
	Sun, 20 Jul 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxXNhBGY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04F28E3F;
	Sun, 20 Jul 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021103; cv=none; b=BgNsEcpikNKK3yry5vlU4PcLGOHsnt7P/xFw+PYqJZUurepn/Fyb+yu/IpcRyupvjLq/9QkINGRmS2Mz7M+F/tMTAztJTga/ttqigcNeekxTL1V/0TZxgheuFNZc+pLePc2o6Az1X2gdj7CSEX+kNpW9Oq0Poc5K1+YZL7EBU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021103; c=relaxed/simple;
	bh=YGsua5ujuC93l9jFlxpHGdx9Dk8Unk9R/VkNnrX6Nng=;
	h=Message-ID:From:To:Cc:Subject:Date; b=kjg6HMN00Dj4CivTPd9hIgXRoRptaN5jWhyUbu0ggKxdpXtfE3gNOK1eh2lv+yhdjOk4b637lvx3DR3HskGbt5qcyw+4hh9RmjtPGvimoHW84A2yFRcOtM5/b8x/acMwsKkVfHl3ywWQQkAIwCS3etgK6UTrokkibu3g/7USX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxXNhBGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7447BC4CEE7;
	Sun, 20 Jul 2025 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753021102;
	bh=YGsua5ujuC93l9jFlxpHGdx9Dk8Unk9R/VkNnrX6Nng=;
	h=From:To:Cc:Subject:Date:From;
	b=UxXNhBGYzYHz1yfnjArjnBQm16QGQA4FAOvPkQr/P8uY6D/LdCaKt4lsYZ3rF+V+e
	 +akGIlAFjkdsJLv3XJ8Tv73y7goynaTFV8mTx79gO9D7gVMpGx3Gzuqg9BqvavGrYm
	 iVjz1c557kOB63vp/conw2VBmKpHzMGfG9cT4BaWmOrZ2btHIPSYJGOQYFtfWX7c2j
	 uJoCAc704EYpoacwG58e4MNI67MIlaSlzivWllgwypeeQzUf1pdeexeepnkIxgYtjc
	 Lwv/zzeUcDeGxwptgW24wFxKDA8dUt1jpA5aF7IjKfYIcYuSfE9Ic4oe4b/cGarwMI
	 nK8oU3YV4D1OQ==
Message-ID: <b12fcfefe2ad579505fc03d6f2e4f666.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc6
Date: Sun, 20 Jul 2025 15:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc6

for you to fetch changes up to 710505212e3272396394f8cf78e3ddfd05df3f22:

  spi: Add check for 8-bit transfer with 8 IO mode support (2025-07-14 14:44:00 +0100)

----------------------------------------------------------------
spi: Fix for v6.16

A fix adding missing validation that 8 bit I/O mode is actually
supported for the specific device when attempting to use it.  Anything
that runs into this should already have been having problems, enforcing
this should just make things safer and more obvious.

----------------------------------------------------------------
Cheng Ming Lin (1):
      spi: Add check for 8-bit transfer with 8 IO mode support

 drivers/spi/spi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

