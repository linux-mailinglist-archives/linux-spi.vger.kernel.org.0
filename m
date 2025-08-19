Return-Path: <linux-spi+bounces-9536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38674B2C892
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1297A794A
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D4244186;
	Tue, 19 Aug 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mucZ1rha"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B22EB846;
	Tue, 19 Aug 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617907; cv=none; b=HgNvvTLX0X0YHLcEzSVTHP1u1MVEWXN+HeNnzL4e8sGMw6Qz88dUrPcwyJV1bmwzQNQuex3RnDI1jE/5cCIPRrtvWxYjMhoWiEAd9DOn9/iD+0B4Gshg+HL2AgG2YEalqOrV0KeHLdli7Uv5lQBgxFH6Z8bjJTQOeHY3//VtNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617907; c=relaxed/simple;
	bh=WRnEY5mnXKIAn8fJoPOREi7qTQPCOerE9LQWJjKAxg0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F8Ug7O2sRHaWiXREwSsCsDtM3mhJzZCNKdODLAry8WKTfH41qKqH+Lvgua8SwfFxaurSmeuplZDsXvquFGuz5QLAMhFT2bNBYpUuGecOhgwTdtXcl3zXiDRoQzj6XvZJpJpExnvVWpnVNNicD5zNgS1jI9RRQBfUkLc6gQyyFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mucZ1rha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3476C4CEF1;
	Tue, 19 Aug 2025 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755617907;
	bh=WRnEY5mnXKIAn8fJoPOREi7qTQPCOerE9LQWJjKAxg0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mucZ1rhaqeajrsUd6si8VwwKDekoCZtEaVRe3PKN6ewpUk+A3cB5QVI3Sz1ZVeAXS
	 1/51zIPrjqV9MKtuIcV9wdq5IJPSAlZAAmmgQq33Z1oIJVzqKrMj2hd1vQy+H/dY8s
	 St3IW5W7mo4hreHWuJAvFvBojODnXbSuFcsBiCb+IzxEKIB0AHnal3kXC6g7jKRLTv
	 hjy6+vCTK6cs5r9MDTcaTDY5RRZADt54bHPsuYDbd5cdm50ryyDhKdrM1F/u5ArQVi
	 3TletLwvnkJoy1ES6kUpFoSzl67MX3uWMsuF/3iKUnZtfCK4SdltPhSZF7sixx/ovL
	 t12se6xOErbRw==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250819040239.434863-1-rongqianfeng@vivo.com>
References: <20250819040239.434863-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] spi: SPISG: Use devm_kcalloc() in aml_spisg_clk_init()
Message-Id: <175561790566.178223.1385181209019603763.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 16:38:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 19 Aug 2025 12:02:38 +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in aml_spisg_clk_init()
> for safer memory allocation with built-in overflow protection, and replace
> sizeof(struct clk_div_table) with sizeof(*tbl) to shorten the line.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: SPISG: Use devm_kcalloc() in aml_spisg_clk_init()
      commit: c1dd310f1d76b4b13f1854618087af2513140897

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


