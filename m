Return-Path: <linux-spi+bounces-8002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED6AAFD58
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFE04E3589
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282627587F;
	Thu,  8 May 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BslcZOLX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AA2750E0;
	Thu,  8 May 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715150; cv=none; b=TdQOQmQBLmqVrKQ98zvFmxynGlCB3ZijZLWKTeUMtfRP42VV27TZXpg3xvc4zhXdxwtCWN+sHRlffbrQz+U4H/U6jqxaPhn5xK5RbUrHKAxywPyt1S7bixqGzJCYRNOZiguR/FlDeZ0bCwbW+a35gPIEJNg6pgL8550SDKD+5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715150; c=relaxed/simple;
	bh=7x/zIqzniHo4bmHJ0f2dOc92RnSxwmSijCV3x2DCqvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pa9Ars6AYwjXCQdUA+wZ+4neeoZ0CVCotk3hwTpWMR8TjsnmgZpjcsP4RjfCQ3BlBVjGF47eAyY9Fyp3wDyh9s2O1F9V9T6JdKtVqAJeyC0/I6Oc56ZsAf81BfGIW6L9AhFC1cH1L2HmscUKFdlkyvtI2eTHD2qeGQWZ/4bT1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BslcZOLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D6C4CEEE;
	Thu,  8 May 2025 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715149;
	bh=7x/zIqzniHo4bmHJ0f2dOc92RnSxwmSijCV3x2DCqvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BslcZOLXlwCaUocOERsZK3iNFalaG9N73wIWQ9kTkYAJ2dVNGFGtesNnxH0dqEYcb
	 1ZAKGSeY4+4y/+9EcH9jEmYeUE9HqpdTwin59ECSmjC4szNfmGAV7SWNmorcJEB7jH
	 fg5zkSITb87Emxq8APb+t9B+d8/khgEZGKb/+qE/IKEPT/r5TZbKsUME9qpAtpgR1D
	 ekRNK8B+WQcnzTT4714IpVC2NWbncEtVkm0DOLqrO2UHbs69ECoJET1YQ0x+h7pi/D
	 rwk2iDdMB96fgitcgKfFqIf0VMzpG0Xn0mE7bnLJQPcZxHr5aSpOo5mUDJaKYLCuzg
	 alDm2yd5DtUaw==
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
References: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
Subject: Re: [PATCH] spi: tegra114: Use value to check for invalid delays
Message-Id: <174671514732.7639.17825357036042971229.b4-ty@kernel.org>
Date: Thu, 08 May 2025 23:39:07 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 06 May 2025 13:36:59 -0500, Aaron Kling wrote:
> A delay unit of 0 is a valid entry, thus it is not valid to check for
> unused delays. Instead, check the value field; if that is zero, the
> given delay is unset.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Use value to check for invalid delays
      commit: e979a7c79fbc706f6dac913af379ef4caa04d3d5

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


