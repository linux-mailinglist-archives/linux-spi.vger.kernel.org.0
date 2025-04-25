Return-Path: <linux-spi+bounces-7773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD0A9D5FA
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 01:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AB89C2604
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FC242D68;
	Fri, 25 Apr 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdRV3vIP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D6296D09;
	Fri, 25 Apr 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622011; cv=none; b=OYDk2v3A15uph1NrY/oKagmeUC10QDym6pt0j8szwteHKK1icaIDRMgAjT0XKwmIpYOsDo5t7Wblehwm7ctGn5l72uHhjHzPptPNhwdr5LB6PtYcb730sX+DvBXOsDKKpNclb/MT5gAX1cY+3wjZW8T/VMc3K79rBfPcEszL360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622011; c=relaxed/simple;
	bh=oUEnrqD2+9dOuYjzTrjG5PiuI832wU+JdlseXm2eCmk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jAvnf9YuuukwMdFkS0/LHzu4iK5RSepxSpwUtGBpATHZvnNLhkSwUA8JWIdIF6yCgIKTWSkfHGV7vtYER2mKW2eQnp783RvBRjZNxr6cWsqFuLJcEtD3MH2C0BwT2E0D0AqathfVR78fa/eQWghOO5SjIiRaxj/F4J+EQw8e6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdRV3vIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FA6C4CEEC;
	Fri, 25 Apr 2025 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622010;
	bh=oUEnrqD2+9dOuYjzTrjG5PiuI832wU+JdlseXm2eCmk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=HdRV3vIPiIGKHO7TMpEv/mkPd1Q2fvLm3cUsN5pGlgirGN7BLHzWJuo8xHUa+woBh
	 8A+cnep+OHlDgvqimEmfPdValVXOyE+oRdJOYqIqK1BoM76hxtPsY3aoesesNBabzI
	 0QgOn2y78bWTW4saLgNexCUKCCkw0qfUY4v3US+pRoNgPu3D+FtCTvaH8wKzF/B3SR
	 nulo4lLB6vrHmgihcf/5BeklBWQVoWVBZkfwqEg9uXiZROMBG6oHcykE4Sr3xq5b5m
	 U1g/bwWb0fglYwN4LMus6kxBkatF+ZcYT8v+BAeEwIjBPaImcTErBnR3PU+BDasDZR
	 OHCUW9Q7t0cNg==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: (subset) [PATCH v4 0/9] ASoC: add Renesas MSIOF sound driver
Message-Id: <174562200689.302167.2459698940161068697.b4-ty@kernel.org>
Date: Sat, 26 Apr 2025 00:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 17 Apr 2025 23:22:40 +0000, Kuninori Morimoto wrote:
> Cc Geert
> 
> Renesas MSIOF can work as both SPI and I2S.
> Current Linux supports MSIOF-SPI. This patch-set adds new MSIOF-I2S.
> 
> Because it is using same HW-IP, we want to share same compatible for both
> MSIOF-SPI/I2S case. MSIOF-I2S (Sound) will use Audio-Graph-Card/Card2 which
> uses Of-Graph, but  MSIOF-SPI is not use Of-Graph.
> So, this patch-set assumes it was used as MSIOF-I2S if DT is using Of-Graph,
> otherwise, it is MSIOF-SPI (This assumption will works if SPI *never*
> use Of-Graph in the future).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/9] spi: sh-msiof: use dev in sh_msiof_spi_probe()
      commit: c4887bd4b35b225f4fe26d2d459c76236e27a759
[3/9] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
      commit: cf0668184d1d2f9ad3f98dd5bbe0ed4d9d090eaa

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


