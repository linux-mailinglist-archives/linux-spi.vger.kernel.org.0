Return-Path: <linux-spi+bounces-6620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB50A27AE2
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF0F1886AD5
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20F217675;
	Tue,  4 Feb 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd3ZTPAO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013A153828;
	Tue,  4 Feb 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696146; cv=none; b=Iw36y7ekem+qNtEld1V53iRUsti1WKwCVhOCii2pqGXU6rvBaCYNvLovrHKz9HaXYQIEpl6uVMPSgmHmSjXrnMWEnVreJ1YfDKIXrB4/nrSaD3Pi+W3adXNL9zYWLc1DbJ2GRLOw7nE8KnbYrWmTJZtR/IQndFKUsDePetBKY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696146; c=relaxed/simple;
	bh=vyhzsUhbRShvmlxemX/ptJCNlQzbChV8Cy/qY5fzQF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FqQ5kFdVw9MiLnbLJK0ndlK1g5aF/CAMe+8CyTDmS7w2H54Pa7w5Pv5AZut9y4dM9n233FUFQPg0Hn3HXOuUQQddTVZ7JTmdMRzA3UgTCsOgivMl5jrHWm9GAq2Jn1o3WnD/8DBHsxwta0N1RIYfOaVgc1VUbKj/3gzAKQ5sLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd3ZTPAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B69BC4CEDF;
	Tue,  4 Feb 2025 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738696145;
	bh=vyhzsUhbRShvmlxemX/ptJCNlQzbChV8Cy/qY5fzQF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hd3ZTPAO9YQB+tg/Wvq9rTN226/g8CF/W33+Y8nWQxjZoqK/Z4YgrFDO4oNy0eVQJ
	 sgGpP4xL2KYq+MzRqmvs9d/vdXigkuQ1Q/VzeHxPoat1GYMsYQ1JQsGlfkRNYo5ct/
	 EKJHb0rvdt9FpKd/x6JXIHg7mc3LwwOJWz54jJ+plDFcraJavQhQm1VzNkIWfWchY8
	 KOWJDKt1jNMWarcntMj9mRmCXo+q4YNh8NkkcMtlvdLWsDF/ONXQnBXnKkb42sOh7g
	 Hf0lBGmiefQJa/WxqaI9oltd7utdPJSvOLsBgrcrexwlknKkp+yCyfGnVV5RBrI5UH
	 Rtf399hn86Ejg==
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: kernel test robot <lkp@intel.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250203151249.79876-2-csokas.bence@prolan.hu>
References: <20250203151249.79876-2-csokas.bence@prolan.hu>
Subject: Re: [PATCH for-6.14] spi: atmel-quadspi: Fix warning in
 doc-comment
Message-Id: <173869614334.92129.12671529319133640728.b4-ty@kernel.org>
Date: Tue, 04 Feb 2025 19:09:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 03 Feb 2025 16:12:49 +0100, Bence Csókás wrote:
> The doc-comment for `struct atmel_qspi_pcal` had a typo in one of the
> struct members' name, causing a warning with the `W=1` option.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Fix warning in doc-comment
      commit: 4fd2707e3e71bfd5d4df4f4c9656a009f09dfc7e

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


