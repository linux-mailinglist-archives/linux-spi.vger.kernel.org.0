Return-Path: <linux-spi+bounces-8177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A4AB9E0C
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3CC1897638
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8478F5D;
	Fri, 16 May 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNfX+sMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657972601
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403792; cv=none; b=YSlxW63FFJ1zn351iVehqhCQjwptGOO+WjXcoZxeQdv6NYUZx+NXgkYlMlpCTov2jHMSHf5obeU/JFT0j1jaAxSraPSYjw6V+yYgrA8YNRHdFu77Z/74qas2zJH5av6MlEo5mKIZTbwa6402xarwi1JDl81K7dMunOJ4kTMFoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403792; c=relaxed/simple;
	bh=6MYoQmqP+ufMxfRJEG86bvbH3KRqOeUSA4KdcPWpouQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jogKbeQz5MM/Tbt5pacrv2y+TypiazDN14Rr0zu3FXq+mRnoMIJ1wUKRNZkbI/ErWC5dJ00DUt/g+KqffZUFkX96tJ10Dl8Kujt9ZuupcMVfSvIv4mVXYaDgnf/ES4xMpa81/w5kZDm5pFjEHhGsmNrFztCSvzZGPUM3g2tBRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNfX+sMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E74C4CEE4;
	Fri, 16 May 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747403792;
	bh=6MYoQmqP+ufMxfRJEG86bvbH3KRqOeUSA4KdcPWpouQ=;
	h=Subject:From:Date:To:From;
	b=GNfX+sMWrO4mtOWtX28MxgY4jipiZhn6WTk9nD2MM7dgMhC6C+qsmfRuwWyxnfuV6
	 shD66esVrX0IyCnYhgk4cyb3LxZRV0+lmqucs8wtMH4DFNcEe/OxYdq55wfFhQhLO5
	 jayok4XD8LdUQ4osHHNe297iTNZKhCczzT7W/KeQfCTtzDIG6uRbiaVHT+q5yKD25T
	 WFgfdxyYJAfuZ6hcudv2yAsXDtBSGu00RSR99ISNJdB0K7hUAV6McA3zC2lDAzUrVI
	 33ZHgL7aaHpvOQUDSehF0fm26IFd94afy0Gvedf3gROQ3s3HXjUHR5uakM6XwFc1Rc
	 LoSCGQUqpFd5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCD3806659;
	Fri, 16 May 2025 13:57:10 +0000 (UTC)
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
 <174740382869.3942617.9201795034401160605.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 May 2025 13:57:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sh-msiof: Transfer size improvements and I2S reuse (2025-05-16T13:32:19)
  Superseding: [v1] spi: sh-msiof: Transfer size improvements and I2S reuse (2025-05-02T10:13:46):
    [01/22] spi: sh-msiof: Drop comma after OF match table sentinel
    [02/22] spi: sh-msiof: Remove unneeded compatible values
    [03/22] spi: sh-msiof: Fix maximum DMA transfer size
    [04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
    [05/22] spi: sh-msiof: Use bool for boolean flags
    [06/22] spi: sh-msiof: Make words/bits unsigned in sh_msiof_spi_txrx_once()
    [07/22] spi: sh-msiof: Make words/fs unsigned in FIFO helpers
    [08/22] spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
    [09/22] spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
    [10/22] spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
    [11/22] spi: sh-msiof: SICTR bitfield conversion
    [12/22] spi: sh-msiof: SIFCTR bitfield conversion
    [13/22] spi: sh-msiof: Correct SIMDR2_GRPMASK
    [14/22] spi: sh-msiof: Add core support for dual-group transfers
    [15/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
    [16/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
    [17/22] spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
    [18/22] spi: sh-msiof: Simplify BRG's Division Ratio
    [19/22] spi: sh-msiof: Double maximum DMA transfer size using two groups
    [20/22] spi: sh-msiof: Document frame start sync pulse mode
    [21/22] spi: sh-msiof: Move register definitions to <linux/spi/sh_msiof.h>
    [22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


