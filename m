Return-Path: <linux-spi+bounces-5199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888F998CB2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C259282745
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391821CEE88;
	Thu, 10 Oct 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHfk2wEx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FE1CEE83;
	Thu, 10 Oct 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576183; cv=none; b=a0j+o6KiC7J+iioItiWF70yKI/pHizRKJeWqx87DFSOnjUQARQQsOugqx2HBHu19Mb99OKZZaLMBU+XlT6VAMt5PT/KybobFVhnsC/YShJEEbXpXPpGUBuGIR5N0u2HCuPYLfwqgLBYOqM0f10JxWDznxJZIF66gro8DtVxRFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576183; c=relaxed/simple;
	bh=rAq/G8gwCb1+rwQzT/Y8bXAu/xz5ci3OpT4Ooh+KTUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kCT8Ctwb35Kh4zyBLcjNB1OhDhnksup6M1PG8bLie5v+YNmn5JOhOgirvj4LtsjXibukwTaHuF5URrqdY+zyZgA+5s2pXuuKHYizKtnZpjazGWrkGjcXGIJI1nLHQGZg2/Ipgy5zPs7/mE2v79ErCsMXQHIFBUKgH5fyBOeoslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHfk2wEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A24C4CECC;
	Thu, 10 Oct 2024 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576182;
	bh=rAq/G8gwCb1+rwQzT/Y8bXAu/xz5ci3OpT4Ooh+KTUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CHfk2wExM4tvXO7/iZhHlO35in43YiPzcfc1UARpkPfi428kghCZ2aPybwWAJalB3
	 BAuDAKRqLLeKEHcEUJHzEHBydE8WvBiEP0OoHf83xTssqg1TN5OLIWQ188DdAHRvp2
	 8bYeZ8q9SjEE9De7uiMYEcrNcI2ZH2awrpUGy/U9XQJCFbKRRrztXW48D1DZrKyLKQ
	 V5NESYJB0TXLaW3CvyWwugOlUrLGDVhdG8VAtt+EzDcjfWOVDxQm36UVxZ3aBcLBK+
	 MNauGk907pjUcT5f8EoqjFzaAadp3KmJVH2A0PGtsFPM6WBTSqMZ4IV75e8r8WYPga
	 iCtjwE8+L1xSg==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com>
References: <20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com>
Subject: Re: [PATCH v2] spi: stm32: fix missing device mode capability in
 stm32mp25
Message-Id: <172857618035.3841267.4703963999206968322.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 10 Oct 2024 15:33:03 +0200, Alain Volmat wrote:
> The STM32MP25 SOC has capability to behave in device mode however
> missing .has_device_mode within its stm32mp25_spi_cfg structure leads
> to not being able to enable the device mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix missing device mode capability in stm32mp25
      commit: b5a468199b995bd8ee3c26f169a416a181210c9e

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


