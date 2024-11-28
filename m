Return-Path: <linux-spi+bounces-5859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A89DB91B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 14:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6614281475
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AE1A9B52;
	Thu, 28 Nov 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLt/DtWm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436D19E99A;
	Thu, 28 Nov 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802112; cv=none; b=gbYUEAjhmdycsFLrr9TRXjpukDdDhz5CRlzdIQtff+uXhxvjH/XpW9lB6Z02Rx//kO8ODsNvyUajH1Ba9nZpnzl99XRLgh6nfSXcU4fULOUjSMggofLgLMUdYbWp6bumKZY33XhX5p7V0NzFrwOh+0M5g6BJ2VTMUu2HeQmxADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802112; c=relaxed/simple;
	bh=Ny/2x11Lom087+YOYttsy7MBje6S99SWUsnqp7zZUUg=;
	h=Message-ID:From:To:Cc:Subject:Date; b=q+07P28abgmMnnoxDLv08Me8EIVC61bsthDXmfNfLa5HJk5yJa98HW7pEfhRvVVK7GYVZSOpstHpPrBS7GESxMJrEC1GuurhalRR56Cj+07aaLaJp++WNSZaDfepQ2mNPpVWHACqIUS+ThfuLJ0+ZHv5G6SNw1QRczmbR94dwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLt/DtWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9C0C4CED2;
	Thu, 28 Nov 2024 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732802111;
	bh=Ny/2x11Lom087+YOYttsy7MBje6S99SWUsnqp7zZUUg=;
	h=From:To:Cc:Subject:Date:From;
	b=kLt/DtWmgimzR7XAoKN7xQ4IFFVbNp2vV6Tcs1jAFG3X81MbyyK6T2yTWvN+349hv
	 FIZ/TlpHs67jeAqiDvY4pp1cuyZVdqvODyr4H5GkhPf0V8aaIVlsz/RuvUqv77rD/B
	 eYALfZ81M+VLiK3NL3l08kULfhSKbM5efRcFjx8VsVUU3wt2dPA0VLZk69bkzBHA4I
	 oPWF8+yLdUB5rq8js55Uj2r1B2538SUXrhXKqEIQgOCmz0QbaQ8ZQv53oJFSQPv4k9
	 uBKhMnlhTr7EAWWe2YLQacuhrCeqPn8tSRv0RWHt4OLKRwd0JVo2a/9ZwTcc019qqK
	 G5099b3U+P/RQ==
Message-ID: <d3586482f22de4e1ccfca9139e4d30dd.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.13-merge-window
Date: Thu, 28 Nov 2024 13:54:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 26470a2e87a6fc40750f4bfe962519e9ae9a9e72:

  spi: imx: support word delay in ecspi (2024-11-14 11:43:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-merge-window

for you to fetch changes up to d24cfee7f63d6b44d45a67c5662bd1cc48e8b3ca:

  spi: Fix acpi deferred irq probe (2024-11-26 11:29:15 +0000)

----------------------------------------------------------------
spi: Fixes for v6.13

A few fairly minor driver specific fixes, plus one core fix for the
handling of deferred probe on ACPI systems - we ignoring probe deferral
and incorrectly treating it like a fatal error while parsing the generic
ACPI bindings for SPI devices.

----------------------------------------------------------------
Antonio Quartulli (1):
      spi-imx: prevent overflow when estimating transfer time

Csókás, Bence (1):
      spi: atmel-quadspi: Fix register name in verbose logging function

Jon Lin (1):
      spi: rockchip-sfc: Embedded DMA only support 4B aligned address

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

 drivers/spi/atmel-quadspi.c    |  2 +-
 drivers/spi/spi-imx.c          |  2 +-
 drivers/spi/spi-rockchip-sfc.c |  2 +-
 drivers/spi/spi.c              | 13 ++++++++++---
 4 files changed, 13 insertions(+), 6 deletions(-)

