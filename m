Return-Path: <linux-spi+bounces-10670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283AABDE6BB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F79483884
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E6326D6B;
	Wed, 15 Oct 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq1YtCRa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378C326D67;
	Wed, 15 Oct 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530448; cv=none; b=KYrI/iaoNJ0AsQklkxS1t4Eu/TZuIp4dJYdV1L/L5IpYpm21E9J1xqugriXQ3wi1hRNRCHyylQp0m0UZ1LMsnacdbns7l6+tQq/SkC5ChEZ5Rbo46pjHgv3XjCd3NjGjUr85+pGokPgl1G0cSZHnaup04AaZNrfU467sFG4Mzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530448; c=relaxed/simple;
	bh=0yab+UhBeGarlvAjvczeEodl/ADOmB9NPD67HB34+6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T3CZH2KucqvmFTFEY+UlFyuZ3kHZXfrikr2AyhrcrB98/PRQEZy7BwG2FR1bBj7rMFghomlCXdTtaw69J931eCGfBuMTTZrrnLaOKLsQb1sMmm6kdObe6Q7OvO/n3tykn56tYzgYq2katODsIMbFHUF8oDQ4Q5CTX8Go5kF7uHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq1YtCRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220A7C4CEFE;
	Wed, 15 Oct 2025 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530446;
	bh=0yab+UhBeGarlvAjvczeEodl/ADOmB9NPD67HB34+6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rq1YtCRaOdtjn9pdJS7wn7VF9DCWzegNtKIvfKtjnOkrAP/DER7F2bDmFtdzW1wkX
	 PjOqatJCxL2UeE7Z2bwhtQJ2tzRAV8cb2BcG/b++HPXvVk3WmKGY5/IrggIdRO6rzJ
	 QGp9xcBEtNAoiWxvWZDSolfnoL/PdjBbnRGi1iRQEqPmRF1tPwP1NjlvTkRUXgey9W
	 w1OywuGu77sU7I4kI7E1DnY8edw8TAQKwxKdhWBRo/3hEKIrfWtqYLYfTNeFQqO5VW
	 k3HytFCDVrkxsFf1zTFbgxceSaHOn0fmOTDkGrMlq85uoKg/CNCBw5iPT5YeNQX2GU
	 M1g4TpL+CHaow==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
References: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
Subject: Re: [PATCH RFC 0/2] Add target mode support for the DesignWare SPI
 controller
Message-Id: <176053044486.105519.3995515775023859907.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 13:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-96507

On Thu, 02 Oct 2025 14:14:36 +0200, Benoît Monin wrote:
> The DesignWare SPI controller can act as a host or a target; the
> choice between the two is set in hardware and cannot be changed by
> software. When configured in target mode, the controller has a much
> reduced set of capabilities. It only has a single chip-select input and
> can only run standard SPI mode (no dual, quad, or octal mode). Despite
> this, the overall logic of doing an SPI transfer and the register layout
> is identical between both modes, so implementing the target mode reuses
> much of the existing code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: rename the spi controller to ctlr
      commit: b926b15547d29a88932de3c24a05c12826fc1dbc
[2/2] spi: dw: add target mode support
      commit: fe8cc44dd173cde5788ab4e3730ac61f3d316d9c

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


