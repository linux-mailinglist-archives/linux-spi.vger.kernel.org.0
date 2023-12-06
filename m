Return-Path: <linux-spi+bounces-165-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F01807A0D
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 22:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D3AB21033
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB4675C3;
	Wed,  6 Dec 2023 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVARSB5A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E24675BA
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 21:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B0C433C8;
	Wed,  6 Dec 2023 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701896693;
	bh=94SZSPJZpvqNb+Dqplrc7acGNMOWcuO8uMo8tuWo0BQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pVARSB5Afh+DogF3yO3ISxtEFB8+UrBROK3I5PzzGrNWkPJxnOAE4syU8wwVWTfMw
	 6JWqoDPoJCkcq75Epc0ewYdeUplb69Y6EO6lsTnYGkc9Oivab+Vup6fHB+89tMqTjw
	 KuuAgMQniewFv2b/4xVtCuyiH+rza0RtwJ860T8DFQbgLDMoAKj2r6p3cE6xaWMRFa
	 zdLoe3hWUrukmmJNHDJKT2W3EpFo48QW4SpM7NLBawhhUAaIJqScNVJ5CDhwKp38rF
	 gtUDmFDdFJNB0g3I+M2+kyvFx3X9lgPxVdkyLNUgfDjSZ8tzm++YULHTTR0u2sP3L5
	 UIW4CmVX+O2bg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 daniel@zonque.org, Nam Cao <namcao@linutronix.de>
In-Reply-To: <20231206145233.74982-1-namcao@linutronix.de>
References: <20231206145233.74982-1-namcao@linutronix.de>
Subject: Re: [PATCH v3] spi: cadence: revert "Add SPI transfer delays"
Message-Id: <170189669207.80266.3758979779470758907.b4-ty@kernel.org>
Date: Wed, 06 Dec 2023 21:04:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 06 Dec 2023 15:52:33 +0100, Nam Cao wrote:
> The commit 855a40cd8ccc ("spi: cadence: Add SPI transfer delays") adds a
> delay after each transfer into the driver's transfer_one(). However,
> the delay is already done in SPI core. So this commit unnecessarily
> doubles the delay amount. Revert this commit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: revert "Add SPI transfer delays"
      commit: 7a733e060bd20edb63b1f27f0b29cf9b184e0e8b

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


