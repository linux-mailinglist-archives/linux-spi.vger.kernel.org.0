Return-Path: <linux-spi+bounces-11018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B0C34FD3
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2561418C1567
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333D2E7197;
	Wed,  5 Nov 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMUhCkV4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7923D7F3
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336655; cv=none; b=FC843iBaH9Q746BfMlAchQixd1FJE47d/E2OzpALhefQbYg6ki7BHwK1r0vNK6hANIaemB28W/Nj9+/rNah77R7UmfFNsLpJxSJAB7S/9U4vAuz+HxvRfT3ro6xzCUsf9XpTWj+Hz9qI/WhKrOjIp6eZW1wML2gqwPmZ2Fv5HTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336655; c=relaxed/simple;
	bh=uPIMFP+Vx9WVC4FOWhelul+XrN5Rinsp6fbT68Tyz9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XGK7QKXyCpWKByHTcmgFn+JhYFAHTp2ZZqWiYfJnXFX0EL2yL/+h3iX8fSHcIb+yO+fhTwhmCBWy2x/l7SM9EM0HhAFOCba2/f70vqUhaRkBlY4ioALP4Hk8/p2AFISVeTjZNa5CenI7615hrz1Pvtle745AskygWO+2RAynij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMUhCkV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D07FC4CEF8;
	Wed,  5 Nov 2025 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336655;
	bh=uPIMFP+Vx9WVC4FOWhelul+XrN5Rinsp6fbT68Tyz9E=;
	h=Subject:From:Date:To:From;
	b=SMUhCkV4jz1y2HXUvcnk6EpRU2Jg31D/mmrF6Nqjcw1KTE/0t1J8G3cQs1x06PGr2
	 /KPVZCa6in5hdzV2JMuQjqElCc5V74s7vTtw+Qsio8HDTUFss+0te99dACo4z2LKjx
	 Vs5H4hbcWaYa2EXENh2zxK9TOVmf5IrQAGRlRecFBPGBAdAOCaF6CQzUQxlqPTQDOG
	 O8WiK+y5L9TAOOutukKrDoXcEydwWb8buxPDDuJeWUTCUPxES/Jou9S3dLD2SIdMWz
	 QUwBFAQ5/ob2L4tuUi2igqahltSininAsda8cjYDveKJNxKwh2QnpTub26o+L+G8M3
	 6LogzyDJMEA+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0A380AA73;
	Wed,  5 Nov 2025 09:57:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176233662862.3550121.9037152638506832933.git-patchwork-housekeeping@kernel.org>
Date: Wed, 05 Nov 2025 09:57:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] Add RSPI support for RZ/T2H and RZ/N2H (2025-11-05T09:13:44)
  Superseding: [v1] Add RSPI support for RZ/T2H and RZ/N2H (2025-10-28T13:31:31):
    [01/14] clk: renesas: r9a09g077: add SPI module clocks
    [02/14] spi: rzv2h-rspi: make resets optional
    [03/14] spi: rzv2h-rspi: make FIFO size chip-specific
    [04/14] spi: rzv2h-rspi: make clocks chip-specific
    [05/14] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
    [06/14] spi: rzv2h-rspi: avoid recomputing transfer frequency
    [07/14] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
    [08/14] spi: rzv2h-rspi: add support for using PCLK for transfer clock
    [09/14] spi: rzv2h-rspi: add support for variable transfer clock
    [10/14] spi: rzv2h-rspi: add support for loopback mode
    [11/14] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
    [12/14] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
    [13/14] arm64: dts: renesas: r9a09g077: Add SPIs support
    [14/14] arm64: dts: renesas: r9a09g087: Add SPIs support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


