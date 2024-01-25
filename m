Return-Path: <linux-spi+bounces-785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C683C5F3
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 16:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44321C220D1
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B516EB62;
	Thu, 25 Jan 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfgiYNZB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C726E2DD
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194590; cv=none; b=aEREAVzMEUtqEw+eP17+YK9zXdyo7GMgvKuu5szBr6gHCHWCo8xu+9GPhDArPSUmuzzhPmRreZDRoQc70uj64++7BkpqGPc8YptgreAEMiuDt495GN9l50+hgKiDKNGav9ddnhWce2zOhQQuCXyZZ6sJNKMNAK3wXFs6fLZx9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194590; c=relaxed/simple;
	bh=KvnrzRnz8czuxiNb5E+X4tlYaY02O7vgrvFeoyRh1+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=q4gPLHNZ+q08xYaC47Pi3hc+czU0xmks0JPbm04EbxkHqR10gIVxOyfvS8NwnjRHPqQZsHePk8ms1SBNOidDSDEOUffc9regYBmMcsmGmk6d6HADDDIMZgsPOk0+p1OnSWM5Cp0BLPi3k+yEO6o8Ai6Yfhfxr6D9sJIcZFD2TGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfgiYNZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EFA4C433C7;
	Thu, 25 Jan 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706194589;
	bh=KvnrzRnz8czuxiNb5E+X4tlYaY02O7vgrvFeoyRh1+0=;
	h=Subject:From:Date:To:From;
	b=sfgiYNZBEjWyNkeQklHzXm1kgBUb3QqXmb19peYM5dLJWEIZf7shkfo6QuIuOXlXS
	 4h99MRJ3ZLf/hOa7jDmnGsWCops5T9ayf/rqx953Rk/S1D0/+s6kDd0uTkJeUaO1bU
	 2L7c+iKp1TJfLvUrux20pU2U5oVJwPIaryriNN2oMnnyb27Fxsh5DmUVl55n3DXp6m
	 jShGigqKOU13ipnL1oGZldDXrVlbuxt8vdtt5bEHFv6wqvf/XPil6LkBLTEhbzyDIe
	 DfAKS+nL6ZdmuapIbLJkIE2aIvTkx2Qe4ruE1mEh/3vfuAc5Uube3jQhItVAb1AY9e
	 B6ZfMG5qShRxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7947EDFF766;
	Thu, 25 Jan 2024 14:56:29 +0000 (UTC)
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
 <170619458949.10743.594483740901211882.git-patchwork-housekeeping@kernel.org>
Date: Thu, 25 Jan 2024 14:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: s3c64xx: winter cleanup and gs101 support (2024-01-25T14:49:38)
  Superseding: [v1] spi: s3c64xx: winter cleanup and gs101 support (2024-01-23T15:34:00):
    [01/21] spi: dt-bindings: samsung: add google,gs101-spi compatible
    [02/21] spi: s3c64xx: sort headers alphabetically
    [03/21] spi: s3c64xx: remove extra blank line
    [04/21] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
    [05/21] spi: s3c64xx: explicitly include <linux/bits.h>
    [06/21] spi: s3c64xx: remove else after return
    [07/21] spi: s3c64xx: use bitfield access macros
    [08/21] spi: s3c64xx: move error check up to avoid rechecking
    [09/21] spi: s3c64xx: use full mask for {RX, TX}_FIFO_LVL
    [10/21] spi: s3c64xx: move common code outside if else
    [11/21] spi: s3c64xx: check return code of dmaengine_slave_config()
    [12/21] spi: s3c64xx: propagate the dma_submit_error() error code
    [13/21] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
    [14/21] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
    [15/21] spi: s3c64xx: simplify s3c64xx_wait_for_pio()
    [16/21] spi: s3c64xx: add missing blank line after declaration
    [17/21] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
    [18/21] asm-generic/io.h: add iowrite{8,16}_32 accessors
    [19/21] spi: s3c64xx: add support for google,gs101-spi
    [20/21] spi: s3c64xx: make the SPI alias optional for newer SoCs
    [21/21] MAINTAINERS: add Tudor Ambarus as R for the samsung SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


