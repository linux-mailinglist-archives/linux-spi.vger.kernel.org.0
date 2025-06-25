Return-Path: <linux-spi+bounces-8772-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DDAE8D0D
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 20:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605B83A736E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4A2DA752;
	Wed, 25 Jun 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVSRtwV/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDF2D8DBB;
	Wed, 25 Jun 2025 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877598; cv=none; b=Fl1QGF70aC7gv3FwRGGhBckb7Ve4uoSDzJThso1lynBciZ21srkCz0aCfzcWCsgfSBP6xNJkKP8da8wtBpLSmCsGg6Rl9oRXL6UyFPrdfbRL4Kczr6vXOYNw4hpTfX5XD5bI+De614FHXAhSaCNjv2yqVcjAkALQ6ylM2z9SnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877598; c=relaxed/simple;
	bh=3wYCOYlwhfdQnUe00+EDf/165r80azUtSL9YyHaV/T0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=DFpaF5boqtn0LhxDmaQFHugIxFgvRLpqYk9TPms3yTgQWGU45k2yKuQrR76+1ZNW2krEoXl+GFlp0DgutW/OtBlS2xeNS2T+/vBM1xE6ikSPde8rJzUhheOAqwfvGArCaOa9uO32TVPDg5syzUi7oUhy9xI3mF5K4Iply6w1+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVSRtwV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F3C4CEEA;
	Wed, 25 Jun 2025 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877597;
	bh=3wYCOYlwhfdQnUe00+EDf/165r80azUtSL9YyHaV/T0=;
	h=From:To:Cc:Subject:Date:From;
	b=CVSRtwV/MrKypcajCBrXjcZg/nC7B12T8B7lLJmQ3bq2arDvmqttE1eMHSDJGNYx9
	 xH8ztUrrVWBA8NlFi0/yZgNlBM0U3PvKxjKS7gP3XCpnXo1FVuVmaCcEwpb5hD3ViS
	 2aNzHdRipdYEqAmJMieDaWwvL4QALPmAOukPWaQObQAGAa6HTsVXSrszUAnFLB9C/J
	 jAX9ybDzi5Svs70w61RUJY16aU6IOmaA6gb7czs9i8BrmnuDvWLv3decbx2A+jVuOv
	 Py7uRfRgzX3yFd9g91ex/a5r9eSkIM++9WWyLm5VVuTZ3EnHe/7SvTBbwUftbSYkYd
	 A7XumvavhwRsQ==
Message-ID: <95ca93d21c843dd7a6ae15410596d123.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.16-rc3
Date: Wed, 25 Jun 2025 19:53:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.16-rc3

for you to fetch changes up to b07f349d1864abe29436f45e3047da2bdd476462:

  spi: spi-cadence-quadspi: Fix pm runtime unbalance (2025-06-24 16:40:31 +0100)

----------------------------------------------------------------
spi: Fix for v6.16

One fix here, for a runtime PM underflow when removing the Cadence
QuadSPI driver.

----------------------------------------------------------------
Khairul Anuar Romli (1):
      spi: spi-cadence-quadspi: Fix pm runtime unbalance

 drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

