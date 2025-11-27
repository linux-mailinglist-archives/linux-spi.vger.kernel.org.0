Return-Path: <linux-spi+bounces-11630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B0C8FD04
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 18:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77834E2147
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5C2F5A2F;
	Thu, 27 Nov 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7YjLAke"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEC2F548C;
	Thu, 27 Nov 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266060; cv=none; b=OjBskgktM/7lRhoPv/SdRjNLEhGnS4VtG4JFGrFH46K3lw9uVZ+kBB9O5JomnzujtRGdgUhSyYwj507sWgh1QyVfTJLNkW9+KtuSC/5QnyI1i3fqe/fFYmxmUEcvHnV9h/IMFfjvTWiemX+JZlVIvNfRfnsMxQ0uj5vbFNPU+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266060; c=relaxed/simple;
	bh=7ymQ4nasa/Y4u+AtiT0d04YzvAbGRGb9jcNryy56N9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OGB8l8d7AppcoDDhNhOC2Qy6BA9QV3BuyxIxQRJr+WHHRp+P4w7w9WNZ/tML4chQ3hCtj7Pn28DI+RhC7CDewcxVaqqtesZBuqMhsxy4PfnaDS0y5ZkVq2RP+QnKug/3Ze5XLqD7Y+wwdfcBUJT4hDwskNuv3C2EDLNwdNkHL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7YjLAke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962D8C4CEF8;
	Thu, 27 Nov 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764266060;
	bh=7ymQ4nasa/Y4u+AtiT0d04YzvAbGRGb9jcNryy56N9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I7YjLAkehefh6Z7MmTFOrCN6M/dHA2iqG4jnWrALU44EtNwFYRtdCDE/leBTiK5FV
	 OdbZGdfmdqW/1fl/0MehcfizKWdQOhuUADfmz6+TcD8WNT8IseDvA25b9JkpGswDIb
	 zdRfPXZHIrfmUuhHmCLaLIL+RE4AzglGNC0qK2h/X2Eafi7RGHUCLVFJUNurxl5jRp
	 e8yTM6hDX2mr5CZUEtJEVXdB0nMGJa7yUU8LeqRdg0q2MuoMcIFlD96Ga6kVGNpul4
	 mdOFuRWnsJ28X6qO28lBWjGYTyN+YBe+ydKWnBeS6JnCjzqH3RneWTishXCSsmr6/U
	 FIcLgb8RmOEWw==
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
In-Reply-To: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: (subset) [PATCH v6 0/3] spi: airoha: add support of en7523 SoC
 (for 6.19)
Message-Id: <176426605736.114355.13405079869808770716.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 17:54:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 02:40:44 +0300, Mikhail Kshevetskiy wrote:
> Airoha EN7523 snfi controller almost identical to AN7581 one, so the same
> driver can be used. The only known difference appears in the very specific
> boot conditions, when attached serial console force EN7523 SoC boots
> in undocumented (reserved) mode. In this mode dma reading of the flash
> works incorrectly.
> 
> This patch series:
>  * add support of EN7523 SoC
>  * add spinand node to en7523 dts (so spinand flash finally becomes usable)
>  * updates dt-bindings to mark driver as compatible with en7523
>  * disable dma usage to prevent possible data damage if booting in
>    reserved mode was detected.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
      commit: 061795b345aff371df8f71d54ae7c7dc8ae630d0
[2/3] dt-bindings: spi: airoha: add compatible for EN7523
      commit: de59a8a3a1aab3a6608777f62fa098b5abb2704a

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


