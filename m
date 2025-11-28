Return-Path: <linux-spi+bounces-11660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA14C93329
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C923D4E254D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F452C3774;
	Fri, 28 Nov 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8DFbGk+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8A14F125;
	Fri, 28 Nov 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764365736; cv=none; b=MJVnAqzsIeNuNHABKWF4UrSKcGqA7YqXd8zuVx2efiXDC4hBmLYzj0vdQwHVosJjynqLli8XVYRxc/PjOyre55d15p9/w/5Edj9pFWdDCKHZ4f7Eq4zQlNeKYoc9GYPM4zMeX+6nB0DmV6R1FVAp4jle5BEdjn3wTvamks8DeeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764365736; c=relaxed/simple;
	bh=6CpapioBFitRHOM61yhAmOBjLch2RRdRiblF1PsKcYo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IsAuU15RLwrU29dCM2VRbbE9JluIQ0q+FJCWM7h1Uj9y1ByKkgagqvKCzI7Ir+/PEWMF41mh2Teu4+YPsPVhnzypv/zKNTcsNfsYW/dwWqHXU694nV72U5F07KsjU14cf2tspwmSyItFjlq21rgGqjzye17QrRld7F+1tpoVC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8DFbGk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD5FC4CEF1;
	Fri, 28 Nov 2025 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764365735;
	bh=6CpapioBFitRHOM61yhAmOBjLch2RRdRiblF1PsKcYo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=n8DFbGk+cLz8OXmAYsQVlOOZfkEEdYVxpRYm4oNJB9TXAO+LdoOVkXCcpxROQG6uF
	 xJONUZxpYrL961KYpHR1PtH+LJ02iWFGpcG1N5ATIuFIvJYxDzaBghqaOvFQGQQI3z
	 uNZiMhvqC5sK5CEr3rntJwPkcfSyzVwEu1WwDDlymMHa95ZIqSq4GgsX0aoSpa9DeC
	 9mp87ygnVM/99Z9jbFprCvENWPOMNdFEFKiLd+T3gAZrzdS5nKA6sFS31AA4vlKu44
	 87GBowgosciChv0mNA2bM0R0DBGjY+LuN2wtzENU+MzH+GdQN/7QWFakqGCG/5OOU+
	 2TOFMkWuqpu+A==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/6] spi: microchip-core: Code improvements
Message-Id: <176436573470.232757.12013375800658603323.b4-ty@kernel.org>
Date: Fri, 28 Nov 2025 21:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 27 Nov 2025 19:58:57 +0100, Andy Shevchenko wrote:
> While reading some other stuff, I noticed that this driver may
> be improved. Here is the set of refactoring and cleaning it up.
> 
> Changelog v3:
> - collected tags (Prajna)
> - restored dummy read in TX-only transfers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: microchip-core: use min() instead of min_t()
      commit: e29aca7038f3c292c18048922c5f4436a034da99
[2/6] spi: microchip-core: Refactor FIFO read and write handlers
      (no commit info)
[3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
      commit: 274b3458af1f9c665faae70b560852461c30acef
[4/6] spi: microchip-core: Utilise temporary variable for struct device
      commit: 06b010d3c778075108041074a8fb785074231ac4
[5/6] spi: microchip-core: Use SPI_MODE_X_MASK
      commit: 4db5a0705b1e03abb6ff4e7d7789b32c31384429
[6/6] spi: microchip-core: Remove unneeded PM related macro
      commit: f458fc9b1946bc882a217d65bfe5ba50787f253f

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


