Return-Path: <linux-spi+bounces-12176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC84CEB32F
	for <lists+linux-spi@lfdr.de>; Wed, 31 Dec 2025 04:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC27302E14D
	for <lists+linux-spi@lfdr.de>; Wed, 31 Dec 2025 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74072D3220;
	Wed, 31 Dec 2025 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgYukuRa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699352BF00A;
	Wed, 31 Dec 2025 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767152099; cv=none; b=mSAY+P7AlQYbH6Yq8Ik7hl1MPYn44mvQ5otxWYyKNlT9dXe70zyfSwvj94qp4BnChi8T3/yuQ90Fhoj4wgDv7MQhk/XEdsK1ek9dGLscuaFsm7cYy47vjwnXhV4Sp2XPmVUWFCBRDpGgAFZ5Lh+48mG2l77PACQIEKUKD4H6V0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767152099; c=relaxed/simple;
	bh=wMapKXQxs3IuueqfkTSrLzDMHhmsN1W0FcyCdy9SBSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OhrrpuorhdigNHsFkMZkTS1l/flL0+9mBECvXs+sPO0QRz+9cPKJUIQc8uhs1NovR7iFq01W+BeWccLGDfjNS2QeuLNf+1HHp3Gnf9Vx93DmwhvvvwIm8uqcJmtsxqY+WXVe0n2rM6JwSQ3AyO/AoNpJXBepp5ilw2tF5MLuBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgYukuRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A1AC19424;
	Wed, 31 Dec 2025 03:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767152098;
	bh=wMapKXQxs3IuueqfkTSrLzDMHhmsN1W0FcyCdy9SBSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgYukuRaoC1zpC2ya1upwuEzI2oYNI2hpRPh6GfLJF0M8c8ZFmDY/Pg7tY+Pb2ufL
	 VeFXt0b4o6Tb0fB5jvlIz2nCQSAZHRVkR2lPwbfjzxtyUrpntWZqhtgwdKO7C+mI1v
	 mqzj51zfKZM7GqTeVrcAtlBI2iVRg5id/Hlb/hk/iGaRhVPONn531q6yx32p8cPzgk
	 +nXXdcAR4OuBCEkeh7Ub2wyNUWxsPl5DyFqZp66fEyQtUycM4k9yvydD1JbYjR8rBp
	 b5atk6vBwsT89AxCKpqFxplO4J0GEDKno78mL0fefm2fLMjwp9uX0xwmHHMNElxX3c
	 fGYhBOtc2pzKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B596A3809A19;
	Wed, 31 Dec 2025 03:31:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] spi: mpfs: Fix an error handling path in mpfs_spi_probe()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176715190027.3416240.12168423155631763881.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 03:31:40 +0000
References: 
 <eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-spi@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Mark Brown <broonie@kernel.org>:

On Sat, 13 Dec 2025 08:48:51 +0100 you wrote:
> mpfs_spi_init() calls mpfs_spi_enable_ints(), so mpfs_spi_disable_ints()
> should be called if an error occurs after calling mpfs_spi_init(), as
> already done in the remove function.
> 
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - spi: mpfs: Fix an error handling path in mpfs_spi_probe()
    https://git.kernel.org/riscv/c/a8a313612af7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



