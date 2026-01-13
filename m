Return-Path: <linux-spi+bounces-12327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533CD18867
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 12:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3653002D08
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0538B7A9;
	Tue, 13 Jan 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLF0qILW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7038A2B5;
	Tue, 13 Jan 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304572; cv=none; b=OloEPfY4co57lw3pa1dlhnNYiK7/12D3rHDNMHlP5It2acziuWVvBt4Srane2O6p+v9plBQVMS3+itbn40cgBWd07CAJNgzMmbp8TAj/S3s25mPGYlRbqFExrZCy/ftHhE9QCtkPeJfs0WBC4rh2ESNkM5UDgXEL/Cc9qE8qiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304572; c=relaxed/simple;
	bh=8ZCIZAy2nNpThhX5goPfWn6peYuTFVOzBqggm9jLdYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=anhbbVtHPTmlBKcE6eAqcZ2EXYAtkkEx3mcVDpQd5pazyqT4w3ZMskxXEZQTDNYHg2opCBNUc9lgc0sbHjfgAzmWp5Qk58TRzZfLjIw/KgK2pr1aosjYUmBMiZs136QSFUc+Dhzw83uRluLHEeT32nfigEqFhht55zpvUfCoqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLF0qILW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A74C116C6;
	Tue, 13 Jan 2026 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304571;
	bh=8ZCIZAy2nNpThhX5goPfWn6peYuTFVOzBqggm9jLdYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jLF0qILWfJSSPsB0tCWU8I2oEnZg4tIJRINrpWsKdIGY6coGzEWna9cXjc6TpfVVa
	 bWhCzXYeGQA6aTrF1hAR3/CP9CCziRmU5XX/f8lkkzIgEP4l7FdVL7x5Ie00RGYBKB
	 C4QEaySQTfYIXOLsgJTetxHnWMUwc5PbwyTCFUrBBie6va6++eEyyW4X4BKVAS9CRP
	 icJYXtRKa9fJ3j08A4cELtESyUT/0PF/8Os4l0WtzIP5QNXw7TYOw3tyXpyP3umCwp
	 YGlTm4fyH9QsX/dFhWxNKLseXLDPsSoOwt94bRKqL62YemonmMX/gp3Vz4GZjS3gmg
	 1QU1rqpEkCJ4A==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260109075032.3287109-1-vz@mleia.com>
References: <20260109075032.3287109-1-vz@mleia.com>
Subject: Re: [PATCH] spi: dt-bindings: nxp,lpc3220-spi: Add DMA specific
 properties
Message-Id: <176830457004.25724.10171206431125136162.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 11:42:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 09 Jan 2026 09:50:32 +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SPI controllers supports DMA operations over rx-tx channel,
> which is muxed with SSP SPI controller DMA.
> 
> For additional reference see Table 69 in NXP LPC32xx User Manual.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: nxp,lpc3220-spi: Add DMA specific properties
      commit: 8672e4b51adfc57150f3862b1665faff0acf1bad

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


