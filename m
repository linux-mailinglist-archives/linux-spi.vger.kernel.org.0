Return-Path: <linux-spi+bounces-612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF88375D2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 23:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0324B2357A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C048CCA;
	Mon, 22 Jan 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFmYtjFl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529648CC9
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961232; cv=none; b=YNU+CLURHsIBDnQWBVK0wUYtdo+IDxdYpV8rjIwOnhhAnGtYcdDUICmb+lou+KwhFJcgfLTiOH6pwfMyfqc7+NW+if+piW7XH7sic1gIucIRRtMdkthu21fG+WY0C57Nrg4pu7Ees2Bcx+0x1iFezmOfW0Hz4ykr3je/uZGpsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961232; c=relaxed/simple;
	bh=B9TVSVeywIApGsJPGWPaIhVzpXSgNp4J8eEbVdaO+no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iTopGDnCbO/kEj5Kuqesffw9+TO/8SJ9tCkmoDm+MxSyJSLPosoHKy7/JWywgjCq6taINseC0cWmMtRCVxD9nq9dLC+wePqFDpeSREm+b0dk5N8Gjuz7k2VszcGKDpPAkFpaUm1BMQdVPauav4ugtXgGpXxH/cgJBEhG0BCCjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFmYtjFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2439C433C7;
	Mon, 22 Jan 2024 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961232;
	bh=B9TVSVeywIApGsJPGWPaIhVzpXSgNp4J8eEbVdaO+no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rFmYtjFlwJcYFAM01/ZzAT5McNs82cNu98YkvBxaePUu8traCxpULoNBAf3uxk3pf
	 nGsrQrE4pu1ek5BJgVXb5ovdFajI9HOz9tcLPAlYbwZJpeH+/gNslPjbcd1E5+SREn
	 pziLIWONStu6Qd8yAcLX7xMWbzRuisvf3lPc4ylNKHNiCPpfynwlP7scoQfgR2NDIT
	 n2NBihCRPe/IS8TjLMdCSYJ1advAnfm+qqBAoR+HcJRa2IP9EUCizAZISxz+U7lYpF
	 UFoWIosKUhphf6cdF+PN1Ym2QFxMHSLGL5bbSUd2plJB/MXQItNG1BDghW+BUvinoC
	 y9//67ZhBGIcA==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240110085403.457089-1-alexander.stein@ew.tq-group.com>
References: <20240110085403.457089-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 1/1] spi: spi-imx: Use dev_err_probe for failed DMA
 channel requests
Message-Id: <170596123037.165612.5577949744274471449.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 22:07:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 10 Jan 2024 09:54:03 +0100, Alexander Stein wrote:
> If dma_request_chan() fails, no error is shown nor any information is
> shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
> Use dev_err_probe to fix both problems.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
      commit: fbc7ee6cc16918ea64a963a4ee097699cc159a8d

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


