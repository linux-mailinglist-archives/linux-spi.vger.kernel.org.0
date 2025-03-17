Return-Path: <linux-spi+bounces-7182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B847A65EE8
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 21:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7B1179DDA
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203A1E1E00;
	Mon, 17 Mar 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAHSMCqc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE81D934D;
	Mon, 17 Mar 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242679; cv=none; b=R6m3LCCatk/hKyZYzlNRF9RoUwvTKqYk/aOPzTJm2ZFHubg0I3A+AdW+dPhhH0KqAL685NWUrBS78r7lH9KcT7KWgoIkcUFYqWRXxILbJolUNan2QTAH0Dmf0ymeEpf40EvyYfR17zmogiGfBrooHTXoR96ktFPAkCGIcWJFWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242679; c=relaxed/simple;
	bh=ZVIj1EFEpjvWf1WSOUSjtDqV3snf8Qpcm2sVXUP3zCM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kq6IgCf9Ax6Y5bL2H3QowKUrFHIMchxcZgWWJDxSJPeX//8cjZ9zvCwhmbxlnAGwwzsmWGECDcN8QKIlT7oAewaUm2P5UptiR/qBmjt9qqnD5hd4H24dcavcbigfCsRBVD/S09jdhqpjW2PW6SmrV6kYGuyqmZguxRojuQfQN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAHSMCqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FAC4CEE3;
	Mon, 17 Mar 2025 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742242678;
	bh=ZVIj1EFEpjvWf1WSOUSjtDqV3snf8Qpcm2sVXUP3zCM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PAHSMCqcOijOasQHJXKx1/aiPl2zIbFZ3Vlt8qOMEJVOM5mdZwTyKa7qbuO1BvSS9
	 /CTAtu4Xs0D12iFlq6+B6iMmOEm1DwvJscWBy51XBr4cmbbBJO2CAbl19NK9ibZ2CT
	 SkLWB0kxVTtJRefGwuV2pHw1CO+lCPGABIUJnwx59TLSBgTixMD6rWTWR/XKwuZl8n
	 nYV1Da5r/zpxeqnpWuL5mYMzLfuPl0Cg1kVzpmzCWyvvvsG54jUkBMW7D9uYwCBzZ8
	 k56mFDgv1B96tGOMAH62/oTBN2tM9YdUGd71F+Cw4Fob+xwzXhi6n3zyyNpaCYrz8/
	 HziTMTE1svMiA==
From: Mark Brown <broonie@kernel.org>
To: Longbin Li <looong.bin@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
References: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] spi: sg2044-nor: A couple of cleanups
Message-Id: <174224267778.326890.843249855338998185.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 20:17:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 13:12:58 +0200, Andy Shevchenko wrote:
> The driver has one ordering issue and one missed case for dev_err_probe().
> Address that in this mini-series.
> 
> In v2:
> - fixed obvious typo (LKP)
> 
> Andy Shevchenko (2):
>   spi: sg2044-nor: Fully convert to device managed resources
>   spi: sg2044-nor: Convert to dev_err_probe()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: sg2044-nor: Fully convert to device managed resources
      commit: c6d94963333d6377382f26a480e687492f5a9174
[2/2] spi: sg2044-nor: Convert to dev_err_probe()
      commit: 085cf53d71b9406d646c9f3f24876a36a68ef4e9

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


