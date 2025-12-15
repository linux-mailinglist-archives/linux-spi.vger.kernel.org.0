Return-Path: <linux-spi+bounces-11890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1228CBE98B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3375030A757E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FC32F745;
	Mon, 15 Dec 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TppoHVBe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142132ED4D;
	Mon, 15 Dec 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807161; cv=none; b=JSHdxkpQPADtyKyK29LF6Bo4b/OxI9K2Gwc+gX4OmckaVo7mOlbusr301iqM1lOg27CM7RMYkfOPkngbtzLdXmR4T0o+PmGrY40ivgMUg8cTeOay59OcG6sB6qiYASY1a1elPcWbpB27M0SI44qVqOV63LQPcXYXwQ/E2rWEDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807161; c=relaxed/simple;
	bh=+FICKIXvz43PKUIXqLLP/8JcYAgebtkv5kowjCUQgRw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o2zblVO2p/AioBK5eJPXmIUSj5lX1ksYOnX4zS/vyMhT3+KhybVDdbsUh1HWJhCqvpN/44VlXGJRvi9IFNMEs9kwc95crL3Q15fbVzMMQA2NgxhzfANsUF/JvvNw2ELGRymWTkeN+Y9sBe5XHKNBmO6b7dLEHokQlkjwB7pldr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TppoHVBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE6FC4CEF5;
	Mon, 15 Dec 2025 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807161;
	bh=+FICKIXvz43PKUIXqLLP/8JcYAgebtkv5kowjCUQgRw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TppoHVBenGUi/kHGmdxA8Xc5p7ogaHOXlGwoagUX/+Imtt1I7bfYXLjhSDtoZBZxy
	 JynXVpEleQNSen/QBY05MYf24PZqO5YgEBQarrNVDW+mi2fiGomQdnuez9hhacLxfx
	 12Bb43NJ4ixIOvRHWUTEnBrMHkI6ZLPKgM+DLzZThVLn2BC5kLyCnte7C9gTRECQ57
	 n4i2JoqHe1PLCUps+deV0EXQqvu8gXmvVGj2DcjphysDWqFNY0YmIQLlaAJASSpo6l
	 cxglCNqJvuOey2mhlCfPcCenG+owBEeFFBtaZq+XSUdA/3cT7G8Ugij/aPilNKjfwT
	 iH0PvZv6BEZoQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251129150704.3998301-1-andriy.shevchenko@linux.intel.com>
References: <20251129150704.3998301-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: cadence-xspi: Replace OF/ACPI specifics by
 agnostic APIs
Message-Id: <176580716012.161463.17794631902855329215.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:20 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sat, 29 Nov 2025 16:07:04 +0100, Andy Shevchenko wrote:
> Replace OF/ACPI specific call to get matched driver data with
> the agnostic one. This doesn't change functionality. While at
> it, add missing property.h include, and drop now unneeded of.h.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-xspi: Replace OF/ACPI specifics by agnostic APIs
      commit: e83ba2e698aafa052d0df82564f7c8cd777fd5c7

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


