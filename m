Return-Path: <linux-spi+bounces-4801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C555976EF3
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F51C23C4A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA81B9B3E;
	Thu, 12 Sep 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoJ2gSYh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18E1B4C3F;
	Thu, 12 Sep 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159393; cv=none; b=X78lTTSbPbn3SwXIbLzOYiUMmm1JaWDLZbEljDRfIH4pVK4NEyf43pH//11acQtUiWIEX6sbfg3wSy+WIsigtUOP94AaPEYvn9OWX4N8Q3Y8DNBcwYfVjwQ1Ol/TjvXls5t4m6MIvobrnpC/p0r0ytN3Lpa4x3k+red/7+dwla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159393; c=relaxed/simple;
	bh=kffAti1YkpRjrs3/bMScaV+Xgbv047mhuLKmtiVTNRI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ITMt/QTJkvHloSFblYeyN0JDisNhbGOWR23WSVC7FnICluHfk2ZqR8gfP5ukefZ6yAds05MlZrL92u3Vo1qRwIooBx0tlBT4i/oth1IdvG7Fs0owvB3REEYj/0KpTo3m1duCoFUSmQXezjjfx3Phs/e9qqtwC/k5CBxnjFORmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoJ2gSYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D52C4CEC6;
	Thu, 12 Sep 2024 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159392;
	bh=kffAti1YkpRjrs3/bMScaV+Xgbv047mhuLKmtiVTNRI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IoJ2gSYhtqJqc4Qx5bSCyToQhrWgxpE+31JXLdCyoYTYPif0vjs4FdhsnKuoxtyAt
	 vNR0OXMxfFTctbYPSacL4nooNryIStUghTk8W0E7ea+KpoNbvReeZAkKcMna6KBon/
	 7hMtoSBxZLbMRbQnbkYJRB5+o5Tei7lPN1E7+fH/pnbUKjuCslKHp3s04rUJt65/lL
	 BOD4ge4tZD8lAKOdjQ6Sb7XAygMA+JuL/LtnyFl8nL/jFMRt2a4sZ3AepNAq3nzCh/
	 wt2Dx0PuToPM64jX0Ve3SW8GbEyDAvD0bcG5CfaKFCIjNqckynu/ezUc4djF4xUdOt
	 aOt7tBnuLlCeg==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-msm@vger.kernel.org, dianders@chromium.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240912091701.3720857-1-ruanjinjie@huawei.com>
References: <20240912091701.3720857-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v5] spi: geni-qcom: Use devm functions to
 simplify code
Message-Id: <172615939165.65102.8130006613352677649.b4-ty@kernel.org>
Date: Thu, 12 Sep 2024 17:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 12 Sep 2024 17:17:01 +0800, Jinjie Ruan wrote:
> Use devm_pm_runtime_enable(), devm_request_irq() and
> devm_spi_register_controller() to simplify code.
> 
> And also register a callback spi_geni_release_dma_chan() with
> devm_add_action_or_reset(), to release dma channel in both error
> and device detach path, which can make sure the release sequence is
> consistent with the original one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: geni-qcom: Use devm functions to simplify code
      commit: 07f1eb718db281c3e0cdb068ea7d73c30921a81c

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


