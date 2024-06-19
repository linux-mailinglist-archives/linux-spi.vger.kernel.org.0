Return-Path: <linux-spi+bounces-3465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0990EC68
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FC91F210B3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C6143C58;
	Wed, 19 Jun 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS0k1MIq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261F13AA40;
	Wed, 19 Jun 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802432; cv=none; b=toSmqCrdwQBl6R9hj0GwuYlDhg35Rcmb6Mayl2cgcOp/mVFjDgq4UoqLRn/5qHqde7dfnjbcJ35mUO14l1YT4vdxjRCVB7YpMuZ22wFw3BhGrseIQyOvEDLVoaRN4ou/XNGGxhei66gOYBlxMFuPjnmKn18pc7PtwCdKehyZuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802432; c=relaxed/simple;
	bh=7ECgoqLxbnkE8eeAvsruy/XOatVSDC2HNxneNHxFsak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nKEpaRLwedGvDnSUmWyvOAtznqIuEkNOoOkrh1K2nRtT4QSm9fr7Sy/X2loZXr3rxPjiNerzjrkK+MyJf7vMnzkb5+uRnipuk+tMiGeKl0wKYpf5n/JvLKKoMJxckXfW8+QmK8S9Yj48qb4+aylnjyLmLhQeU1xV8H054hiJ4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS0k1MIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39070C2BBFC;
	Wed, 19 Jun 2024 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718802432;
	bh=7ECgoqLxbnkE8eeAvsruy/XOatVSDC2HNxneNHxFsak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JS0k1MIqNdCqn6Y3j1Pe+uEF6xsDKriiJ/PsjYTvd7CZmMYL5yxQn/3fHkYtaa1Q1
	 Sf1D/ng3FCcqaUet+ILdCd87bfOzts/TyEVQxRo4U4TkjDk9e+rdmLTllYiAFz6pAR
	 l+gPWZcA5PK+kH1IL8R9BkbcZcmMHedx8YEdWxN3Kw4TCBT0qY8ULn9aA3Nz/A/KoX
	 kbPTLlAi2APyhgW/2iq2eeCpUOxqHJQQpYKbcnMtz9RobgCmBn2lW5mf7IhPYMFE2d
	 KdZI69csb2p7+bl3Nocy1UsPt7q24cRCo9ujyKTUdY2l+JhgHQHErB76B6IquIDJ66
	 Di7xp7ZyIHQFw==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com, 
 amitrkcian2002@gmail.com
In-Reply-To: <20240617153052.26636-1-amit.kumar-mahapatra@amd.com>
References: <20240617153052.26636-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH 1/1] spi: Fix SPI slave probe failure
Message-Id: <171880243095.125187.8391249561773435131.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 14:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 21:00:52 +0530, Amit Kumar Mahapatra wrote:
> While adding a SPI device, the SPI core ensures that multiple logical CS
> doesn't map to the same physical CS. For example, spi->chip_select[0] !=
> spi->chip_select[1] and so forth. However, unlike the SPI master, the SPI
> slave doesn't have the list of chip selects, this leads to probe failure
> when the SPI controller is configured as slave. Update the
> __spi_add_device() function to perform this check only if the SPI
> controller is configured as master.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix SPI slave probe failure
      commit: 2c1b7bbe253986619fa5623a13055316e730e746

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


