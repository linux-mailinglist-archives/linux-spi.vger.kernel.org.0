Return-Path: <linux-spi+bounces-7355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7BA74011
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 22:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C941E1744FE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45271CAA64;
	Thu, 27 Mar 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5y0jVGX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118D19DF75;
	Thu, 27 Mar 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109921; cv=none; b=bPq7SLr47K68mhivGEZUMfI0+S4SnegZ2Dp6rK0kppW5tsjlPYhVcvXVPDuyFSxC/2MlDzZvWdWY145GOD/8PKFMCsWoSPLmfTxhyoN55ope8FN0KiMKcJ32LYC9VcA+eok5uISUb7Jh5ij8PEsO6C5kIieEHHIc25T5CGRsWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109921; c=relaxed/simple;
	bh=ByYkNM5OERWUhideqGYvTVTMOWKjfplXMqbr3m6/940=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g5wIDNKsGaEWWW8H/MBKZBizBbgSJCyLbp6APqu39R0vusA5zT4wBsOa1N+RHPW+SbYpNXmK+8+P6e6Txc6zyLsDgF4PzGoWaDt672lC+tYPxvK7NZbxkxLTR2De5YY+mpqVVusdChUXMbt2py4jRJA1Np95QB9QN8PAL3kHNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5y0jVGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4D4C4CEDD;
	Thu, 27 Mar 2025 21:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743109921;
	bh=ByYkNM5OERWUhideqGYvTVTMOWKjfplXMqbr3m6/940=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U5y0jVGXrQ8fexhfA/U0PHsfgSeCU8oje7d5hVlBOY7qAu6imaEz8gihZ/uvbe+W/
	 juYD/ZtsT8XNW3VVIUcwtIH+/oK0pbsZ/y9g3hlXU+G2Y3cxHx3kTUcuSEtmQ/+tuy
	 KSPZjQUKcGLSvxVGNI8xZPYBfs7SfsXkm9/MuteJQt4vGQqQKudyQdhfWKvF4eLW8T
	 FYlmjyXMeYD5gWXue1me/2MQ8mjNEOvno7tnOqGuacTC77uwOhqPFMLz1BrMqbXvyX
	 x2TbPzRFHS8FkPnT9pZtYK8YaNeI/YQEnKjZIbUUSefrqRrd+DPTtOMBawPuAB5hdV
	 Xv+9BicigW8SA==
From: Mark Brown <broonie@kernel.org>
To: John Ogness <john.ogness@linutronix.de>, 
 Volker Haspel <volker.haspel@linutronix.de>, Han Xu <han.xu@nxp.com>
Cc: stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326224152.2147099-1-han.xu@nxp.com>
References: <20250326224152.2147099-1-han.xu@nxp.com>
Subject: Re: [PATCH] spi: fsl-qspi: use devm function instead of driver
 remove
Message-Id: <174310991931.446685.5350029703728855284.b4-ty@kernel.org>
Date: Thu, 27 Mar 2025 21:11:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Mar 2025 17:41:51 -0500, Han Xu wrote:
> Driver use devm APIs to manage clk/irq/resources and register the spi
> controller, but the legacy remove function will be called first during
> device detach and trigger kernel panic. Drop the remove function and use
> devm_add_action_or_reset() for driver cleanup to ensure the release
> sequence.
> 
> Trigger kernel panic on i.MX8MQ by
> echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-qspi: use devm function instead of driver remove
      commit: 40369bfe717e96e26650eeecfa5a6363563df6e4

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


