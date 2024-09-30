Return-Path: <linux-spi+bounces-5060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B498AF4E
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10BA1C2142F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E8186E52;
	Mon, 30 Sep 2024 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rln9JFxX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42300186E38;
	Mon, 30 Sep 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732523; cv=none; b=aDCKcUGwUOe4SIspX6ENBU5UVN2t78k83FTScQbrQK8STNSpKUo1gqs7fBqWhdh+vKSB81KiMW2KZae/OoG3WmvwsE/JWLvqoMMkjQW+dRHIl4WzArkm/qUafXih1LwyZq4mPFPzvbl7Ynv8LQpR8wgFHqkWut5LwxtW7dgQMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732523; c=relaxed/simple;
	bh=E99hk/TucNLQUc9m3YOwaKiY6UUbxeZjmcah/1Epxec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ronfYVjMv/gsNuQhVBzyiIcU9EAOEcqigifK43CJBEBmvToZ8aI9knZ2sftkA8O+DtFdEMOd/mtbNNcvn/2RjfNpxmit/K6XmrssQg9qqhFw9IX7RofIBVyEgIvOh32fc3c+zEXNHNpm2t7JkSoCHTc/P6me6+TLKb7Ma7sm8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rln9JFxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5458C4CED0;
	Mon, 30 Sep 2024 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732522;
	bh=E99hk/TucNLQUc9m3YOwaKiY6UUbxeZjmcah/1Epxec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rln9JFxXShSjK5x46Ih4DdzRvBOhBx8kvnq0JJ2379GDxKREo6LN/rkbhUWrqmrtT
	 C1FcD0M6UakIlk8/cucNtLpzDx5hm4OgH0Y6PvrNJ+GRhareddDRFV59qv4yoXruFj
	 0As88IV4CGLbtzPy6B7zwNSB6ufNkWm2zHh1On0M4ojgyyQdqOxa7hKvVtuxaAU2Td
	 POh2ts9USyGWnyHazH8UHIUl3i0EobKP3drHhFtf3+k/+XVxve4m8VGiyHy415c/Hx
	 cONqBfD3qJJqGsTzxV0Ph7WNcRK8hOmEir+9bzhUKDGOPsQfBAQ9e9+XWotfx9Mj8Z
	 XEF36VUgg/xjw==
From: Mark Brown <broonie@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240918082744.379610-1-ada@thorsis.com>
References: <20240918082744.379610-1-ada@thorsis.com>
Subject: Re: (subset) [PATCH 0/2] spi: atmel-quadspi: Fix and add full CS
 delay support
Message-Id: <172773252165.2210210.10772394857607229655.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:42:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 18 Sep 2024 10:27:42 +0200, Alexander Dahl wrote:
> when testing on a SAM9X60 based board with an FPGA implementing a custom
> SPI-MEM protocol, we found the need to fully control the delay settings
> the atmel/microchip QSPI controller offers.
> 
> Greets
> Alex
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: atmel-quadspi: Add cs_hold and cs_inactive setting support
      commit: 625de1881b5aee6a42a3130004e47dbd632429f8

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


