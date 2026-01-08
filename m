Return-Path: <linux-spi+bounces-12228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D0D05517
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74CA4303D5C1
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B502EBBA1;
	Thu,  8 Jan 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCIznk22"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24672E06E6
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895191; cv=none; b=Mt34+ntg/vKebCzg+wqaCOjSOml7/R830v3SGx7TNQBcMB3w1IQ+/8DgCLRzGfD5W3kQhQCTw570+zjvhOMYKpxVzaJ0lI963yo2MvgxbxvUuqWxrgNkCx3bB5Eo0G7g5j5AcDVA0AWcR8hA4qBm3E3LMBFxLeC664/q1ZC3g/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895191; c=relaxed/simple;
	bh=5xd3tvnzYvnUTK87s1hKRVn3VwrhV6IKPnNGx25YVBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gIJQ0JcWFlW++dj+kJxy0i53UU/29U7ZzRruPLHxCv4L5GZUvejAtaO2xYjdZTdq2iiE9v89up953n5onkYEWtn87+rmrdmQlfhToS9XuVcgBJzpN2UChjpo5wHTc9XyM2NcxJTmBeAkrJ+lNFUwsjjAIc5mzBZckg2WgykqI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCIznk22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCA2C116D0;
	Thu,  8 Jan 2026 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767895191;
	bh=5xd3tvnzYvnUTK87s1hKRVn3VwrhV6IKPnNGx25YVBQ=;
	h=Subject:From:Date:To:From;
	b=RCIznk22AAd8SbRcdcs0h/Mi5DszwpnHDPqRJhQ9R/+tBe4x3fzmZOfiSkunCrde0
	 S3yh5BbI8R5ZNjmnoyC13i3vlOAX7uuD3PdIOu/UWHczvOXjsGLHh7w+NpRs9Nv58r
	 tD2EwS0xobLlPEnvvfnS+1dxGkuNQEulLNjRCI8wYmAteS5/vIRMC1dQ5LpLoZIjtL
	 A+CfUUjFr1hrhRzjUwRJaFXCIpflYQWvEMni3V3XuZpiFZ9EtR2aPyoQGFzexxi4Jm
	 wYAdMRRariI2/SWjv95b/4/cl5V5OelL4tzJEUnOpKvn1eCI++1YzH029wPbh8U8pZ
	 TZnHRpnYHA7pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29DB3AA940D;
	Thu,  8 Jan 2026 17:56:28 +0000 (UTC)
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
 <176789498759.3748592.6225268092756777419.git-patchwork-housekeeping@kernel.org>
Date: Thu, 08 Jan 2026 17:56:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: Simplify devm_spi_*_controller() (2026-01-08T17:51:45)
  Superseding: [v1] spi: Simplify devm_spi_*_controller() (2025-11-27T19:51:33):
    [v1,1/1] spi: Simplify devm_spi_*_controller()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


