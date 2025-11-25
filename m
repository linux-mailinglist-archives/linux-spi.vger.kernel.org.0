Return-Path: <linux-spi+bounces-11526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC5C86AC9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E14535270B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCE332EA4;
	Tue, 25 Nov 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8xJE1U5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85D333720
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095942; cv=none; b=GiFSuMgA3LWfYE3V4+XE1t0zfau5CLDoB119GxvthSeF9grJvCC7se4NQ2nF6ZPHwSrpFLZVUd0wYmT5CvyLJ7zH19vqNCEdjrgJrYkdDkEo0KcEa6e9BWBXXXTW54UZVLv2dA1sd2XKyZ4jFw+nZ0fPvl5L8FUiHbEnJygaBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095942; c=relaxed/simple;
	bh=7msVHRMgfuBGApMOY0c0mw0ij991lqhi9AiYQyvi8Rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CjNT/IGxESHk971EirWO/Z0SporGAV2FSeYdskFUWQTEDCYmlwfq6qlyXXSlg+CYONGhfvrew7c4yKWVotVkBAbc/NpZ5T8fKjSwHoEV8ppyeDE3l5vna9MI19MNtZlwoxgFV9NMe26cryeHGLMZvA9ewX/5OuDOPxheiyUKcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8xJE1U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B9BC116B1;
	Tue, 25 Nov 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764095942;
	bh=7msVHRMgfuBGApMOY0c0mw0ij991lqhi9AiYQyvi8Rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W8xJE1U5mCk7bC9unq8pwl8gZ+dwtPGn79qxgqi3sITggDJ54QlwIhguJdKJATy0a
	 KTqWCUGCKZ00BzVCxgPtBy3kC4cSaqFm+p20/9qU4d6aiSAV8WJTIychw/VvIYVQkL
	 DxxsOKdcFWvi7pXK+arsrez1pqJv6TWIfvEH+NZty9yV5KNETJduQQbxp5cb1k+gkc
	 X6kv9ktwIgiJjMKmLpOmk1eRmYvPIDDU/CZZyLNRcqRNzT6GrmbX1/r3XeAl+Bd3AE
	 RkZog9yLnaRZnIWIJE2CGOZ444fpl9MWA7JyLfwsbf9v34Xz1Tsgih5rxMSPNB9UJi
	 +EuML+8FIA1gw==
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <6f96848b026f9a343b80d48179149b30c6b76d1d.1764086805.git.geert+renesas@glider.be>
References: <6f96848b026f9a343b80d48179149b30c6b76d1d.1764086805.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: microchip: Enable compile-testing for FPGA SPI
 controllers
Message-Id: <176409594105.75217.8728695838751104227.b4-ty@kernel.org>
Date: Tue, 25 Nov 2025 18:39:01 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 25 Nov 2025 17:06:56 +0100, Geert Uytterhoeven wrote:
> The Microchip FPGA SPI controller driver builds fine on other platforms.
> 
> While at it, drop a superfluous empty line.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip: Enable compile-testing for FPGA SPI controllers
      commit: 84b7344c05c5e48db4cf75cd3e91aef8d553d88e

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


