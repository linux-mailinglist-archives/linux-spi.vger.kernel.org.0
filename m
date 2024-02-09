Return-Path: <linux-spi+bounces-1230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2084F334
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 11:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C555D1F22CF1
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6B67E66;
	Fri,  9 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BruaJAGy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1D679E5
	for <linux-spi@vger.kernel.org>; Fri,  9 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474027; cv=none; b=ldJRPYLSkE1CLatPbWgs+ybFnN9Xk911++tWQmbT/l3uZOStftEOxsyy0xjhUlj+xUWKyzmEjTeVCl3X/IrJXHNybx8Y7fOuhDsoJSC3vRBTS8dvijc6dJGXmV4kyymRS6F1uwLRXFNYuZE94VDh8gLFneXdyWN1rzgko9AZe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474027; c=relaxed/simple;
	bh=Ii986GZ6YjVxsJST0TN4azqU3UeKF183UiBfdGLggOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XX/k1HOkqAvZ2lKWlNWZW6SVRcGavAG5FVi/Tv+1B4vNFkJ/9YUbPIxuNRw5m4qzkfDOE7ZpvMDyCdxO2/BPbgM8GD1cs1JaPcIr5Qqyhf042GaPx8G8YcBD952plbF6TOM4YSVFtH0VVv2CAdrPxtWEDx0TrDR6HLrdIaTNybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BruaJAGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEB94C433C7;
	Fri,  9 Feb 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474026;
	bh=Ii986GZ6YjVxsJST0TN4azqU3UeKF183UiBfdGLggOo=;
	h=Subject:From:Date:To:From;
	b=BruaJAGy+CEK67ZEyoKegcI0xLOjB/b2rjstclLuh2GA7vwCoKtw0W+E4oHvNR2b2
	 +L4F1w0oFUOJH6bHipxz5bmClx24PGrQzI7t+OEza8VS5P7wsQHy8NhKVZsSHoG5we
	 OpwLyhwaUHfdkC9K2Y2/HZG4vzSGHEdMNQ8LZ88tEqnvvvTlm0cRfvWgy8R10HTg/j
	 KPKEwEhD1Mn6B/QsYeOAnJ++UTVs9PzEiver1XoLrXcASXZ2uPgQY7+jlC06IcBn1r
	 ejLt0vbj16UrWqpuo4ZfXLxOBGxLxdE/uEfJeQHqZ5CyoIY5iJM3JQ590sHq3WgBdL
	 T6yjeotfE+Lsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BECB7E2F2FC;
	Fri,  9 Feb 2024 10:20:26 +0000 (UTC)
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
 <170747402671.10510.6730138554071200661.git-patchwork-summary@kernel.org>
Date: Fri, 09 Feb 2024 10:20:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/3] spi: pl022: Use typedef for dma_filter_fn
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824458
  Lore link: https://lore.kernel.org/r/20240208202154.630336-1-krzysztof.kozlowski@linaro.org
    Patches: [1/3] spi: pl022: Use typedef for dma_filter_fn
             [2/3] spi: pl022: Add missing dma_filter field kerneldoc
             [3/3] spi: pxa2xx: Use typedef for dma_filter_fn


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



