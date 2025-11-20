Return-Path: <linux-spi+bounces-11380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D463EC73411
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D76535955D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70F322550;
	Thu, 20 Nov 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8xwtxM1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71130F7EB;
	Thu, 20 Nov 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631638; cv=none; b=gOVOifG8Md1ll14PoRI7AJpqWV3LUcrrdcr4NY1XZp9iuVXhXYlXHvsE9IrCNe6IuVXAnrDTypssbtAXePUYGSk7UAPOoo6UsVN1OLx+gXNyibw+8ENIeDyuWct1MN/rfKnRbNAzG6Q/x1z04FdgZfF8eZaDAXNzN6QptBrUN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631638; c=relaxed/simple;
	bh=pu36+CB92IxzqApmqvq6q/T9gDA8szI7ENmVOvUz0ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t62QCOLMTy+dFAXN/Q50FCzLXCuaJi/oL4zPlLis4ws3htSWt22F8RPweRgokqPbI2JbIOAb7UsKXWrUN+PSvx0eQBh3MmG9Y3e5ZYfDgqRkSeahM9vQz6JfbsWqvy9f62IgZiwyh+/dXgrHW3I0IT12fqne9Rjt8oyguqxHsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8xwtxM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F8C116B1;
	Thu, 20 Nov 2025 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763631637;
	bh=pu36+CB92IxzqApmqvq6q/T9gDA8szI7ENmVOvUz0ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r8xwtxM17GewSFUZBlvTsJ+jU351NbZs8b+fnPxgcT0HhnlpavPVm/bwvtAs0mlYd
	 7Sh0rSuM5NHFKtNdsqs3HPUSAFAyz+3Gz15r70rIVVOcud+CHHMlDFc/hPyNC68CpB
	 Ju/YycVD/Srblf4KXr4qPxNzdH38luAo7gzbb78hhAMq9wHXFwtnLrzEUy5UiCd77d
	 1AEk9jVjMFG2bNKKmzEvFqf0W6Wp1fxQHH2JKzoIVsrvY6s6w5qtwP+2HdL7y7b+IU
	 OEHS0n+BLxbW6Xcjgv6ae5qtGr1ZTn8Eb3c7+F3R3wTCZdHojZI+ZWRgYhjlieC6sv
	 EPTnk5SVqXtUg==
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20251117-davinci-spi-v2-1-cd799d17f04a@linaro.org>
References: <20251117-davinci-spi-v2-1-cd799d17f04a@linaro.org>
Subject: Re: [PATCH v2] spi: davinci: remove platform data header
Message-Id: <176363163548.560683.4041810188857828339.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 09:40:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 17 Nov 2025 17:12:47 +0100, Bartosz Golaszewski wrote:
> There are no longer any board files including the DaVinci SPI platform
> data header. Let's move the bits and pieces that are used in the driver
> into the driver .c file itself and remove the header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: davinci: remove platform data header
      commit: 96498e804cb6629e02747336a0a33e4955449732

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


