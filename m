Return-Path: <linux-spi+bounces-9095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0CB03BFA
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C731A60628
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33B2459C5;
	Mon, 14 Jul 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsheUnp8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FB22A808;
	Mon, 14 Jul 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489226; cv=none; b=DiX6OSUsfMlmBrbfSQ8f6MQd93wx9LXs4zY4jaeHjed+BAPFpp0Mp9GoVSMhoreBifuPgIuH9DEONZiJtPaN5+Aj4COF6eKwjcMZprkx/stsdZ0jLR7NLv7oB9xNRAU5HY+0lIVM1BBnY9lmZrH4M23fxC9lRcPPbHjQJ0ze7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489226; c=relaxed/simple;
	bh=SWVRq9s8qi4vJBJhqL/e4RYaOr864sv/OrB9hMLrPRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=quFZessiSHYHTdkhxY3zC780YqX8q3jaKRVWuXaQHl/Z2AAyirKnRZy4BBbS7R0smu68lnfdN08yCkvyasWaJbPfoFHUQvo8uSUB1vqLo8VR+T4xaXHZAYB1zaurKCrmmGqI5zzNM3U0TglJc/s2NfobeCsrCduHqK7x4hc8luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsheUnp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B13C4CEED;
	Mon, 14 Jul 2025 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489225;
	bh=SWVRq9s8qi4vJBJhqL/e4RYaOr864sv/OrB9hMLrPRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fsheUnp8PcWtoHD4n4iByTCF0+zkJyNJoOSR9CqUIgZwegpP1OvJD5XY5YhXFL0rF
	 C/v3rr28VzO4eWGcz5DwxfY090knqgTsRWL1b6wsVYjeHR44QWVUsm9kNQ9AfhMnUz
	 vhu3bGMrqqQjCcWKZ5/I3DkqJCFgrFNM/x6W/aX+bOO6kBzB5IKDyMXF88or3UzvV1
	 1ajGThnWfNVIimAHj+pfBASJrDXjWwoBXHwNImGC1tbkz64Ooh0hOgj3rEC6wBrWU6
	 PVSKAEpxT5oUa2ntL1oAKRb0UqkhbtwEXNDCid/L/tyewT/9NvON99OGN5iBJzNfn2
	 69HyLmi/jyc7A==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250703183537.2075746-1-robh@kernel.org>
References: <20250703183537.2075746-1-robh@kernel.org>
Subject: Re: [PATCH] spi: stm32-ospi: Use
 of_reserved_mem_region_to_resource() for "memory-region"
Message-Id: <175248922378.18393.12584887132414171200.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 11:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 03 Jul 2025 13:35:37 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"
      commit: defe01abfb7f5c5bd53c723b8577d4fcd64faa5a

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


