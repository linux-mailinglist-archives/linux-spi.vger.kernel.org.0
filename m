Return-Path: <linux-spi+bounces-2745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156B8BC196
	for <lists+linux-spi@lfdr.de>; Sun,  5 May 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABED1F21303
	for <lists+linux-spi@lfdr.de>; Sun,  5 May 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186B364DA;
	Sun,  5 May 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCC8jSVy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14238FA8;
	Sun,  5 May 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921401; cv=none; b=j9kCyPEglsP821Yt7/OysI7ZR4j4+Y5xzgS9KQQFN3jdoHlrcjVujQHdWnqGkkcxO3w5BULpEt2HcwgUzoGlGmNeskQdUg1lLjBt5KOos82K33drHbILMycrlL+jEV0lm8y01p/j1yhxpggLEsBrl2myW3oxKseUAwMlwT1oCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921401; c=relaxed/simple;
	bh=+msvvbhi0Hm6QR6CtJbWTfEdCEiJNKIExOn3H/A3k6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PdxpW7zybrWkOaJnK8mwFGMiekT2uSBSYmNN/LHOZ4OdGSvJ8pOHzNen02optN4HwZH8APcrByrbn/X7woHAJpU2mUvae3Z1K2zxw1OVdeu2D6wU3hY3UWh/IR4Hj96xU3DYwGdRDlm2zVioPx9QczVxnGF9wtj05XjZq4mjjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCC8jSVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86834C4AF67;
	Sun,  5 May 2024 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921400;
	bh=+msvvbhi0Hm6QR6CtJbWTfEdCEiJNKIExOn3H/A3k6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hCC8jSVyLmHpWLgo/GE1Eb1SGZItAGBNaWpJUqACd3lPLTK0Ho6NxAl0A35HGapnk
	 LANQIw3keMP6DkzhCu4Lz5j1i5peDWoYyHX/vhZQ5OdEss6W5kKAIioMzY4p9Rxf/g
	 9clPTmP5w5q95h0B/GACg9eRH4iI34BMKXFEp470H1q32KEmEHM9iritVBrR2siwvB
	 8LOITczpHNWz/kO/TFi8uNvoFv6/LM3z2ql8XyzEDJTurYAC7Z1klDwjNU8X49p0Ma
	 bG8FRKdXfs1MzRoJdQMaCrLAs07gq6ZZ0dyWFyV0eZfosa02JSiaV7IFj8mP9kDiiQ
	 T5dVOc+rhTZDQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
In-Reply-To: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
References: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
Subject: Re: [PATCH v2] spi: stm32: enable controller before asserting CS
Message-Id: <171492139831.1933695.13403053334190518230.b4-ty@kernel.org>
Date: Mon, 06 May 2024 00:03:18 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 24 Apr 2024 09:52:38 -0400, Ben Wolsieffer wrote:
> On the STM32F4/7, the MOSI and CLK pins float while the controller is
> disabled. CS is a regular GPIO, and therefore always driven. Currently,
> the controller is enabled in the transfer_one() callback, which runs
> after CS is asserted.  Therefore, there is a period where the SPI pins
> are floating while CS is asserted, making it possible for stray signals
> to disrupt communications. An analogous problem occurs at the end of the
> transfer when the controller is disabled before CS is released.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: enable controller before asserting CS
      commit: 52b62e7a5d4fb53ae3db3c83aee73683e5f3d2d2

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


