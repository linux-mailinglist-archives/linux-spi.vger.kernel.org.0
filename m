Return-Path: <linux-spi+bounces-8259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D973AC0F15
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B333BDD85
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FD28DF37;
	Thu, 22 May 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1cvvu8R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2828D8EA
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925776; cv=none; b=RWy0irNc4SLDueH4aoODOfGm3pCHt0n2G5mHAOlOejfbvSOEAEFNJkQWUVPP3i5UNKvB0YFco70DfbH0dm5sVSosKu5QjC3D2RJ5BvTIZwK3xODA4Y2wtkBn1UW3tUaDvfQD+fMl4fyWQp/66+t34Y5k45nyv9dEYNgm3dGvWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925776; c=relaxed/simple;
	bh=MPuz5LMLReqq9u4VHoiViDUBtv+SX5PCPGl/UA/5pf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Mlusvg5qxSFQTBSVPv1r6fsBiKCciXIsXJJNU79mDu5e5X9A9o9YXZtGsFqcj5mxUkkzP0KDVQ7ZdGZ6XjSNrPunzpQCqNulO9/doJLVmL7qCFqNcUeODUfyRBCtcqANcpWofHOouJIO1WuhqnQm0D+Zui7ci55np2j90qM/HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1cvvu8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8301C4CEE4;
	Thu, 22 May 2025 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747925775;
	bh=MPuz5LMLReqq9u4VHoiViDUBtv+SX5PCPGl/UA/5pf4=;
	h=Subject:From:Date:To:From;
	b=H1cvvu8RxGiVWzIrui/sQQ09a284ixReThM4DKH2iRchBnpY+TmQtR+MTLjil555M
	 zKVtrjZ1eYEoLniHt6eUDvDPIG9ahEIcEEx6e4c50/OFT+ZB5fTsP/lufZP7kIdwMw
	 rSsg4dy+jmhsq7s/XLO1GB+ObTi3cUaz6h1PouSl+DQg0pB9R7yLIPMHOcaRyMCkCN
	 6B27W+fd29H489ySkSMfXh3poPMcZpcC/R/l9TV4N6k3T3zfOQyzv339YwTY4GXnwv
	 Lqz0zdrN6b+CmAhL+QaZfMNnZ1jhS7smTEnQXTZapBljLNaEawwxxA5kmrcsUmagfM
	 YncYfuv9CVyNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100F3805D89;
	Thu, 22 May 2025 14:56:52 +0000 (UTC)
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
 <174792581099.2905597.6248902642024587993.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 May 2025 14:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-dspi: DSPI support for NXP S32G platforms (2025-05-22T14:51:29)
  Superseding: [v1] spi: spi-fsl-dspi: DSPI support for NXP S32G platforms (2025-05-09T11:05:47):
    [01/14] spi: spi-fsl-dspi: Define regmaps per device
    [02/14] spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
    [03/14] spi: spi-fsl-dspi: restrict register range for regmap access
    [04/14] spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
    [05/14] spi: spi-fsl-dspi: Use spi_alloc_target for target
    [06/14] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
    [07/14] spi: spi-fsl-dspi: Reset SR flags before sending a new message
    [08/14] spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
    [09/14] spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
    [10/14] spi: spi-fsl-dspi: Enable modified transfer protocol
    [11/14] spi: spi-fsl-dspi: Halt the module after a new message transfer
    [12/14] dt-bindings: spi: dspi: Add S32G support
    [13/14] spi: spi-fsl-dspi: Enable support for S32G platforms
    [14/14] arm64: dts: Add DSPI entries for S32G platforms


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


