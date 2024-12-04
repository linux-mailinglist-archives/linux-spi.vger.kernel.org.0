Return-Path: <linux-spi+bounces-5905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD649E3E26
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BA2817BE
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713720C47B;
	Wed,  4 Dec 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5omClGb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4920C032
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325780; cv=none; b=b+UA9qPMTC0LX7nh74eDQVM6UkDMKsMdZhYk4CRF4kLps5O2vsqf7GsKtl1hU7VuuoZgnVKlEoNl+/RIVdCU5FWOfY7ovAjN7GO5FkSVOvg83paU4AB3ZRSghIQMoB1p9JGNTSIme1nJ855XhNeY4I4XRnAn3TQmOEV/bY9a85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325780; c=relaxed/simple;
	bh=chTCAvuiz5wSkoOm9G9kPtrBlhCKGtWlC5SEGBcI4Q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tLH+SOH/KDajwQBETSPINWW0hSNSpY/gp7fFUWaqrTnp3QLEQOzbvLfX3bsHshp8c6Y30BhgcU659495XPudSa7LhLs0FViyi8PROnV8hfi54Tag900eO9BVnDb7vuXHaPsekbnIWkJQBIIApy9cq4mIjmNwq1y4Nc81z75frHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5omClGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4157C4CECD;
	Wed,  4 Dec 2024 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325780;
	bh=chTCAvuiz5wSkoOm9G9kPtrBlhCKGtWlC5SEGBcI4Q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d5omClGb0yVo5StN/PARfG52ts11FrwXptNfbtKlp4EuW+WTsLLqbWEg+0lwturOr
	 1y0pPcLahz+XAx91/6ESUkrwEn88nmj3S5TV1JTvEJuyN5MtjNQo6TAs8IHUCDwrBn
	 bSnV6EolGuZfsEmP5/T0ldgJiKDdb0V8oTMT9kir6uIIZ5hqleMDRCnPUKCMrT2CwE
	 MpxQz/RVsTzgD0KPheUnnhJth8acCic9dat9mwPqw9yJQmY29iNYAWoqIJdzQbNeHp
	 yL0zDOSGD33XAfpiAz/LCPOgSAcTS8Odw6yfMCSnayv/zCGxCCsY6m0VlMPM3lxX5y
	 xLuQBN10N8vHw==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Aapo Vienamo <aapo.vienamo@iki.fi>, linux-spi@vger.kernel.org
In-Reply-To: <20241204080208.1036537-1-mika.westerberg@linux.intel.com>
References: <20241204080208.1036537-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add Panther Lake SPI controller support
Message-Id: <173332577952.88541.7945903167050476635.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 15:22:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 04 Dec 2024 10:02:08 +0200, Mika Westerberg wrote:
> The Panther Lake SPI controllers are compatible with the Cannon Lake
> controllers. Add support for following SPI controller device IDs:
>  - H-series: 0xe323
>  - P-series: 0xe423
>  - U-series: 0xe423
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add Panther Lake SPI controller support
      commit: ceb259e43bf572ba7d766e1679ba73861d16203a

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


