Return-Path: <linux-spi+bounces-8595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B75ADB680
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA01A188DB2A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142C269CF0;
	Mon, 16 Jun 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSkAjDcT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A920C030;
	Mon, 16 Jun 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090825; cv=none; b=tWQqNDGhs/hOWS/0c5m3BCNoCIhivWH9focbwGStJMSMM4CiySR2w5ODp/F6bE8tWmxAFzTcV25IelSCPy5RLr6E6qy/rNzZsm8JJRdQgDI7G5VdJnZ64cQ9CBHNFcQODhOG8jKBOchJLiab2Mf14ztKYh8y0xzEsY2RrfmUxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090825; c=relaxed/simple;
	bh=kLhHtvrDdsH/A1VjWV9b+OF8x5gSjBd5qG3IvXEFejY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DcJj3gV9dRau6FYosqLqhcFi4KzaoUFQ2NR+ZMDfBMheoy1umypDK4O3j1FVtDS0dRAvcxwtjTCAVBgH9XrXNmcB/T+RzZSdKxgLpBQa05bElloOYXAdhWyMBR22tbA6zyUi0SNg+PqNxF9TslQvgAVZDFlZKIty3wMfTVn6we4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSkAjDcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BAC4CEEA;
	Mon, 16 Jun 2025 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750090825;
	bh=kLhHtvrDdsH/A1VjWV9b+OF8x5gSjBd5qG3IvXEFejY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sSkAjDcTkNf0l0XibHmp4iF13gTnIhTQBqYrjkriQcUVdr/fQWmUKlgqcABulsO2t
	 sBwCo+uQA+hIr1VAYBvjBxK8EVGclR89K9ZVowJRXgei+Cfr/Rfln+AYAYMXc/EkC2
	 dDoa0Acnm4cgmNrkPbNFt7Q4M/LgnHAZuFZ/Tdazaj7MnUpC9CbVpsqw5DK2b+LlpB
	 EFold/wOBHepbW6OyCpORFex3IQ7mx36oj3gY/xFVWrxHasJHpmtsPjh+0X5afPsSH
	 Edp8ZWe4iVeWabIwnCjqPT7VHdbWlqPhVibZUKYOhniBRw+ajL/WjCVS2DLJFUf/Sx
	 YgmqNP0DtHchQ==
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, linux-spi@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20250616091955.20547-1-lukas.bulwahn@redhat.com>
References: <20250616091955.20547-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Revert unintended dependency change
 in config SPI_FSL_DSPI
Message-Id: <175009082316.296200.2676929998940689118.b4-ty@kernel.org>
Date: Mon, 16 Jun 2025 17:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Mon, 16 Jun 2025 11:19:55 +0200, Lukas Bulwahn wrote:
> Commit 9a30e332c36c ("spi: spi-fsl-dspi: Enable support for S32G
> platforms") reworks the dependencies of config SPI_FSL_DSPI, but introduces
> a typo changing the dependency to M5441x to a dependency on a non-existing
> config M54541x.
> 
> Revert the unintended change to depend on the config M5441x.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: Revert unintended dependency change in config SPI_FSL_DSPI
      commit: dce4bc30f42d313b4dc5832316196411b7f07ad0

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


