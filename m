Return-Path: <linux-spi+bounces-5649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559269C0DFD
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5131F21A54
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F2192D8C;
	Thu,  7 Nov 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWEPLDKW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B118F2C3;
	Thu,  7 Nov 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004961; cv=none; b=AUfDp7mMsvD33Arh6OCQplWRMIQdAaxC+/jDEdZn1a/eOgPt0vPcgLHFjbPdNr9fO5YaCHuPTF4NkEY6Je9hfgJ7e1kZrNAUUXpS3VKTHWPotPOEJKYI4wudmygrmiOoTmCUZjS6jsy3RawTxjEYEtS4Tt3MwSkzuHnQi80kUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004961; c=relaxed/simple;
	bh=AU6KM+4jQgRXOaINh8QzR6G9PXRof4Va4Nn84vc645g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RZ8vvnfyE1Dj7BaFpPUaOJpFvmmQPRHm+7neXTeo8kgFiAdo7ixS1x/e8WtP/jpGjGY9zf0IzPy2L2Y30kNBnTzI0lHU0HdNKTTyYpgvJjMHm8UhFiTtOxxPgKW64LoRMwmq/v/hW4X/V36bGNb2jQC4pYKVgA2Ap4a/r0/AtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWEPLDKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760BFC4CECC;
	Thu,  7 Nov 2024 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731004961;
	bh=AU6KM+4jQgRXOaINh8QzR6G9PXRof4Va4Nn84vc645g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OWEPLDKWB+KY3UdA/QlhUixH60oBwcg9PlYo7wH223Te3ORqw2H7BlnqUzRKP2Sr1
	 FGK+agrT1xFGh0MhOOkL+fo6EW97jCWYk5cDc3MjTGN1W4kzVmCZXtI5yQGJPAhIDA
	 ldbqfXJHVZTtPUbCoOE4OaBZXSnZTnJiZpRB7NC9WGFzyfTs2M5L9Q8CHD4sxDZ9ys
	 q5Q2ykJ7ADddmJFQIRdhi8dI0RL7oWdSKfnXPc4/3TY0ak4vkssVG1/jOHU1RbM2Ke
	 DkXbMeyDYR2eZ58qqg7SF9X2YPd6ghMuAXs4Pz7EWOZuo1ocsZWCKhmMEBPAdWSKJJ
	 fDkj8ks434EXw==
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de
In-Reply-To: <20241107-spidev-test-word-delay-v1-1-d4bba5569e39@pengutronix.de>
References: <20241107-spidev-test-word-delay-v1-1-d4bba5569e39@pengutronix.de>
Subject: Re: [PATCH] spi: spidev_test: add support for word delay
Message-Id: <173100496020.241412.394021907254195608.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 18:42:40 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 07 Nov 2024 16:07:31 +0100, Jonas Rebmann wrote:
> Support setting the word delay using the -w/--word-delay command line
> parameter. Note that spidev exposes word delay only as an u8, allowing
> for a maximum of 255us of delay to be inserted.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev_test: add support for word delay
      commit: 3ec83a377a995559c18880ff780a6873df9cc5d3

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


