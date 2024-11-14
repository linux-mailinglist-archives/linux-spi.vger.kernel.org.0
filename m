Return-Path: <linux-spi+bounces-5700-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B39C8B4F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A29E1F22D7D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4118C01F;
	Thu, 14 Nov 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKVi/7d2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4427466;
	Thu, 14 Nov 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589291; cv=none; b=O40uBeXDjFsp6YTKP3khOmMZX0XBtfTHertVejdWTtWS2dKFIdUxlPMB5d6E6/RLb82+lp7GHHT9bM0T3PmkowBJvDq0bK9UeqKcaoM0IqVHNzDJuY0TQQINeTDCPmVIG4KAaT/xkBxan9nBgkY1fCoUhBOB7OH75QoN+KFWc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589291; c=relaxed/simple;
	bh=znIi5ZhH0roDBGFwUetxCsbJMCd7PbY3dvLNlBEnHaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LnjUER1h15nnFcZJiS/o0uMxvLusGc5SQmNxYaWdm2sC9mjvSXEBElA0LMzeDSSoikN5EBgR7IW/nz3i86/8iIO5/gahyD+HoueV7AMI4VDHfkpFQ40G46KyfH6HA9dinkxmOhNq0NT4ov0up1MX/EkU9ibzJdckxw/J594Pwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKVi/7d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE6AC4CECD;
	Thu, 14 Nov 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731589291;
	bh=znIi5ZhH0roDBGFwUetxCsbJMCd7PbY3dvLNlBEnHaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OKVi/7d2yTopEE+eYkrzveGgVu5IM+UsZgON8pbD8HClNlqS+9D0NQviThUXXHawO
	 XJKMPf+csqspkjwsPxUVy+EMQDQQERKICOnyk56M6lR/1HgZl0QNfsCaECyGOHgL9q
	 6MnQD6w01f3EZAZDc7VyCiwOlU7DJH9yhHWC3uGulh+Yw0K2ly5N6iX6OZt4LGNruy
	 LmFWfzP79wsnELTxOeRtad/7ItcT84bolDJ3CJp+AqQEGIFlTYN7hWe4pGIJTSOE6R
	 w1ImRIfTRCqGiN8cCgGj/kwhu/nLEs3f9KqN31tgbFsvjTR5N1Qo4vwlm+k1efSsFb
	 rNr2J33odeT5g==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Rebmann <jre@pengutronix.de>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
References: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
Subject: Re: [PATCH v2 0/2] spi: imx: support word delay in ecspi
Message-Id: <173158928856.484595.3921699899296506205.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 13:01:28 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Wed, 13 Nov 2024 13:18:30 +0100, Jonas Rebmann wrote:
> The i.MX SPI controller supports inserting a configurable delay between
> subsequent words, which is needed for some slower devices that couldn't
> keep up otherwise.
> 
> This patch series introduces support for the word delay parameters for
> i.MX51 onwards.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: imx: pass struct spi_transfer to prepare_transfer()
      commit: 7b94af24a7a4d12a76183f1b2f0d363d2c9ced43
[2/2] spi: imx: support word delay
      commit: a3bb4e663df318b232746478e7b191bcf6e3af40

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


