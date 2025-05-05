Return-Path: <linux-spi+bounces-7912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA23AAB13A
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 05:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72701BC1751
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933C930E698;
	Tue,  6 May 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRzyQ6r8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3823103C7;
	Mon,  5 May 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488803; cv=none; b=HkDEQh8pbQcyPg2i4ftMbgw19Z6Jz8TsOi6DNskcRC1GWL2UNI38vmLRQJKCIua7CUD3lhlaS2atghenhLEh5xXHWnBI0V+HEgLcV/XJu2pcJ1YYmdqyTOWrBBUTx5+GIJqOnmRHs4MWmiWAEd9IfDuzelVE2mDvL+49fZD5L7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488803; c=relaxed/simple;
	bh=Bg0D5bM4px6WDECfyD6pFnXIQggw12tfFDhXUC8EunE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZY6GjA4h7FJ4L9Ga7osZp46v0AN62sEJ2RH3cnVa/3RUz7Rr+EO1ab9RMiBrXM+u9qUqUNC661eoOOFPpcZYACstcivEcTCdQpesDSG4h7koeyUQfWasKHhGQU6hWtBCsA3I5EclZJgLHY11cj1a+CbfHIo0f9H3UJPH4LKwgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRzyQ6r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F057BC4CEED;
	Mon,  5 May 2025 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746488802;
	bh=Bg0D5bM4px6WDECfyD6pFnXIQggw12tfFDhXUC8EunE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bRzyQ6r8ZQwsZH6e2tj2AzCTpwX/nZ5bTdspUziancfKWdvHW0YgOKHVkiqdutEuJ
	 UZLhwbhWX8fYj1OzJygIe6AKlw7oxWGx4t74bIPqRdxfU24dz0ctZ3Ynp0bNoZXw/K
	 /72r8Hjhq6BNdbot89MLbuTO6jTk/D8TqlySCBqVzalJLtwsle2pQEPwhQLfN2jVKP
	 40c+aI2dDkI8sJlpGL3P4myyWAUvFlVFpyP0LNWQo8yo7Re6xuYvfg7g8jcE8m5dWl
	 uaYRsJgCfLE5Ksnemlr03WQe79VTIIApbGTPkEQKV7xs8+wCoysdghxVO5OjuyMuFn
	 ADqiaMFkLxMig==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
References: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
Subject: Re: [PATCH v2 0/3] spi: Minor smatch fixes
Message-Id: <174648879734.4120313.21841413252828568.b4-ty@kernel.org>
Date: Tue, 06 May 2025 08:46:37 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 01 May 2025 17:01:58 +0200, Krzysztof Kozlowski wrote:
> Just few fixes.
> 
> Changes in v2:
> 1. IS_ERR_OR_NULL->IS_ERR in cs42l43
> 2. Drop patch which was already fixed in the meantime by other person
> 
> v1: https://lore.kernel.org/all/20250104205437.184782-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: atmel-quadspi: Fix printed error code during DMA setup
      commit: 075812e45e9ef1b882aa66b9d122d8b8739aae59
[2/3] spi: cs42l43: Make handling missing spk-id GPIOs explicit
      commit: f4ea37a485e97234af9550b63c52394d029037ee
[3/3] spi: cadence-quadspi: Assume device could match via platform
      commit: 222a87f6b94f6f177e896d6fcdc7881480344e34

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


