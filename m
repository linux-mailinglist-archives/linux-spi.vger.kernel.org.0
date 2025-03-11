Return-Path: <linux-spi+bounces-7092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4650A5CBE0
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494843AB433
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF62620F2;
	Tue, 11 Mar 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+KELLa+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27852620E7;
	Tue, 11 Mar 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713449; cv=none; b=ueeMU0BRJhNBQR10S6tZuxU4grwgzPHmg3a89aRDKWNbk4+YWbhee+wq4A310Pk2oJO/4PYDvU/OOtMeEFLXH2u58+Y6jAl+NTn5W7i6qjLaNq/P5hvK0wlcYLa9eZmR7Prgl5O60e25fjJXtPwni4Av505qboqLwOfb8c/SxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713449; c=relaxed/simple;
	bh=qymAbbIdLchqAtQBBL+pqPrr3X7OBh13PkUPlVUStBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r8abjYdFTl8VqUvN7EBWU+Uv3AzlTgU86ll+YiKva3DhYxIEeupQs+WYNt9z9aPVLurygQcfM30qzf5o6WqXRsvH3X7sMtZfETPtkHi7zVhlrWmk0yzX61HOmt4qdl1rlKQcqcpNjRUbnG8nG2f9vuay0//7rFfIj+G8Ef2hpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+KELLa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91835C4CEEA;
	Tue, 11 Mar 2025 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741713448;
	bh=qymAbbIdLchqAtQBBL+pqPrr3X7OBh13PkUPlVUStBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y+KELLa+knvBq8Y6mOU+ZaIu7WLEGPkUTLOIifEoLx07A7YpymGP0EZ6RUaaNcqCo
	 3k856Xxx9mvWBtD/kW1hpH8z5UicEuGryGX30wmmSHiELQpagjfqaS1agU6u+Ormzd
	 H13ylecD0RyKi1f6lDHHyTw5SNprB9ReQRFALFQOf50T5hCqx8I/BLFZvKoOPgiFWb
	 P9ZsWCFH5nLDGwZAdVzP6/CgAlYeJxf09jwL55/v2cRksfU8G5OAxxeW+m/CsF2CxO
	 rtF6kcxMyfgI0v5VfXCYgJEublnndzXB34xpUffIw0lnOZfkJyTfhcCp14pIApgvAE
	 Pp7+Yg2hJJ1MA==
From: Mark Brown <broonie@kernel.org>
To: Leilk Liu <leilk.liu@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 fparent@baylibre.com
In-Reply-To: <20250304024045.7788-1-leilk.liu@mediatek.com>
References: <20250304024045.7788-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH v2] spi: mt65xx: add PM QoS support
Message-Id: <174171344631.214660.9058567324727633834.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 17:17:26 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 10:37:15 +0800, Leilk Liu wrote:
> Enable Quality of Service(QoS) support to speed up interrupt service
> routine handle. Sometimes, a gic interrupt will be generated after
> SPI transmission, but at this time the CPU is in an idle state and the
> processing handler will be very slow. It takes time to exit the idle state
> and then become active. This will cause the SPI handler to execute slowly
> and cause SPI transfer timeouts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: add PM QoS support
      commit: 632556d5799a2b3e87dd5594a59245523b39cf31

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


