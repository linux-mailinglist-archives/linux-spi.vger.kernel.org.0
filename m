Return-Path: <linux-spi+bounces-6112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25A9F6D3E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 19:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B08B16AEF3
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6931FA8DC;
	Wed, 18 Dec 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX0NZeSK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FA199EB2;
	Wed, 18 Dec 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546340; cv=none; b=eA+aCNGuOfgczJ1Zcsb5j70/hwiQD/iob2i2mV52JqC/viQick1+PWEcDeOkIaQ2dblDVEj1Z9WBLxrHyk2YlyPHiwQwyXMCkJLOy8gO0EbsyrjBWvZZnTQjZVTQgjPjgFOZjRC7oMJeNFTQrG0QT5lcHSSuk2V+cB2E0ZxAKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546340; c=relaxed/simple;
	bh=EYJF+tm2lF/oaIwevVc+IiA2NmlN2h9331fQsltMHzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JcdPwzf/Uu8EvZ2/VY13MEFCQFRMiwgwiE0NfKNBqTpwGC4zPhy/lNC9UWLo8sJ+FXhocMl0ePu6SCNO0Ar9Ma83d4Ryaj/HXAzhY4/AtRd5niFQSF77LYXdNoql7QuJHlO9uwemYpVZI2VB3FmFKJn8enHBrJIl+voc5bMHavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX0NZeSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD4C4CECD;
	Wed, 18 Dec 2024 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734546340;
	bh=EYJF+tm2lF/oaIwevVc+IiA2NmlN2h9331fQsltMHzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qX0NZeSK9iKXrS1cNnMemJ0f1PEFGMHpu4hHSQnYGq9ZGtjTo0KGbvOtUO7B8tNF5
	 FdRaBCaXDCKgO0aPW2cYig+9gE0A3uwGMMrvInWHKlTxPY3WM8rj1HMlli0XStyCT4
	 WtC8yWmTvPNM3a8nH8tWdT4Eoa4pDSvJbOfzlOBB50IQMGDQTf0GjPQff6J/H8ZI4Q
	 l7Xbr3scuNr7R9E3eZ5c8VTPtXeoUj6n9d2rNBOzquvM5llhYqqVJbXJVMs0Am2WKG
	 LLZi0Tt2R7IPdEPsYza2D1SRJHRl1vYa1MBlSTmcxU4EjFIvAaPSDtLzDP0vA+/fQ6
	 DjO+XOaFAG1JA==
From: Mark Brown <broonie@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Alexander Dahl <ada@thorsis.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241218151754.365519-1-csokas.bence@prolan.hu>
References: <20241218151754.365519-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] spi: atmel-quadspi: Factor out switching to Serial
 Memory Mode to function
Message-Id: <173454633792.186813.10395351752792939671.b4-ty@kernel.org>
Date: Wed, 18 Dec 2024 18:25:37 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 18 Dec 2024 16:17:54 +0100, Bence Csókás wrote:
> SAMA7G5 support (that was forward-ported from v6.1) re-introduced
> a bug that was fixed in v6.12, thankfully only in the codepath of
> the new SoC. But to prevent similar mistakes in the future, we
> split out the offending code to a function, and use this, fixed
> version everywhere.
> 
> To facilitate this, support function `atmel_qspi_update_config()`
> also had to be moved upwards. For best viewing experience, use
> `--color-moved-ws="allow-indentation-change" --color-moved`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Factor out switching to Serial Memory Mode to function
      commit: f663898d047a7a0a04d30732b1405ee007fdd243

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


