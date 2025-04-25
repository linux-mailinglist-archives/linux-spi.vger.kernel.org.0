Return-Path: <linux-spi+bounces-7765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFDDA9D132
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE97462E6D
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7E21B91F;
	Fri, 25 Apr 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGM1veaT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F521B1AB;
	Fri, 25 Apr 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608197; cv=none; b=e0TBtPrt/NxaLoFRSCnL8HmmOFqi3Ls4RkO4ba2LBsuT97F4PnCANOsK4CSlyYntTtv6UC17MI0+7ZmcDf5dOhNB7ekRJEgZbAUzQzQyUWel/jgSTnoo9JOS/CjrjjXm9rG8toKrwBQYjIjbSYC6aOcwZRFy4QEyLNaQbHkb8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608197; c=relaxed/simple;
	bh=xu+LZYG5C0xRUvosVpSNUcm82WBPS5ZJ4DDCffR5PaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLCruqJEy/O8T0XGQYgrZhlTw6fuCAqDWO9xAdtt9ezySKrvhemz3X1IxHoy5bOO2a3/Iqn94IZOTFjRl2mWqgxGXLD1pF0mj2UOszl/6hE/X9yd37CN4siCh353x+l/nfrHWHXskeBZA52EIMxt3xOfNFPC2SwCbiP/P2lVszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGM1veaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF34C4CEE4;
	Fri, 25 Apr 2025 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745608197;
	bh=xu+LZYG5C0xRUvosVpSNUcm82WBPS5ZJ4DDCffR5PaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eGM1veaTtQkife/GA793HF5sP63gRe/3WRKjGNSVmLxlRkgka5lNJ3z3lXQ31AXQI
	 eqWrfL83zPiP/sTymPn/BL/UQTkFqShov6A3/7yErCdTNCdFAsSzKQnD2GdqqT+8kp
	 UHBQWKkGGJEyzhUqGbZSqtkbooWX47Ia77faCamrT64/s4yKSdwGHUNbAy6KYaaP1I
	 2yySSUDVsRXRfpTceSBlRBjO5WmQis1y7lxGgtKs63f64G0riQozTt8MP+AsB5jJVc
	 NsTl2Gp1RSvOIfdwLgs0OCD2NjfVoX14LkRTr6xlHJBrTsnYyr1EG5bMjPTZvG4p9q
	 VfBb8CyUmveEg==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sunny Luo <sunny.luo@amlogic.com>
In-Reply-To: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
References: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
Subject: Re: [PATCH v2] spi: meson-spicc: add DMA support
Message-Id: <174560819538.249436.6003671320235963859.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 20:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 14 Apr 2025 14:30:16 +0800, Xianwei Zhao wrote:
> Add DMA support for spicc driver.
> 
> DMA works if the transfer meets the following conditions:
> 1. 64 bits per word;
> 2. The transfer length must be multiples of the dma_burst_len,
>    and the dma_burst_len should be one of 8,7...2,
>    otherwise, it will be split into several SPI bursts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: add DMA support
      commit: 18197e98353d931fc7bb2bb9ec671d3aa407831d

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


