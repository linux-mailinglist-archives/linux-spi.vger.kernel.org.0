Return-Path: <linux-spi+bounces-4061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4C93F9C1
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA521F23328
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82672186289;
	Mon, 29 Jul 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucr7hsEP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25418308E;
	Mon, 29 Jul 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267613; cv=none; b=CnQTNH6rXGc5UnE+5s160Jw9+Bzx1QFTFVxnhDhG8DEaz9fKBtf+EU4Cjch7pyrIHUth4AKQ1a6dvvujy2XlBrV2q9/z0PF2yzUZ6q+jg6aE33qUy/p4tNjy0u52yWAZW1R9oat8EDEbNOcmGlZaDKeLoZXtDn4kms4JzZ2B4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267613; c=relaxed/simple;
	bh=uylFLwNOYdKjfLJ3Fcuo4VxUycGhddVAuVf2ch5UZX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LBjNo4SyTACDsXpt/qDhvfKtg2m/9rC9Gj+drV7dBBPIXUfTJjGTYYb/2E47ypH0NwrCV1CHwoD3lTLWulrvfdJnfd/bSNTjIKDWPdgZ4oma72b7whm/zAf3PbFLZAgColNMlpPmYk0r32yzx8W+f6tbIvY3nTYCivjUorwNQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucr7hsEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F44DC4AF0A;
	Mon, 29 Jul 2024 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267613;
	bh=uylFLwNOYdKjfLJ3Fcuo4VxUycGhddVAuVf2ch5UZX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ucr7hsEPKCdBT5GMa8bR6DoDPo0ZlbNg/B1UXakUVJm5ulmVOHBnqYA/u8O702hcu
	 w9smP9bznSPE6OKHPpSV1P4X3GfTa53pA4suOKgpstIF2+M1leEwTaABKDiFaC3pT3
	 etdEkkDTb9kMSVB1fjd+ECacCuxq4EIs1WZdiNGZHblrjimntG0H1TeNpXJ6cfW9+5
	 pQwEnYbBAVAiFfCbDa1S2Nlqh9AUK0jxf7v6U8Qhu2V5ZbBQlB1/iuYNJgYQIq0RrE
	 30PEypX5QLJ1n+WR90g2Yy0uNraJQesl1kXtADmR5V2lE8uCHVd/zaP87sS7u6pWJ4
	 XDugO+1O2fZZQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240727114828.29558-1-zajec5@gmail.com>
References: <20240727114828.29558-1-zajec5@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: spi: mediatek,spi-mt65xx:
 add compatible for MT7981
Message-Id: <172226761022.71144.306390741868262406.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811

On Sat, 27 Jul 2024 13:48:27 +0200, Rafał Miłecki wrote:
> MT7981 has SPI controllers based on IPM design
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981
      commit: 158678bea637020dd6fc521536c5b07701447777

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


