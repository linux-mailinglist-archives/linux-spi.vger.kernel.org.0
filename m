Return-Path: <linux-spi+bounces-244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06A80F16F
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD25281708
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33076DCF;
	Tue, 12 Dec 2023 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyja94fm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EB745EF
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 15:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A947C433C9;
	Tue, 12 Dec 2023 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396003;
	bh=1EoyiyiWGTyfjx9FO3oP4RxDZ5ISUcDITWVN+yHSbI0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Dyja94fmBpK/L7pgyIsyjQdnu6utBkN7DE1U8nqzNsnYSaCvd3akMQE/Gh6sRxno1
	 wiV51z62brySE+b75GHzRT23HVR3bQIQUaALldvP8WOePsZj09DnKN523YMKvDY3ty
	 jphTRdcoTSkqZUx8v4ERMSy551F9WnaIgtf+bdC1yqsiQ35234cKJBvhrmznNazrU6
	 TnvIeM7VXbmikYuZVAG93gK8pN3gSS6ZYuCZzjZSt9QSXqhRcYyZVyT3GmHa9c0dFC
	 fF54MUhDZ0ylcfkhdbfJgFh82SoWdxWf93w7pl5LAihxp8xMtN4ua1YcfWceWaOa2V
	 FrSa0v9H4W1OA==
From: Mark Brown <broonie@kernel.org>
To: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nam Cao <namcao@linutronix.de>
In-Reply-To: <cover.1702298527.git.namcao@linutronix.de>
References: <cover.1702298527.git.namcao@linutronix.de>
Subject: Re: [PATCH 0/2] spi: pl022: clean up some unused variables
Message-Id: <170239600215.81606.18013257147179685580.b4-ty@kernel.org>
Date: Tue, 12 Dec 2023 15:46:42 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 11 Dec 2023 13:49:13 +0100, Nam Cao wrote:
> The driver was refactored in 9b2ef250b31d ("spi: spl022: switch to use
> default spi_transfer_one_message()"), and some variables are now unused
> because of that. Clean them up.
> 
> Nam Cao (2):
>   spi: pl022: delete unused cur_gpiod in struct pl022
>   spi: pl022: delete unused next_msg_cs_active in struct pl022
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pl022: delete unused cur_gpiod in struct pl022
      commit: 4c6dd33de9d3148909bc403d394f527bec4aec27
[2/2] spi: pl022: delete unused next_msg_cs_active in struct pl022
      commit: 3c49d848d2d3c6fe46522e4d750fc3a18e699997

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


