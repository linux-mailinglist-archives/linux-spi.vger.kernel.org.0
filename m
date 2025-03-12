Return-Path: <linux-spi+bounces-7096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2EA5DEA1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1783A5CB1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FFB24BC05;
	Wed, 12 Mar 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKZ6mZ/7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E91E48A;
	Wed, 12 Mar 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788520; cv=none; b=B4w++yQroDMlIi1ND2EVeqLK6Ob4Br4iQi5YhMJfvbYYk35jtfrCp0BLeKgMYcPICk13hC6MrapdbA3FUKfHpOC1XycKFhRtw6ADNGeRbjBtXlQGyI5RX1mPTKdNvYCIHAfiXgRYJsxbp9eDH1b1opyHANKRPo88dq+F9FOZDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788520; c=relaxed/simple;
	bh=gQZx3AWSostPrrlrX7v/SLMBqnfS7i7l99h7odc50sQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Y9K2AHXHyyU8I908WRGXar2vM8C4RN5Ln6igFBcUnMXP6asXLWQJYzMoiCI0Hpi1qMpSFWqJoP0/1uykxU/WDLkwKkkwzueWq5j9s/Df2IbFEwuTxE90fbI6uosj/FtwPmyvawyGMxZFHKaOUcX7h7AvZd7Mfgqf454EaKBg+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKZ6mZ/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97995C4CEDD;
	Wed, 12 Mar 2025 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741788520;
	bh=gQZx3AWSostPrrlrX7v/SLMBqnfS7i7l99h7odc50sQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UKZ6mZ/7y2I2E+jEAyxlzmevLnRPPda4vRCO4BiweI3UVIace4B1V3uwupkqK4SFJ
	 Mw0vxqNrh1t+KVHnut6J6DBWaOfSjO0l5hCKP9nLaz04UyYT5QB1qSjwti1W8Js3vm
	 qYhWUImBpATrzOTAXsat3CSOJltOqptNP0FLdWtJrSftrLc444ip2SqQPfTS9Ofoza
	 WvTS4vx6en3zIF3WTZd1oYJMfN+axQxBN1/XFT/dZRt+xRA7O0HE9MGgON65YhEuUQ
	 6VQC94qpMc/ZZPTQP4UbZ1lyrOxkK8dLEXk1oUAfpBzmS/kREn/Yl6EkmXtJswuatr
	 tGhxiRcaghvFg==
Message-ID: <a5d6a54f85162906b7ee1e0e9659e8f9.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.14-rc6
Date: Wed, 12 Mar 2025 14:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc6

for you to fetch changes up to 91cf42c63f2d8a9c1bcdfe923218e079b32e1a69:

  spi: microchip-core: prevent RX overflows when transmit size > FIFO size (2025-03-03 12:10:03 +0000)

----------------------------------------------------------------
spi: Fixes for v6.14

A couple of driver specific fixes, an error handling fix for the Atmel
QuadSPI driver and a fix for a nasty synchronisation issue in the data
path for the Microchip driver which affects larger transfers.

There's also a MAINTAINERS update for the Samsung driver.

----------------------------------------------------------------
Claudiu Beznea (1):
      spi: atmel-quadspi: remove references to runtime PM on error path

Conor Dooley (1):
      spi: microchip-core: prevent RX overflows when transmit size > FIFO size

Tudor Ambarus (1):
      MAINTAINERS: add tambarus as R for Samsung SPI

 MAINTAINERS                      |  1 +
 drivers/spi/atmel-quadspi.c      |  5 +----
 drivers/spi/spi-microchip-core.c | 41 ++++++++++++++++++----------------------
 3 files changed, 20 insertions(+), 27 deletions(-)

