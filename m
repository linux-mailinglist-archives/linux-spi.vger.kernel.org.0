Return-Path: <linux-spi+bounces-8078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3CAB36BA
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED7719E045D
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72E293462;
	Mon, 12 May 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGOHXBEy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62D255E20;
	Mon, 12 May 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051771; cv=none; b=TltW6+7X0xDFVGluHGYJ7/V/1PBrcTMOJ+caKOoNvoXfeULc/796IDvX4EQflAh8I0c02Gbc6V6myrBvGw68A3v5G9jIMap9/oyqkpSQAhVdqNrdE/eHEW7fwy7XrVeTsJRkdB3c5to1IeRjvhEeAeTaEGQdtTF1gbYNwdRNRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051771; c=relaxed/simple;
	bh=xE99g38G05kWVWQVsEMeTHQ9yIJhHcnUagPODqbgZOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hvRnfKlZdLpqRm3V5bz+u346iP7vp0u83/CJXSKXKxDrxRmzdSaJsHy13d/kDhNKe2B8uUYBrcn4mYo9YXaODTfdZ5k8ypwSr53PPjy2/PLPxhf+RjKsa5Np4j32td8h2oapcZ2TaC3qXXHIq3GdlvZjlql//FjgGOBnsPdp0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGOHXBEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E736C4CEE7;
	Mon, 12 May 2025 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747051770;
	bh=xE99g38G05kWVWQVsEMeTHQ9yIJhHcnUagPODqbgZOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RGOHXBEyhlL/RenWdnEwRHp4GPMF3l/O7Myx9N6q/RAyYvnDMHr8sQI2RJI442eAD
	 zElNcSxvAYgxHpdDUiZqLoE1Ym+qXiAlCvIugJeCGqXhzXGfn/bcIXAuHdW5dJL8+s
	 npsLsnrHI29OzhIwCAh0EEuRd+doMgd33N80EHT52lX5QBApwHrr77yInbLITnt8VC
	 304GObjTuHaR62aYAc08rfb9dmlWwBVeIuohv2A2DInmB7v6is4GxdSXnBsBm/U3my
	 yuZnC69785WoPNilRc8RMyv25iVqQGbd8IjrbtFl3iKq49YHw+BOXeQAYqaCtK5Yr/
	 MxWp8lP1iAhgw==
From: Mark Brown <broonie@kernel.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250327195928.680771-2-csokas.bence@prolan.hu>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
Subject: Re: [PATCH v6 0/2] Add more devm_ functions to fix PM imbalance in
 spi/atmel-quadspi.c
Message-Id: <174705176600.71095.8384606721205945217.b4-ty@kernel.org>
Date: Mon, 12 May 2025 21:09:26 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 27 Mar 2025 20:59:25 +0100, Bence Csókás wrote:
> The probe() function of the atmel-quadspi driver got quite convoluted,
> especially since the addition of SAMA7G5 support, that was forward-ported
> from an older vendor kernel. During the port, a bug was introduced, where
> the PM get() and put() calls were imbalanced. To alleivate this - and
> similar problems in the future - an effort was made to migrate as many
> functions as possible, to their devm_ managed counterparts. The few
> functions, which did not yet have a devm_ variant, are added in patch 1 of
> this series. Patch 2 then uses these APIs to fix the probe() function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] pm: runtime: Add new devm functions
      (no commit info)
[2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
      commit: 8856eafcc05ecf54d6dd2b6c67804fefd276472c

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


