Return-Path: <linux-spi+bounces-7775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF88A9DB71
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BE07A8FD6
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9A1FCF7C;
	Sat, 26 Apr 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN65lNPv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF83A926;
	Sat, 26 Apr 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677118; cv=none; b=H8y5danmWrFrwchXYjVYo99770oL7Dp66oDLzebwF0P5c16Y32OTfqSQvDxQ2Db2UVkGtE5TJqrEN3jYT5nSPg5Hl1/zx9FazhKG1DNO4k97KqmIDfsVfZgt/bpFU1xvCRRqDbYDmv7nOVfTZBzy6KVEsSWoj1EGLFM4Tlj/VOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677118; c=relaxed/simple;
	bh=QWynorMuxdxaqDDSFd0z/0rAPKadgWVwPtyQnTtZsqk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cp8yxdlgTT+Kv8dQlMUC+GbWn4BmIPpo4QdPg8MksjC/BU44aUK3ZnzCbfoJSNi65hlZoz287vszo750UShB53i1a8cHBcg/WSolakpfhUlH7IAHAsiLuFAc6nR420306yNyX2yhBcSxx94lBGcJ2YGNXNkiffIjSmj1wxGY2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN65lNPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D4C4CEE2;
	Sat, 26 Apr 2025 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677117;
	bh=QWynorMuxdxaqDDSFd0z/0rAPKadgWVwPtyQnTtZsqk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uN65lNPv0Cr6jJKum+zRiWKGjzBojavY+MHfq+oe0fqgWos6dFikTlyVhxusCiX14
	 Phu/gCRZVx7P54OLMtpzGRWRWaLMiE/ngj8iPp7xqYaMhXbQ22fsjU6X/8agJZ/9lj
	 GQpB9wBL71cs2qK7E93mQDQHszmvTkMUXofe4hTQ0sYOjqjUGa2fPGVInjJoi4HLXQ
	 OveXgxTJ/gE+KNC0wcGGlbhESxNIygsNFU7KAoweKXjiYrVBAIm9dAj5eiXYog7k72
	 g3qdIofWV9fuQ8jUlUR9RNxY0YtwBumJbU3qKUr3MNbOyNcC799N+Ln6BaJefj6Xpf
	 J2IC8u+g52SxA==
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
Message-Id: <174567711430.3942275.11314439022546984930.b4-ty@kernel.org>
Date: Sat, 26 Apr 2025 15:18:34 +0100
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
      commit: 749027309025a3bb4785ab8f20e18bc641fae848
[4/9] ASoC: renesas: rsnd: allow to use ADG as standalone
      commit: ce6949be36997f65d70bb6496bdfa4befff5bbab
[5/9] ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
      commit: a714b31225bce9ce2732f6193f28f371093492f0
[6/9] ASoC: renesas: rsnd: enable to use "adg" clock
      commit: 0cc88846cbfb3018c036a20390acb1e35de03e1d
[7/9] ASoC: renesas: add MSIOF sound support
      commit: c61caec22820f24bb155929f5cee8c1ccfe92f77

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


