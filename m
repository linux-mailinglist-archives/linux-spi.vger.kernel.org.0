Return-Path: <linux-spi+bounces-2415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8398A902E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FDC282C15
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE310FA;
	Thu, 18 Apr 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBGr5pGq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E295250
	for <linux-spi@vger.kernel.org>; Thu, 18 Apr 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401501; cv=none; b=Uc0eRr9RdnlPoSdfhh6Mt3u0vwB4PEZwpoFl8M/K9Y3ylp5s0RnInq7pmQmdlO4Jj9Zy5x58vPsxrxVMtaiYRbTOXoneAiD10IZD/ZMavZBy2txYL4pL3GaLJx75ANpKw7Ev2g/PlzQohpOxwD0LyKtVrpMwh4CKyVPkGCx+bRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401501; c=relaxed/simple;
	bh=gTTfIi0SmY6SUMK/5Li3Yoj1iNncmRXqD/gtfBNzeU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrHKgUa2t6anlHs5CKSJL0aGURpTkCd2BaUjhJTnVjM8ZkXnHwbbxiPkxf4mPT5wWarLIwLWkLWVW3qutwwEM7neyzFezc9+7/5p9kapTd0w421lS29Gofokc5Gc8YeUZ2xq6wGhkI3bEVxwyvhpFYG/tskEu6163LOnXZPvFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBGr5pGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8328C072AA;
	Thu, 18 Apr 2024 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713401500;
	bh=gTTfIi0SmY6SUMK/5Li3Yoj1iNncmRXqD/gtfBNzeU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oBGr5pGqjmxz87Kcqk/PSGGI8BKYTHq8eYhb4xO5CH3jh7XHkHLLDq7uwoj03p4tI
	 q6XQn9PwftNDu3M5uDs+JDTVFBDSDCkxuly95Z/ctWVzJKXLb5/qI1F4Ia0Slw8bpD
	 /A962f1ihSfRoBx9LA90QKobsM9OML3l696nrx3yoTR1roIF9pewMWYxnjr58E6oP+
	 9cAJs6Cv4aSvNXAskojcfgg+rD4kvG+zaoBznHmC3gVmqAaBCxX9I+vRYsvg2lI+Rq
	 mq98J16e8wYB+Usqt+9DuBfOBKrbsoVx/hM1VShWQWhT+kBsJT6dNRhd65pEyPsFo6
	 KQyRL4f3fd2KQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, linux-spi@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240417093026.79396-1-ckeepax@opensource.cirrus.com>
References: <20240417093026.79396-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Use devm_add_action_or_reset()
Message-Id: <171340149959.1715024.15297456950838581415.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 09:51:39 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 10:30:26 +0100, Charles Keepax wrote:
> Use devm_add_action_or_reset() rather than manually cleaning up on the
> error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Use devm_add_action_or_reset()
      commit: 719af321a84b9b6669a82a94708e7ca574971331

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


