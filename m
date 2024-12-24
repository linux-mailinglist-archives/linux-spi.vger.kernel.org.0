Return-Path: <linux-spi+bounces-6188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0799FC11F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0391884228
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239B1C3C15;
	Tue, 24 Dec 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvGTxDBY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516D1D90B1
	for <linux-spi@vger.kernel.org>; Tue, 24 Dec 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063017; cv=none; b=tgsCzEplenXsgVojMAdFFnHQWkKfT55wr66/bPU8SEKwxoabnXNScCFFXuhV9HEnW7e3w+sA+eQxpvLBV4pOHYFs+XB9+rWdzy3Y04GUYUnkhpf7AabqszA5kdBDAhRVNg/Jo8c5Xjf1pYibq5mc4fv77tzEEE6od98CRmErMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063017; c=relaxed/simple;
	bh=HR2iYEAtc2UGmkhWGDsnVXP8g8/A3vxj1X1EPzCCrb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=it5KuDTmKoIH41A/EJfZ7DK1AI82yrSE5V1lSefStTGzuwwSkysAJ30k67ifRsaVtXS3qYxGMpP6J5P0841fnkHnBF05joSxlNT9jIr4+PrFDWyUhyvsCV9fKlFMi5F0O8nyM/FCpR2oowGIB2wYFuhoI5HFobZeDvSd6zs2Qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvGTxDBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DD5C4CED0;
	Tue, 24 Dec 2024 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735063016;
	bh=HR2iYEAtc2UGmkhWGDsnVXP8g8/A3vxj1X1EPzCCrb4=;
	h=Subject:From:Date:To:From;
	b=LvGTxDBYZzbPt0lOA/aOPMulGFyjSYOTDpTzbyC8XoJE0gfIpppKugKZ/TnwaiGdS
	 mn6qXRy8Oj/bJyUBMW8YZRo9ILawNJAuE6SXgPm8+PB4oD50IWWh/7D03LJgydJN1X
	 U41lWAr1xFs3RljIeItjcLUDGLMh2bRSoIaeaWANNbBiBJYV1NZlvmMY3gYKbm8NrJ
	 zIT0TDUlnHLovAsU2HnqgqojYjbgCOSVziQ2GSXPdTTpSsqC/zKW31d+4M0F8rl4xP
	 vH61XawFEz8ojBHnPDTqJA2nS1yM/UeyZiHgCEUBGCeCjQ08wVI4d8BpHN0oO0WBPZ
	 EAvBIEIc4BQUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38C6B380A955;
	Tue, 24 Dec 2024 17:57:16 +0000 (UTC)
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
 <173506303464.4166193.11435080380906387068.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Dec 2024 17:57:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi-nand/spi-mem DTR support (2024-12-24T17:05:45)
  Superseding: [v1] spi-nand/spi-mem DTR support (2024-10-25T16:14:37):
    [01/24] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
    [02/24] spi: spi-mem: Add a new controller capability
    [03/24] spi: amd: Support per spi-mem operation frequency switches
    [04/24] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
    [05/24] spi: cadence-qspi: Support per spi-mem operation frequency switches
    [06/24] spi: dw: Support per spi-mem operation frequency switches
    [07/24] spi: fsl-qspi: Support per spi-mem operation frequency switches
    [08/24] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
    [09/24] spi: mt65xx: Support per spi-mem operation frequency switches
    [10/24] spi: mxic: Support per spi-mem operation frequency switches
    [11/24] spi: nxp-fspi: Support per spi-mem operation frequency switches
    [12/24] spi: rockchip-sfc: Support per spi-mem operation frequency switches
    [13/24] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
    [14/24] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
    [15/24] spi: zynq-qspi: Support per spi-mem operation frequency switches
    [16/24] spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
    [17/24] mtd: spinand: Create distinct fast and slow read from cache variants
    [18/24] mtd: spinand: Add an optional frequency to read from cache macros
    [19/24] mtd: spinand: winbond: Fix the *JW chip definitions
    [20/24] spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
    [21/24] spi: spi-mem: Create macros for DTR operation
    [22/24] mtd: spinand: Add support for read DTR operations
    [23/24] mtd: spinand: winbond: Add comment about naming
    [24/24] mtd: spinand: winbond: Add support for DTR operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


