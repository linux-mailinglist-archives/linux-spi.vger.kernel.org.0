Return-Path: <linux-spi+bounces-2384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D368A7AB1
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 04:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D25228391D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A61C20;
	Wed, 17 Apr 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ8TPxmT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE678F54;
	Wed, 17 Apr 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321968; cv=none; b=HaFlkbdzhFPV8BhOxgV0J+HGRrc2doQ4ErjrGa3qmstFUaHrCruNHyrR6FkBGXZvROvdxJ7ir6fE76viuZOxP+6YjZK6EUBiTrRJ4seQGdDlw7X12JJcNk+xYl2FWD7iLlIS8ugNW+Vwx5d0XDFB//zksM5UeopUFNg41mtS0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321968; c=relaxed/simple;
	bh=1r6hxdxqI6GXVNcgZCfmJy/7fxS2i7yA03rrwOq53wk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hvCuCFi7z4J+qhwC6FafwuLpN7rItVmY21iMZ8FGhA0aNcVK4WQq39MCHs1+G4J5+8+ATyNlZAkaq+jwThV4Nfhl68fFUWDkbgy4dya+sAAYXq3bwTHLy1AF4bXOQnLQiD/0Zlpu0RVlsTkFsUDS9K1zSGrYxpLp3ZEHWSFLYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ8TPxmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6331EC3277B;
	Wed, 17 Apr 2024 02:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321968;
	bh=1r6hxdxqI6GXVNcgZCfmJy/7fxS2i7yA03rrwOq53wk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rQ8TPxmT2G1V5MRR+J4TNo82uUs9AfUCoL+mWrk4f4DuwAZyD2K8VjoIJtINVleMT
	 lSu5QejvD6ayXYfgOJW2uJh7XHkUl3WrZTaZJWv64L4Q4/okCiLiviCBtVVrE6Wrps
	 Uq89lKmgaBDnajsIHBcsnAUIl/LbVmG3lkNB0xcMAqTVcmslFXtjqNekPeJe+iIly0
	 jWemLub5ngzS197GJinIZr4FDg99vIYrk2NK/8uoVwioyX43zRZ3duSmMDd2ykYS8U
	 /wUY+pGseIm/nb0J9kEdBVzDHCAkCMHXG2YpOlyYZ/Gr5V3vHYzQMbpf0OLl/LxqXc
	 anJ+Isq3K9sIw==
From: Mark Brown <broonie@kernel.org>
To: linus.walleij@linaro.org, brgl@bgdev.pl, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, bard.liao@intel.com, 
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 0/4] Add bridged amplifiers to cs42l43
Message-Id: <171332196643.1698999.8454490477837124341.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 11:46:06 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 11:09:00 +0100, Charles Keepax wrote:
> In some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually. There is at least an
> SDCA extension unit DT entry we can key off.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] gpio: swnode: Add ability to specify native chip selects for SPI
      commit: 9d50f95bc0d5df56f2591b950a251d90bffad094
[2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
      commit: 8a101146bcf014060530d71eba8edc52eca257f7
[3/4] spi: Update swnode based SPI devices to use the fwnode name
      commit: ed8921188f3568ba1659ff041f21e83565c74ec2
[4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
      commit: 439fbc97502ae16f3e54e05d266d103674cc4f06

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


