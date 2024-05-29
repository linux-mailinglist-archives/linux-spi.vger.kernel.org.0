Return-Path: <linux-spi+bounces-3129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5E8D3D75
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 19:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844E91C21D43
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78CC15B574;
	Wed, 29 May 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPqDu8wy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FB33C0;
	Wed, 29 May 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004128; cv=none; b=Kj2YkXJwZQLh/b1989b2S3VejwZsB5/ZikzmQgsyBt5jyjxi1YSsn6FzeB+vTl+7ojR7hi45vywngkXu8NYKVqD1ZiPXpO0EAi2w2mq1MFz5HOKD4e/KZOC6ZFG/KJLmoT00qJ77RA7Rkg8+vHx41CiW2+rfZsb+dZ38AUEDgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004128; c=relaxed/simple;
	bh=MjJHXUdhLb1is7lbuoclhiAcsAwXgz+ipfJlkWfGOVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q8NpPfizlfHhBwghETFZGYMuUvzKK0EDGpBYe9in9JIrMzmrAFLMemnBUrBt77CV/wP7BnmJ61y9DZxV/4zdC3FIY42yfmcnpoOa+ToQpAFg5qM4PjQCmFibqQfq+86ipwvEr7D+2Ga4ON+LcNC9te7nY8lqmuABfdYcXLswO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPqDu8wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F8C113CC;
	Wed, 29 May 2024 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004128;
	bh=MjJHXUdhLb1is7lbuoclhiAcsAwXgz+ipfJlkWfGOVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SPqDu8wy/H+/KKNUeznJ6k6xP+tDmTEOOpvsK3VpcO/pJXfA/5xdIOtL+4b6WgyIo
	 APmEeiFzCcGrnp/SiEt6P39AFuDR8DYHBgiFLCikpETTwNTL4Mhkb7Lyzdv0EFa/1h
	 Yq80UJbx2l88rOhGt6+Ulfxs+R158wgpDDM/CHlZmILw/4lMDYSGzm/soWGdJwGATK
	 67oP+fQBeyOjaU5LN1PpR8eIeyLE6A1LPFifQ5Rx52oIgB90dfPOh/RBgaXP3NFY7H
	 Oqu68q0mi1q6cZ6d2uoToxVRqgkFYE9guz719OswnmewHfGLsrNMi0H9SPDfzi459j
	 XfPVeFB6d4r9Q==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>
References: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>
Subject: Re: [PATCH] spi: Assign dummy scatterlist to unidirectional
 transfers
Message-Id: <171700412683.151137.4555669167122921489.b4-ty@kernel.org>
Date: Wed, 29 May 2024 18:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-2ee9f

On Wed, 29 May 2024 11:42:35 -0400, Nícolas F. R. A. Prado wrote:
> Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> introduced a regression: unmapped data could now be passed to the DMA
> APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi:
> Don't mark message DMA mapped when no transfer in it is") and commit
> da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
> APIs") addressed the problem, but only partially. Unidirectional
> transactions will still result in null pointer dereference. To prevent
> that from happening, assign a dummy scatterlist when no data is mapped,
> so that the DMA API can be called and not result in a null pointer
> dereference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Assign dummy scatterlist to unidirectional transfers
      commit: 9dedabe95b49ec9b0d16ce8f0ed1f9a12dd4a040

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


