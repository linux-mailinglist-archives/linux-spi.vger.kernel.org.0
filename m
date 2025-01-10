Return-Path: <linux-spi+bounces-6310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC0A09472
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145521884553
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48262211292;
	Fri, 10 Jan 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3kN2FYw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A58210F65
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520971; cv=none; b=To0WnBB1sjcd0J1qpU+486j2tVtubd0z+8OhKpYOuz6aoXJYci2ByideA+g4K1L/pm09qqqnugmxxBHBY89sxqp82BdndDhtL3twCet3YdlpQp/KMG4hs70gu79hABFsZQrXc731k0q/6EEpHOm+22XkndaMWGT5JuItGTi5GMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520971; c=relaxed/simple;
	bh=jbF8Uu+d/UZUiya63qYJQBtfk6tsjePJ0fg0dK8OJM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sN7rtzce/NuRj4dFbNMR2Tgwv3Rpq5FMIHsAToiI+Dy+Fgv+AHG0HZMLXACxpIChZb6Ly3OVdaip2umcmj5emn/T8uboTomhsE6R09AUC+3TFFsiRTpHpargfioHnd0sS9S5RJwjCQO/bSLFh9Fo+1QNkxgPZasaNjqnYi+TZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3kN2FYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A18C4CED6;
	Fri, 10 Jan 2025 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520970;
	bh=jbF8Uu+d/UZUiya63qYJQBtfk6tsjePJ0fg0dK8OJM0=;
	h=Subject:From:Date:To:From;
	b=k3kN2FYwh77X+SBHDh78HfJOnMOCWfV5LD18a5BlgSPiGRvKwdJFv4dcnopluLs+7
	 jH3d8tHf+FI422Q3w9N3gvutOImgzl2wxwmESjxN/VpXcLcV8dDYT1zDUNPHXFAqf/
	 NWgyVCREObd4Ov+5Vm4nlW+0XcfDxL+nZWfHIV5YTOZLLkT3mFR5A4QxMrfdMz0Xdq
	 KUrab7qtmB9JX9vD5FBo2TqpblsvSx9mVCGQSzfQjzvd4sFJbJTv/pbDZUDfsjmBYG
	 bq4Xnn6KonOMgwAJKqtBM1FrKesr7EkqRocYUN0CF6zu6d9r2ltLR4ULC94UIBPL/z
	 9+EyDOqHNyJzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9E4380AA53;
	Fri, 10 Jan 2025 14:56:33 +0000 (UTC)
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
 <173652099219.2089248.68923688922138137.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Jan 2025 14:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi-nand/spi-mem DTR support (2025-01-10T14:45:02)
  Superseding: [v2] spi-nand/spi-mem DTR support (2024-12-24T17:05:45):
    [v2,01/27] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
    [v2,02/27] spi: spi-mem: Add a new controller capability
    [v2,03/27] spi: amd: Support per spi-mem operation frequency switches
    [v2,04/27] spi: amd: Drop redundant check
    [v2,05/27] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
    [v2,06/27] spi: cadence-qspi: Support per spi-mem operation frequency switches
    [v2,07/27] spi: dw: Support per spi-mem operation frequency switches
    [v2,08/27] spi: fsl-qspi: Support per spi-mem operation frequency switches
    [v2,09/27] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
    [v2,10/27] spi: mt65xx: Support per spi-mem operation frequency switches
    [v2,11/27] spi: mxic: Support per spi-mem operation frequency switches
    [v2,12/27] spi: nxp-fspi: Support per spi-mem operation frequency switches
    [v2,13/27] spi: rockchip-sfc: Support per spi-mem operation frequency switches
    [v2,14/27] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
    [v2,15/27] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
    [v2,16/27] spi: zynq-qspi: Support per spi-mem operation frequency switches
    [v2,17/27] spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
    [v2,18/27] spi: spi-mem: Reorder spi-mem macro assignments
    [v2,19/27] spi: spi-mem: Create macros for DTR operation
    [v2,20/27] spi: spi-mem: Estimate the time taken by operations
    [v2,21/27] mtd: spinand: Create distinct fast and slow read from cache variants
    [v2,22/27] mtd: spinand: Add an optional frequency to read from cache macros
    [v2,23/27] mtd: spinand: Enhance the logic when picking a variant
    [v2,24/27] mtd: spinand: Add support for read DTR operations
    [v2,25/27] mtd: spinand: winbond: Update the *JW chip definitions
    [v2,26/27] mtd: spinand: winbond: Add comment about naming
    [v2,27/27] mtd: spinand: winbond: Add support for DTR operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


