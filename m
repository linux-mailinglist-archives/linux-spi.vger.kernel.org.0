Return-Path: <linux-spi+bounces-3142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5B8D4B6E
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 14:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D891C22A76
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF631C8FA7;
	Thu, 30 May 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCMZhsiJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922A16F0C1
	for <linux-spi@vger.kernel.org>; Thu, 30 May 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071744; cv=none; b=nZW/5ZHZ5/q+tqx1Nzjf6RPvgtI8SBhdgdfbp1mJHYlWocth7lDYlNpcdxWBxH3dbAWwYEVY4Fqks3aGFRnTI6NzlG8ik4HofiGvgFiEdVN9s450xWOQYnQIXUrxe1zvxRiqwZ+Xxc9CwVFyBg4htfUfVR1dTdVR5jWlO544ODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071744; c=relaxed/simple;
	bh=5KsI/h/faFaeDa4P4/Qoga/3ht/Q01HjKyGBYJoqr8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dopy8aiVgvMb8R+H+yqk0U3Guz3M/7vhv//Prm+8kavjRIgnTEX6vAd/eL5LBEDOVsOfF1llKgYg6UktrjMcJR4d8/cqsaa1XL3tfQdmFo1dY7hgtWTvpYXPH4Ie8zNu4gNRcerWTZemVL8pYDUVkIZOc6RFP669b1RK/RQjIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCMZhsiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB50C2BBFC;
	Thu, 30 May 2024 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717071744;
	bh=5KsI/h/faFaeDa4P4/Qoga/3ht/Q01HjKyGBYJoqr8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aCMZhsiJ5hwnGXOmdsQP+a0pgU7+Pz6Ty8sbiP9B9IIar3TfkoYmte0LvRoUjjZN0
	 YI5g3gw8chjqDGG2pVaEibChJNUTnEztWMA/JYYKLBF5P5/hb2Q3dM9405Zajgx+2T
	 YH8HhDvogs/NiH5mkh0YpOTlvPU4gHU7vAHKladqEor1ofKT4YbthmfyVBAFvmaMuT
	 XZompuDFyM7v2IqFLctHyVSIFskA/VyE+nhNv2xnC3vPwK/g/4IWruTiW8eyVs80Ah
	 krxZADYTNPh+pKTehgUPWdOX0NYnx59wDsC5WjBlQVpOohjfPYg9jE2tw1SSbdYATB
	 0Zw1WvG0Mml1Q==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
In-Reply-To: <20240521105241.62400-2-u.kleine-koenig@pengutronix.de>
References: <20240521105241.62400-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: stm32: Don't warn about spurious interrupts
Message-Id: <171707174254.885840.10764591194547229906.b4-ty@kernel.org>
Date: Thu, 30 May 2024 13:22:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-2ee9f

On Tue, 21 May 2024 12:52:42 +0200, Uwe Kleine-König wrote:
> The dev_warn to notify about a spurious interrupt was introduced with
> the reasoning that these are unexpected. However spurious interrupts
> tend to trigger continously and the error message on the serial console
> prevents that the core's detection of spurious interrupts kicks in
> (which disables the irq) and just floods the console.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Don't warn about spurious interrupts
      commit: 95d7c452a26564ef0c427f2806761b857106d8c4

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


