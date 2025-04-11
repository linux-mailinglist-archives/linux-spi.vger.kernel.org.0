Return-Path: <linux-spi+bounces-7552-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42813A85C4F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 13:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E653B0E80
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E31DE3C7;
	Fri, 11 Apr 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l06oJnWT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EE1E48A;
	Fri, 11 Apr 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372413; cv=none; b=UEf293+uPLx0p+vTCBU40nDOuJTS+PDA5gRDlSjapbN6v710ScqYVltc07xFq4ZRwmTfAydh53+ny1T9hwMB8mD1RVwbNuk34RX8EcY+nVfHLWD78e0NS+6wd6sgLMx+czSOua4Hbly16d4PW6Dz/Nc+VHbKxjs5SOaOIPWkF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372413; c=relaxed/simple;
	bh=Bx22tjKqk+N6y27RtC1k5fofdh5aHkCbEGEp/ZHZ9Gs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=m7szZXvdfb3tIOj4D2ByEiVzSp6WgDxIQd37yERynR3s1+1iTNSJfXMzXJpsCkIiRR3BIShCP8oR++O0mWAEZPrKoRHPE5Ag63vaYzA0xfRS4dzirpxnOsNem0+x09MJbY2+hGkdbq5ekNIy2z0JUV6zRf3LrNvJ3AWGmLZ1qKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l06oJnWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E1CC4CEE2;
	Fri, 11 Apr 2025 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744372413;
	bh=Bx22tjKqk+N6y27RtC1k5fofdh5aHkCbEGEp/ZHZ9Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=l06oJnWT1iKmY6LM84m0c5RV7PqKG09wJq/mTBiXRM9ypzOkOQuRcgfKFjg58AMoS
	 n2Mh9ZIPoZx/wcfgPIoq2Dg0KcDF2XMHIfVim2B75kfl+73OhF2wKgL8XtPq89GfcI
	 DJwFQLEW2Ri9YNecGBQP/RqmJzM+RssMKhxx9HXU2vjcjidVXu5n4NyyhxjSOLOSI+
	 uVc2XaskXKN3mIvUwDhSs+y3Yqph97k0p+5T3N1VJKlENM5nMuciDGCFWKv7OtrhuZ
	 +TMBOhIAxC5gsAxb97p2jRekNt/cJExesjKxQYqIumiRvIs+1Vnj07zcRlWxwAU8co
	 nxyo/9AcsWmQg==
Message-ID: <0bdfc1a8ab698e3518f29f4cdd3cab3b.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-rc1
Date: Fri, 11 Apr 2025 12:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc1

for you to fetch changes up to 82bedbfedd2fc7cd1287732879e515ceb94f8963:

  spi: fsl-spi: Remove redundant probe error message (2025-04-10 12:25:21 +0100)

----------------------------------------------------------------
spi: Fixes for v6.15

A couple of cleanups for the error handling in the Freescale drivers.

----------------------------------------------------------------
Kevin Hao (2):
      spi: fsl-qspi: Fix double cleanup in probe error path
      spi: fsl-spi: Remove redundant probe error message

 drivers/spi/spi-fsl-qspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

