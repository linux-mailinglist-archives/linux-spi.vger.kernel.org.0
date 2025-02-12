Return-Path: <linux-spi+bounces-6791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC7A32F23
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 20:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44913A6E42
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996426157E;
	Wed, 12 Feb 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCbqqA3D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76526157C;
	Wed, 12 Feb 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386764; cv=none; b=ofiwWfYopC7TDYWzFNM4R/JW7cmTv0XuH0rryQ8IUqFP2nVhmje3YQOwiv9j8Tu0Qu4H7Bo07SuM37qSziCB2joCXKv4N39AxNx84CpRPo4BnM+dnYpKxuwE5YIcx2lLmsb2feRJ1FBJ0xpJvtiQDtXX5c3oUFl3v2Wag6L6Ra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386764; c=relaxed/simple;
	bh=BicpUrmWt9b8a+/6gyU8AOYGyPtuICIqQMEErkwCKJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B9lzqK+sQ45JryTU+ZzNJTNSpSCGKDtd2+c3tMPRJRtK0cnjbQcLLYpzW2YietBNCSCwADCG+IYmp6YCZFkpZtUodoyrq2Kxt80Ux5y6T0Qxppu8jCk1cQxGybiJL5i4neBsBPsQiBRxkH32DKyFu30wp0r8OloUw3CFq3Gea3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCbqqA3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F952C4CEDF;
	Wed, 12 Feb 2025 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386764;
	bh=BicpUrmWt9b8a+/6gyU8AOYGyPtuICIqQMEErkwCKJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sCbqqA3DryZ2+EMW2sfdXvrBsfp8TpB3Nx+KZdCO7ok6Hfg4CmVJtfssMdVpSRcoQ
	 f+XmpruvdVjYsG8hoMzH7NXOgj4232kqbSBIRCdMDGrTt8Y/4Vq0hS+xrDe2qEkZxJ
	 DZBXeWcZTuMY12ai/mtPqWIergb/vVBcEPpwyTz9mcNmjwNkJHuST1INF21RgTiobi
	 coSrytK+qDoBJmfrnsnc26BQS8ImBVFRPdUFqFM2MlcQaRUF42UuNet4yrZzsPCrlO
	 vf5tBvMm2G91bBzH6K8TGq6GCFCG+nX63dHLRJO2fMIXFziwCxGoR3qAkjDD7gEG/B
	 JIaHd4G2kbN3w==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
References: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
Subject: Re: [PATCH 0/2] spi: offload: fixes
Message-Id: <173938676238.250565.8485583434084673680.b4-ty@kernel.org>
Date: Wed, 12 Feb 2025 18:59:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Feb 2025 11:33:11 -0600, David Lechner wrote:
> Fix a couple of issues that were reported with the recently added SPI
> offload series.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: fix missing offload_flags doc
      commit: d795a052b0ddad3da83dda6ff522c1b1aaa4a525
[2/2] spi: offload: fix use after free
      commit: e957c96455e8f4c630d5e374312cad0633ca7e17

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


