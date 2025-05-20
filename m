Return-Path: <linux-spi+bounces-8219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A9ABD6A1
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EE17426F
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4D5D2FF;
	Tue, 20 May 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOdT+U72"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681026FD83
	for <linux-spi@vger.kernel.org>; Tue, 20 May 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740086; cv=none; b=kzJTA0oErZY02tfDdKLZCxQr8bsjLTx+mBWXF7iqCFueqVsw4M16z//HnPufouKv163yyASnU7VOgcYYEWWtptduB3UfwKqPuQCaNUaOBSai4HpSZmVIjKsa6kXGcpuTJdgYA1KjlknhYRAFedcPFWcQq+g6nsPdYXHOWETPZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740086; c=relaxed/simple;
	bh=kESabZoGCapp+QKU8v9AHS5uk+4YSH4ssYglvyaUXBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sWze2nUYPdx6/nkd9pfTHyHH5yDRhkl2i1bcyLi40R0rIbTLMW196bi0GaUGlHWBp191LgQgeuBNYdqM7iUIFMKO+CVIRGE7FvTLRvj+IBMIO3AOr1AlQTrZP/MZVG0iM4n9h2bvJ8YnHw9dI29BqLEbvUPdAB+if0ZGKpUEo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOdT+U72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06B5C4CEE9;
	Tue, 20 May 2025 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747740085;
	bh=kESabZoGCapp+QKU8v9AHS5uk+4YSH4ssYglvyaUXBw=;
	h=Subject:From:Date:To:From;
	b=qOdT+U72ax76UcVQ9l+NH0sh2U9mw2p0zGA+qa2Osq4IM/IPP/MJEa5hMbgTpk/aM
	 NMpoLNeo5B4+wlu6UHAKVRiYoBdsAKmlG9w8ORNAD0PSds5K9ZG2y5UFwAkDOKXEC/
	 KJcs8sm7XHoiiBdI3Ucj/AQJ1Q+ub4OCrv+bcRY5qwKHQw1ZO5jpFytH+5T0bGV8h5
	 RRc7+BI3BASaNPNOrzBdyFtp7kL0Me4cgkTId/drTieDEWT1j2htCIrz4wTO8mZX2f
	 iM1G1/dtYJ4I2erRb9sEq0FBG2Waik7PhWrU0KV5JJeRaksMtidiVV6iGf+GjJ/N8Q
	 wmknPFMslDljw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EED34380AA70;
	Tue, 20 May 2025 11:22:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174774012146.1275309.7779842064995610922.git-patchwork-summary@kernel.org>
Date: Tue, 20 May 2025 11:22:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sh-msiof: Transfer size improvements and I2S reuse
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963630
  Lore link: https://lore.kernel.org/r/cover.1747401908.git.geert+renesas@glider.be
    Patches: [v2,01/22] spi: sh-msiof: Drop comma after OF match table sentinel
             [v2,02/22] spi: sh-msiof: Remove unneeded compatible values
             [v2,03/22] spi: sh-msiof: Fix maximum DMA transfer size
             [v2,04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
             [v2,05/22] spi: sh-msiof: Use bool for boolean flags
             [v2,06/22] spi: sh-msiof: Make words/bits unsigned in sh_msiof_spi_txrx_once()
             [v2,07/22] spi: sh-msiof: Make words/fs unsigned in FIFO helpers
             [v2,08/22] spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
             [v2,09/22] spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
             [v2,10/22] spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
             [v2,11/22] spi: sh-msiof: SICTR bitfield conversion
             [v2,12/22] spi: sh-msiof: SIFCTR bitfield conversion
             [v2,13/22] spi: sh-msiof: Correct SIMDR2_GRPMASK
             [v2,14/22] spi: sh-msiof: Add core support for dual-group transfers
             [v2,15/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
             [v2,16/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
             [v2,17/22] spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
             [v2,18/22] spi: sh-msiof: Simplify BRG's Division Ratio
             [v2,19/22] spi: sh-msiof: Double maximum DMA transfer size using two groups
             [v2,20/22] spi: sh-msiof: Document frame start sync pulse mode
             [v2,21/22] spi: sh-msiof: Move register definitions to <linux/spi/sh_msiof.h>

Series: spi: spi_amd: Add DMA write and Kconfig changes
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963560
  Lore link: https://lore.kernel.org/r/20250516100658.585654-1-Raju.Rangoju@amd.com
    Patches: [v2,1/3] spi: spi_amd: Remove read{q,b} usage on DMA buffer
             [v2,2/3] spi: spi_amd: Add HIDDMA basic write support
             [v2,3/3] spi: spi_amd: Update Kconfig dependencies


Total patches: 24

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



