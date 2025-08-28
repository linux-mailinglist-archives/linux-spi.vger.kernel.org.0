Return-Path: <linux-spi+bounces-9733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DCB3A1F2
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415A8A05590
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD2231858;
	Thu, 28 Aug 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmEh2Sr5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36321D3E2;
	Thu, 28 Aug 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391215; cv=none; b=QbhEWK3tQVYjnEgap0t0d0paPQWc1bifdoNm49xgxlOtBK6ZhpwXPJhqLKVCzQ0KOQmFi8gP17xdEhKnkwYe8DrDYzakD2fmP52eYDmTIdu4Ansva6VpoDS0nALvUBeg8VksEY0d89MZkjVOQ037YjB2fYz98GKTAecsBGkVe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391215; c=relaxed/simple;
	bh=TXkSTiKU1HwPZBFfFyVsmihSzzKDXFF0/Gxo5T8CfJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mw+cQCpaaEACQtgrtOwaOn6szERaW3Dvg7/KnXcDJ7lfDHOOlCbILipkckTwjL7QfCQPjaklM3WfnRnZrglzG3m8juoEnQBbbSX2wKvahFW7IfdoKVP0nxvjtMhlBV2IQPuep54Qjv3nB2Z2xtlcHyCep0Qs66TDnDx9PlNZ39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmEh2Sr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A40C4CEF5;
	Thu, 28 Aug 2025 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391215;
	bh=TXkSTiKU1HwPZBFfFyVsmihSzzKDXFF0/Gxo5T8CfJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WmEh2Sr5+RRtn9h1/Cd2EgrxPQyqgLanDZjtyJXhwlNhIxRJxDSYX/vuJT6LKXydX
	 eeMSb8ZgVoxpMwge0kintT0j0npkXCgC8mxYNDgCbSDBFY3WdaSUnWMf/eZwsc5Hj5
	 sWAsIMrYG4HqcY6Wj3qw7WWG6Fw//ibujIyNjTCjWUiVWCFU+jR1R/zAEBq18U/4wq
	 oyY6jIY65jePavjg7NGbG36e/3P0PP6xGOicraKL3mmu0lLLteAJUZsaEe336DmUny
	 eIqGdMpCL8UHf+1eKUPvibnuxDdjHkSK2LL5hwZadD8/nQDdPRvD6TuPsSMqVP738p
	 eznlEn4iF7LhQ==
From: Mark Brown <broonie@kernel.org>
To: ulf.hansson@linaro.org, rafael@kernel.org, 
 Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] spi: Drop dev_pm_domain_detach() call
Message-Id: <175639121330.325729.13609358715171235834.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 16:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Wed, 27 Aug 2025 13:16:12 +0300, Claudiu wrote:
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Drop dev_pm_domain_detach() call
      commit: c42e36a488c7e01f833fc9f4814f735b66b2d494

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


