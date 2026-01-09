Return-Path: <linux-spi+bounces-12239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DED0AFAC
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4058A3078EBD
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95C330D27;
	Fri,  9 Jan 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+hZ9rK8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA5313261;
	Fri,  9 Jan 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972611; cv=none; b=r3mC1qMW5EoWYh7aKHXfX2b3DpXBvMw9SpxSzaKVxb3VxIcVkwU+iXf/gVTNeBU6LkBNpwWScwc6YpeclpHndue9WA95WPFsForCr4KH6kD8ZCovFKpMB7ysZLdvV0WYPS+KbHG2m89GrR1oAB7wxOdQeIg/B5+8XZ8jq3o831k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972611; c=relaxed/simple;
	bh=Hu+suSqeAC73qWNDwf/X2dCSSGpxuISVJPtVdq1X+x0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sfDAsKK2m0aRd+rN9bgwY6gAgUo99O2pZZG+YFP6G2xmFoMjeQZuA8NYH5IuF6I+XSWoT1n+XUWlyKdqpFjXDeGQIF/o0fOSubcNs+AIKILBZoR3Uk4nirApTDsv+QYgrjbUUZrnLFlbjqK7Tphh8qVDWQUXcZqPKwqfXi+m7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+hZ9rK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2C1C19422;
	Fri,  9 Jan 2026 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972610;
	bh=Hu+suSqeAC73qWNDwf/X2dCSSGpxuISVJPtVdq1X+x0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=t+hZ9rK8oXWouW48hIJnIVdfBVeTA82wGCzMynnoeCoeHvon0/QV9a0cA1UCT/Ot+
	 QWwZpI4Py40WoHN5WrBBlMqIEBrywY3R+giBGEH++1o830CwaYJPk3cMiaopBQjeTm
	 wr7BpkQPoPfqP4ESvxVhzWiaXlfIcnxRb0j4rIbbWSdZhjgtN4eYcNE0DRBzBy/5qI
	 P5eP8EKJ2I9VTPzyb6r4qfbDxJhg9zXtDqWzlICoY7BvW7+2QDmPeoYstE9VLL39nB
	 GKvTFwgv9yvfZwMGXAGAMhRnF3L6xOaFmncqWut46F+XGbm3CzA8FIK5mc13j+UXb9
	 Z0tVo2U99NyxA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260108175145.3535441-1-andriy.shevchenko@linux.intel.com>
References: <20260108175145.3535441-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-Id: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 15:30:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 08 Jan 2026 18:51:45 +0100, Andy Shevchenko wrote:
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Simplify devm_spi_*_controller()
      commit: b6376dbed8e173f9571583b5d358b08ff394e864

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


