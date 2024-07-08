Return-Path: <linux-spi+bounces-3795-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09D92AA26
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE671C21C95
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0914D444;
	Mon,  8 Jul 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apuETVWp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124414B963;
	Mon,  8 Jul 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468139; cv=none; b=iKLo/j2PvFvMT9k5Do0kV0rkGfp43oyBSBCs4jnIoa72sPBdERvvTA2FMO/KwtL6jR+HMhHoH4jhI6wNA+TmS2mChAX6cGBmWaI6lc1c0HvXxyviSDGPBrZIOyGHn/EP0VELOhIp4f7cgb9GbtkwONt4+1fwFGG5f9qeKbpu8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468139; c=relaxed/simple;
	bh=cTNcVbueibhNmGD1oso8W9q89J91rCA6Pz4/vVvrl0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=guWs1qCfJ6RPgutA0xtGOC+DHCh9prOhO5UTmJIGZTGvJO+9fo21KwnZYUm+SNJPN3GS/XowsrQutvi6IqGaweYj8WtIUQ6Ah/ziiZ5I/yEv1l9j6TvUeXcjgD3bxKp2/Bu+ilrY1yXNRyQjIepMYQZo1wTYZMdLDXj4YEF6rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apuETVWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B679C3277B;
	Mon,  8 Jul 2024 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720468138;
	bh=cTNcVbueibhNmGD1oso8W9q89J91rCA6Pz4/vVvrl0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=apuETVWpFt3NKSwVgZgDVgtvbR+MOpZVVZILbmMQ7ruEAnJNAWGKW5aSStIIDe0or
	 EwqofPJiTI6JmQ2NgcbLXKYw6QuN/ToBA/W3VHMjRWse77owzNv/V9HJJn9gHDzXHW
	 6O/vOzPuRC+GmdDnc3bs+0CIsv9jOMIvOK4RfG0AIiXHdZNUINXWVgEQkCbiy9kxr4
	 UnBzCQuw6tqGgRkSAGpW+PC268tDEbFcOLm5PBbIu13+kknU0ehETvhi3jyV/Ww2A6
	 CJg9HbWhPEls5GkYX4EVVQCO9ZGp1Y0KunkjIGw8lJfSpXkPNVfzXe/SDypKbdCGIn
	 ZAKxaZc/DJlJA==
From: Mark Brown <broonie@kernel.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20240708-spi-ch341a-v3-1-cf7f9b2c1e31@kernel.org>
References: <20240708-spi-ch341a-v3-1-cf7f9b2c1e31@kernel.org>
Subject: Re: [PATCH v3] spi: add ch341a usb2spi driver
Message-Id: <172046813781.128321.2969630260164419618.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 20:48:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 08 Jul 2024 17:49:28 +0200, Johannes Thumshirn wrote:
> Add a driver for the QiHeng Electronics ch341a USB-to-SPI adapter.
> 
> This driver is loosely based on the ch341a module from the flashrom project.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: add ch341a usb2spi driver
      commit: 8846739f52afa07e63395c80227dc544f54bd7b1

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


