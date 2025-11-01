Return-Path: <linux-spi+bounces-10966-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99939C27E0E
	for <lists+linux-spi@lfdr.de>; Sat, 01 Nov 2025 13:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C4A4E24D8
	for <lists+linux-spi@lfdr.de>; Sat,  1 Nov 2025 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7031CD2C;
	Sat,  1 Nov 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUEgbPV+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146ED2FB;
	Sat,  1 Nov 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000217; cv=none; b=AlGjrPojDTH15raSBresr1lNt7aEfwNCQbs5qWkw5ah4QRCviz2LUF8gc+S72VyqVSN9cen5MacyOEPHAy5t8unH/NG25V78fp0X8Qgpu62CYiZUJpae2zXJr6GCtvOiBmLmDQQ0d8AhxoWC/zWHz/yOJjYs4E5riXa1Edxlv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000217; c=relaxed/simple;
	bh=sx4D0J/KEQZNKMyFy1AxfEvU28dLJzVS1so6MdAI7FQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=XH8Bv7j2uX7MqnKgmvt+HoEpdF0OY+8nl10qgv/79GdUtRAYy+a2Ej4aKwWSM0P8CC6ZtjFbwOHEchSkQCUTAcHvndcb4soKCCOZOBCF9M41fGbzOhVRb+LxYGz1R3pQrsaKR56fY1UHQJ/X5h5ouT1892bmikKHRihD4+hzGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUEgbPV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10FEC4CEF1;
	Sat,  1 Nov 2025 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762000216;
	bh=sx4D0J/KEQZNKMyFy1AxfEvU28dLJzVS1so6MdAI7FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EUEgbPV+2oe8eYGjR6dsq481cPWITTb9LhQ6SM7v5RfCX5Ck4bvF0w4y/vlA5piON
	 /G0jOcHR0ohiHlt+bbKfrysruhYAFwquAbDNrFsdmkx4lvCJ0DYEirM5aVJTNSHxb9
	 BuxrkfJbqVKdU4iLixDch3KyOWD8s4O86lOadyhbXcv0wKlyo9DpprqsQ1Mq1hHzkw
	 i4JwrcEqBxxS6ap7PKuBvYxFBpucvXhrsw/4whcoASYxeod1r8HgC7/mh42MKWHQev
	 v5kC09aLqWJdWNL5Zk3QzfCLZ8uX8b040TyxttanP+EMUXFTlqvlYBDs2adkQUcYkM
	 YuOx7Xs1rg+ag==
Message-ID: <ebe895d1aed47312d7f57da076ac3d68@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.18-rc3
Date: Sat, 01 Nov 2025 12:30:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.18-rc3

for you to fetch changes up to e7dbfe6f15b4df34bb169d180bd10f1a3c043814:

  spi: intel: Add support for Oak Stream SPI serial flash (2025-10-29 12:53:45 +0000)

----------------------------------------------------------------
spi: Fix for v6.18

One new device ID for an Intel SoC.

----------------------------------------------------------------
Heikki Krogerus (1):
      spi: intel: Add support for Oak Stream SPI serial flash

 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

