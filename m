Return-Path: <linux-spi+bounces-10716-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8FBEB526
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 21:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5EC8505E9A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502033F8A8;
	Fri, 17 Oct 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er6SEQvL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553833F8A0;
	Fri, 17 Oct 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727681; cv=none; b=qXiVFdyVZzElM1aef98YoEo/csWuI4UlKxhf4LtvevvuCAnFIXpgtlvO/VFrlBtoTg/QPGRZDKRTDnLkdvb8z1+gRkWTguyVQ8bRu8Oqa+W9DxZJh9NXh5Jr14x3OXg/rPu5qSxOYwkLdU5ub8JdGsBzxRaKmugYNcWVipaiz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727681; c=relaxed/simple;
	bh=SEWFRPzFoC6acOac+2ZzlmwHvJCzxG02XBgDG3AfzVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jk7Bxfh7Cl6sTRPkbTa+QMO6LEdZWMezun60ppqje7X6Fq83ruf5/f1zZKXdU4JNSi9E3vtXbY5W7B3WCHpqTCW09ear2IAboi6I5IACLKQCg79Zdf2H2uK0+ltTWEm0EZueOTxcKPxxCYNeIN4H6IgzaaQMDueb9nEENxXszNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er6SEQvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABCFC4CEE7;
	Fri, 17 Oct 2025 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760727681;
	bh=SEWFRPzFoC6acOac+2ZzlmwHvJCzxG02XBgDG3AfzVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=er6SEQvLeGvPtYRk7VunhCRuihoxWVQnqRL523qIqSNuyVQtYrvKpGeihy4EU6TfK
	 kFcTNUB2wKoYlPLnCWtib5Dbe12rPMnSkhnjyX0sPUrszyyVIy+5lqZgm9tcGYYtan
	 9yN4Sv55eO4cK/iNM1StGPeNeZopmMbjYoNWmqjmxjylFJinVU8/AJvz3RTEpBJRSg
	 bN+QR6j3zxZeTjuiuYW/OpqX+UkjOtcNNi70DQRAfMhEt71eTrF1c40ejZjCZXtPNE
	 9lSvfMsEcKQhvzU7nG/G4GhMXjWGFlxvhbmsP/pHhS9SXhUMPN7tSgVNgGiL91ijD3
	 gPmvo0NKrTVzQ==
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: (subset) [PATCH v10 00/16] spi: airoha: driver fixes &
 improvements
Message-Id: <176072767774.228540.4249472913716298629.b4-ty@kernel.org>
Date: Fri, 17 Oct 2025 20:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Sun, 12 Oct 2025 15:16:51 +0300, Mikhail Kshevetskiy wrote:
> This patch series greatly improve airoha snfi driver and fix a
> number of serious bugs.
> 
> Fixed bugs:
>  * Fix reading/writing of flashes with more than one plane per lun
>  * Fill the buffer with 0xff before writing
>  * Fix reading of flashes supporting continuous reading mode
>  * Fix error paths
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/16] spi: airoha: remove unnecessary restriction length
        commit: 661856ca131c8bf6724905966e02149805660abe
[04/16] spi: airoha: remove unnecessary switch to non-dma mode
        commit: 7350f8dc15bfbb7abf1ce4babea6fcace1c574c5
[07/16] spi: airoha: unify dirmap read/write code
        commit: 233a22687411ea053a4b169c07324ee6aa33bf38
[08/16] spi: airoha: support of dualio/quadio flash reading commands
        commit: 80b09137aeab27e59004383058f8cc696a9ee048
[09/16] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
        commit: 70eec454f2d6cdfab547c262781acd38328e11a1
[10/16] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
        commit: d1ff30df1d9a4eb4c067795abb5e2a66910fd108
[11/16] spi: airoha: set custom sector size equal to flash page size
        commit: fb81b5cecb8553e3ca2b45288cf340d43c9c2991
[12/16] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
        commit: 902c0ea18a97b1a6eeee5799cb1fd9a79ef9208e
[13/16] spi: airoha: buffer must be 0xff-ed before writing
        commit: 0743acf746a81e0460a56fd5ff847d97fa7eb370

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


