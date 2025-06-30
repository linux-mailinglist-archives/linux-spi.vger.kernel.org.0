Return-Path: <linux-spi+bounces-8894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7929AEDB6A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15125178F6E
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661D266B59;
	Mon, 30 Jun 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm4GsVS3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A1266B46;
	Mon, 30 Jun 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283656; cv=none; b=f+JxSnnxcNgWIOzRt+iXbjux59XYc7pJXwGNR8r+KyAuqe4nDmWrZtkToHqhhxdJyerJsPqX4Cdx0NFcp29R40oXU6lpEwWkH/MfqA2GypOptFcjwKMuZ53NWlYlO01hyUkCjqyezRkqFS73P4G4Vj49kgWdNTYrBz+b7GwOQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283656; c=relaxed/simple;
	bh=14x8rxO1dTki2C50KdfnWtkLKeoKjVQYPKucEise/aI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j1eFa9Rn2XcDz/EfyaD2SmJX8zAc2M4vD67v3GobEg2FBBnGf088qLePtwtgiO0Bz6xPKQeAvT37vs/sBOv2CnNkg7y05dSdfdPCYKeJ9qc4SBhSKI6WE14mEaHsvDvmOHLhDHc9FUja3+SbG6oWfiLzIdRIQXRaayC5v9AzcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm4GsVS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD9C4CEE3;
	Mon, 30 Jun 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751283656;
	bh=14x8rxO1dTki2C50KdfnWtkLKeoKjVQYPKucEise/aI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pm4GsVS3L1oSyibAPHbOH4GyDsWMWcnhmQYnoo9+JnHxOMB1EbkSw8WeKANrgza5E
	 q4ZO3RZK2Q0gw/rHhL9k33TOZ9rmWESDhqavuKRGlDsLrysbQl1zr9K6JK2eRjmlov
	 dUMu1iZCV3K8moQKxgqytFXd4oY9gE1S5Dl2vUYHw/lSwa2X3CAz3FS0Ozmu3MZUqV
	 8OF6tV9DLinQrYxvemVZlJuurHx8qeIbJeU5R3VamTVAOIvQsYxGkue0NSR0ixXPgP
	 qaoF4SYRLmT1kLbY5nYMsO7AaUUF4TeRWk0+KJnwkRbDdfd6ahS4R0biXL+vEivKIi
	 4qfsck5m2dU9g==
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de
In-Reply-To: <20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de>
References: <20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de>
Subject: Re: [PATCH next v2] spi: Raise limit on number of chip selects to
 24
Message-Id: <175128365498.28911.343801540946438354.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 12:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 29 Jun 2025 18:15:32 +0200, Marc Kleine-Budde wrote:
> We have a system which uses 24 SPI chip selects, raise the hard coded
> limit accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Raise limit on number of chip selects to 24
      commit: 96893cdd4760ad94a438c1523cc5ca2470e04670

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


