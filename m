Return-Path: <linux-spi+bounces-6844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54719A382E3
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 13:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594D716F16A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CD218842;
	Mon, 17 Feb 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpQ50d5h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51C16C850;
	Mon, 17 Feb 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795068; cv=none; b=WZV3lODtBwwSVPdL6dOULPbw+AHk7AfejHCCbJn4428nLpAUElI9fkzNLIqd/r7uTi11k/1dqRrotf8py89UQ3SJ07zvsvToWDfy1kIe17uXkqrn+wrZGPy9A8SfdsMAA1/r/SDQcgZ3LdahLP0taY4HCUj4oNdITZdIA1Z0TN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795068; c=relaxed/simple;
	bh=TJYEevfjJhbZc3qn+igox9ieijgb5voH+UahcAHp2sQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KB7Jp4Ycx+s4J/WDqRHtGK37fcvmXLT+2xLZ/QJ2COo3Y/sbh5ShbW7FvfwXC7n4fcdWYDexPsA59euzlIzK9gTxrbmCd1qJuM5xqBFosaS6NZ9T8xMqDWcmGTJSu9efGbS2Mu1lHef6nQXd0YGYXqrZnpLInO1DPlay8fdr9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpQ50d5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC7C4CED1;
	Mon, 17 Feb 2025 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795067;
	bh=TJYEevfjJhbZc3qn+igox9ieijgb5voH+UahcAHp2sQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EpQ50d5hscsOE0Mv4QRUAC0NqvA4X69TVieE9LcTkTbnJWv4xMJDBFDpfUA11Ylve
	 EHnNrEBnZIVxoX8eRoZP6Kkd257eVQjAfUPF+pQZlChsSdwu7eBy5M1FaW8mWPRTRe
	 mweuQ5r4oHGuYRJojkE+XrpLyuQPvRwYNJBooHdULvt00PvhNPBdURzl591Ho7M7vo
	 BfYVNqJ2NRDiNMWiQidEr5A7Wx6CQYuAN8bcAgoPcdPNcf5cCgZEuxc9ytkPkEyqCa
	 ovaCZve7OyecQpYl28rdMKjB3rnbf0xGTeFy7kumPZq4mb1Ww2DlS6n715heyZFcEE
	 ocRLBWot9rJxQ==
From: Mark Brown <broonie@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20250207122145.162183-2-csokas.bence@prolan.hu>
References: <20250207122145.162183-2-csokas.bence@prolan.hu>
Subject: Re: [PATCH resubmit2] spi: atmel-quadspi: remove references to
 runtime PM on error path
Message-Id: <173979506523.23527.7426002054333724142.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 12:24:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 07 Feb 2025 13:21:45 +0100, Bence Csókás wrote:
> There is no need to call runtime PM put APIs on error path of
> `atmel_qspi_sama7g5_transfer()` as the caller (`atmel_qspi_exec_op()`)
> of it will take care of this if needed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: remove references to runtime PM on error path
      commit: 99e6ea912340d6a262a60d5dd0c87c5e7b2d6ff2

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


