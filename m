Return-Path: <linux-spi+bounces-11893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728DCBEDFB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CC2C303FE06
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79A331208;
	Mon, 15 Dec 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrXC1zGu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1D330B2D;
	Mon, 15 Dec 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807169; cv=none; b=juipbjxH//UMMVi47j83Hu7c1yjSwX1TLV4o/2kWEhbHx1IW39vdNwbOpYHDqkZjX4SgzQTs3NCiqUIsruIB9FGEB1PIDGfIIrSCboejJiI++jpdGdTDY5QDgIOQIamFkoZbujIQKcF7EZUYNI/zPeVSFO0Y42N6n9HBhI9vrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807169; c=relaxed/simple;
	bh=GnK7KI/KEHI6oN/m7wthG1pFth6QKtX8R7DqegGKBs4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hzJ8/4tNLiOnxFWi9gwB0jWxuw27LRdOzZL1B1Poq+S5T38voZwfCWKRt5F5aRY8lmeYOd9q3vWq+7gqEpaZcyw2FsgFtAJ1iXdCC3UGP7drTp6bEAG1xGtKiJCfVK+VAppsjuces+VoAesMDr6tM1ek7miWZ+XK3sRpJv+R4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrXC1zGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03644C4CEFB;
	Mon, 15 Dec 2025 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807168;
	bh=GnK7KI/KEHI6oN/m7wthG1pFth6QKtX8R7DqegGKBs4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NrXC1zGuluis4NheK4QEVDB3wwvXwkPOMb4K2f5oUP0t5HqIFpw+wZzq70gvyD+kz
	 uzhgHPxsqFZo13jpI+G5cNxD3KIali9jd4+lv7MjDly3guaLRXZfFjSejlPrle11N+
	 iG0qQ5wZ27K7vDa9HlbLS2AbsTWuVUUPdtsX7yDlmMFsuFMKPPu8MWE3a9NflMeQek
	 bZr+XfKZIKjuWaTX5Cqv1e8UCIzOKrTzgN0/qNgzaQklbc6R3EwoSTtjhoWgQQ2Ev7
	 Kjf0V7cVMn3USC/XNEvijCi//Ek7pMczustJucDv7gd7mCDVAg8/AVtafLvClhHF67
	 Mh64R6kDtbU7Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251129151739.3998668-1-andriy.shevchenko@linux.intel.com>
References: <20251129151739.3998668-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: cadence-xspi: Replace ACPI specifics by
 agnostic APIs
Message-Id: <176580716744.161463.9153763964021295249.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:27 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sat, 29 Nov 2025 16:17:39 +0100, Andy Shevchenko wrote:
> Replace ACPI specific calls to get device property with the agnostic one.
> The code looses the direct dependency to the ACPI APIs and get cleaner.
> This doesn't change functionality.
> 
> While at it, drop now unneeded acpi.h.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
      commit: 6f9e4740e8591176eb90bb1dae95bbbb5c7d789e

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


