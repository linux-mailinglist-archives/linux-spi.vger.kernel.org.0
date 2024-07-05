Return-Path: <linux-spi+bounces-3770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C023A928DED
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 21:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13671C20EAD
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86112FF96;
	Fri,  5 Jul 2024 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZMzFkBW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1581E
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208920; cv=none; b=ICaxqUxoene+hNtX6Uj57CS7GXxd3g6x0gyfl4pTl57NdPe9quRR66hIPl3Z2RnGVgUFHsM6IznOFo6kHdmF9tVMBQxrCmGp9FqhuPYs4CjeJf4OQqLI9XvEEr7y7jD2ncnng3+8gbMC7AUqUTskSARTL6rE86NRY4OForwf6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208920; c=relaxed/simple;
	bh=uBPa5zajC2GM3YiW6RWQ+g2IuxkMZN4zDGrW3XeH4PM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PRzKBt5aBDGNObR7iy8DWX4ZWsJaHUNqIPRps9jYekymJ9RMI1deXPNEzkisi5K05mVbTGsQZrK6BjTzzH1Y2qaXF124/gWUFgWxjym9X14dzefG1PgzJtotffz+wTt10/5n/5LzsL8vraffxaE7MI3ZK55ILmOrZKnJDSdqZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZMzFkBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C7C116B1;
	Fri,  5 Jul 2024 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208919;
	bh=uBPa5zajC2GM3YiW6RWQ+g2IuxkMZN4zDGrW3XeH4PM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hZMzFkBW2Okdt3fJk9M8E3wk6dTnPql6L9xVaakkPH5kjDltXYBMknO4F3I8PLMcZ
	 fGufFqTnIsH165MuJWKPlr38atkaG6js+dmM0PM2SeUBa18N9CEaruCgIGoJTCIIjB
	 drAb2xglFWdykJ85sxxehZODa0m63+e+qczegDPn/KRhOWWVwvEg+PpI3t1EeFyX+L
	 V1tqLqYjDl1/nuO/x1DEypDojKk+xqQGi0NUHca+UUuWq2PgOeViqDgGmEMU8B4G+2
	 16TktHDxsol/bVH8oM0nUlUChdjgIvPmfjiHVRNPL+9rhGkskg8lvDN7BuTnSLGq/m
	 RZrfldWqCLBZw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>
In-Reply-To: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
References: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
Subject: Re: [PATCH v2 0/4] spi: xcomm: support GPO pin
Message-Id: <172020891789.87950.1215613700030966320.b4-ty@kernel.org>
Date: Fri, 05 Jul 2024 20:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 05 Jul 2024 17:12:38 +0200, Nuno Sa wrote:
> Here it goes v2 without get() support.
> 
> v1
>  * https://lore.kernel.org/linux-spi/20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com/
> 
> v2
>  * Remove get() from gpiochip ops.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: xcomm: add gpiochip support
      commit: 5211070c3309bb3679f4522c77b900f551db5739
[2/4] spi: xcomm: make use of devm_spi_alloc_host()
      commit: e8ba259764c745e7de20ec517ae920ecd491b687
[3/4] spi: xcomm: remove i2c_set_clientdata()
      commit: 5e7d4755c58a347b4fe7663cef9b169b0965d09d
[4/4] spi: xcomm: fix coding style
      commit: e2e89f96308add00fed632ecb416d84c9313f6aa

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


