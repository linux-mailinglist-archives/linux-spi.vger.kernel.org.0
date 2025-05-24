Return-Path: <linux-spi+bounces-8277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D29AC31D2
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 00:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA33B5867
	for <lists+linux-spi@lfdr.de>; Sat, 24 May 2025 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28921AAE28;
	Sat, 24 May 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qK9bo6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90837482;
	Sat, 24 May 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748126123; cv=none; b=fjlqjdUDc+ET3wYT2/ddRd5NsWZWXQRNhCqpQDhl1WnxY+xBv6mzmGK1ubClveDJ8H2kmrS7RlzlR/g/0UuvzylIKTj2H+2EiC3wdB3Nd+Vzj1BEn0izK0nxI2XS4QbsEdgL5jIXwwbG6Cktw5dmezEbYxut0xfUdDeISPkw12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748126123; c=relaxed/simple;
	bh=dU4AyeWP+INwsL+aKLcDRQiaDCQV4Vh2+r41wSbmyK4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=TawpeEQ7G97AEHZn5CBP4btzwzgOVP0zCjazdMNAzoe2YhMhc0hv2KMNobBdAVh6V0IGAEp5Z18HCj5o4W3r/JnWgw4ftYBsqoTcPTzgJsd2xBcPXWldCUTVsal8wWbVn4HjBYj1Q9vgWAnhw7ZvNIl6gOSz9ue0PmBKH5WsFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qK9bo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B9DC4CEE4;
	Sat, 24 May 2025 22:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748126123;
	bh=dU4AyeWP+INwsL+aKLcDRQiaDCQV4Vh2+r41wSbmyK4=;
	h=From:To:Cc:Subject:Date:From;
	b=l+qK9bo6qbJ9gjihICWvh113OdRUA+orlSAbSxmdcmIn5gkmJ7WWBYOh36nerhDjS
	 Ic43/ThJhBHuXCjEIW2Ssl4LRlpNq5rIe+BZvB6D+tN5OSp523Zpmsd6HwKx5ADdGP
	 Uz+49w58tkV2lX6Jp55p2+rz17r6t5424WShsp97cELKJXrukcLx53ZKC88MQmVjGZ
	 KgkJtZu2TRXr77ihIN1ftP9ckNUZcrewq5vZLFqyf+q/xjmy3jbSg06rlx/Rx8j9mb
	 OKaEmR+DNPxyxKYZs6xYgudMD59OlsmugJ2W1WaokszaNpcJUXtrxNYKNwYQhlxch8
	 0hzrPa+A/emFw==
Message-ID: <cc4326d57c0588f9916731c203773a17.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-rc7
Date: Sat, 24 May 2025 23:35:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc7

for you to fetch changes up to 7aba292eb15389073c7f3bd7847e3862dfdf604d:

  spi: spi-fsl-dspi: Reset SR flags before sending a new message (2025-05-22 16:05:26 +0100)

----------------------------------------------------------------
spi: Fixes for v6.15

A few final fixes for v6.15, some driver fixes for the Freescale DSPI
driver pulled over from their vendor code and another instance of the
fixes Greg has been sending throughout the kernel for constification of
the bus_type in driver core match() functions.

----------------------------------------------------------------
Bogdan-Gabriel Roman (1):
      spi: spi-fsl-dspi: Halt the module after a new message transfer

Greg Kroah-Hartman (1):
      spi: use container_of_cont() for to_spi_device()

Larisa Grigore (2):
      spi: spi-fsl-dspi: restrict register range for regmap access
      spi: spi-fsl-dspi: Reset SR flags before sending a new message

 drivers/spi/spi-fsl-dspi.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h    |  5 +----
 2 files changed, 46 insertions(+), 5 deletions(-)

