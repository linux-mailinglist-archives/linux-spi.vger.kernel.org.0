Return-Path: <linux-spi+bounces-11356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D3C706C9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E6F4FE8D8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C9341073;
	Wed, 19 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfoogt2B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C001359F8E
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571472; cv=none; b=GvUx6vnVQuKkhE1JFtNnhGV94DW3C5xNVE91oM+QQVsC7r2MSbP6cPlUOoniiu8xZV/MpR24OYQkLzg6SUEHj/coBj6KwKDVobLCSXAtZiZ/P+Ne27JdpWZ/08lnHwWIVDWrmmLB7O9aWmmL0NObwHrODgczaceez+LiOTRCg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571472; c=relaxed/simple;
	bh=vuhvuifm6Ys1c48/C3ZPuzoTKYyVvyUyElZ2IkjJtUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DtAaDKcOD+HtwPUNUig7y7V2TBSYJNVsFp0K7KnPu1D+ta2KkpjJ89yepKIBL/WSdDkWXlA0gbtyElseHrJeXnhr9riBlqxcBGK6mp55Srk2BL3Km0BZIA1ewosfU2DHXjEtAihQ0eVv9uYKU47qu7/mKs46TCYtA71ujeYpo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfoogt2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C32C4CEF5;
	Wed, 19 Nov 2025 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763571472;
	bh=vuhvuifm6Ys1c48/C3ZPuzoTKYyVvyUyElZ2IkjJtUw=;
	h=Subject:From:Date:To:From;
	b=pfoogt2BvY1LAwOE3XVurma3cGOxxqxHheeWh6IrOFC283szEbEiFPeEZbldwPEZk
	 DCB3lSFrFnSkM8igX2QzImBohrVdLXC027iHdsLvR1YWmDawsh9qER0hyGkh4wucua
	 cDWW+zydWLhPvFO/7fay9o/mzqrnLulFwxsTJ3js+iK65RnfCeDoTnuBpSpbxNWLC2
	 FB4gfAvWzs+VReFnq9TruzjsLaHpix3bFCJ3LQ0vMlpzo4pogsYzI08hgdxtGHdpV/
	 ek0mYw7PTmkbCwoWqKXoCARW/mn10K8Za4yITzGm4vLAIShg2OEMsY8qAorYBTNW7W
	 rISPShoZerMWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF1CD39D0C21;
	Wed, 19 Nov 2025 16:57:18 +0000 (UTC)
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
 <176357143739.879588.15378177640929492094.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Nov 2025 16:57:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add RSPI support for RZ/T2H and RZ/N2H (2025-11-19T16:14:21)
  Superseding: [v3] Add RSPI support for RZ/T2H and RZ/N2H (2025-11-05T10:41:37):
    [v3,01/14] clk: renesas: r9a09g077: add SPI module clocks
    [v3,02/14] spi: rzv2h-rspi: make resets optional
    [v3,03/14] spi: rzv2h-rspi: make FIFO size chip-specific
    [v3,04/14] spi: rzv2h-rspi: make clocks chip-specific
    [v3,05/14] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
    [v3,06/14] spi: rzv2h-rspi: avoid recomputing transfer frequency
    [v3,07/14] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
    [v3,08/14] spi: rzv2h-rspi: add support for using PCLK for transfer clock
    [v3,09/14] spi: rzv2h-rspi: add support for variable transfer clock
    [v3,10/14] spi: rzv2h-rspi: add support for loopback mode
    [v3,11/14] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
    [v3,12/14] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
    [v3,13/14] arm64: dts: renesas: r9a09g077: Add SPIs support
    [v3,14/14] arm64: dts: renesas: r9a09g087: Add SPIs support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


