Return-Path: <linux-spi+bounces-9079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD678AFEDDC
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02321C423E7
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5502E765F;
	Wed,  9 Jul 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJaOkhdx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63192E7655;
	Wed,  9 Jul 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075369; cv=none; b=rG1kip9i0GosiFOh+tiOQGnpK53fHk4/rm+n+gzmc59gbVvt8fBWWQE1/413qDUKMU6bEy0M8hZPi0HXLGRlWsUKr7sWw45CZ/5KC+0hH1zaLwe9tO13CqIx5vJqI690rnYIe4CtU39Oqgi+qb6Rwdw7MxJD9NmmEh+3WLch8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075369; c=relaxed/simple;
	bh=z5R0g5bRaFcE+byBEvAYFxwzxwtN+sL10BzKO0308UM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFXG5lCbSCsVVyf+bZaAAGkQnFJg6m8QY9a+0LMBctljsbG/JZpzkQG9iMgLdjJd3WhqgPphesLsywgowL9i9mAFt0sZFCRqIIqIsIJoxiMzbmEJV3QofgRUa45SXGzqF8QerVAhayOclxUe3LwuZZhMlwxDihIxdB7mH29o+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJaOkhdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F52C4CEEF;
	Wed,  9 Jul 2025 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075368;
	bh=z5R0g5bRaFcE+byBEvAYFxwzxwtN+sL10BzKO0308UM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kJaOkhdxWi9qV5vWcFnJ+JHTiQSlubZYl18mUsLG/pSBYdw+T1NKtWF5028TxIiFZ
	 wZfpISsYz6qDXmz2TI9Vt2XUjIKX936nTToXVpxLwiDoaCgB6R4T9SzqBhHgJFfpBd
	 DUjk1wdx3vSPwyZIM2EFvrhSQPqiWhpnXIU+dEh09EHx2ZObNI3mOIZsCcG9pdYe8q
	 BC4Z5NY1XOLoQTFEXD6LRKGjWkLN/mitCQSJ4wZRDpY40o5N+wT3fnKdwgpqCDUsHx
	 JG9DsmlWMhj+0erNX6r8khQZ4MuvF5NJtd+TeRO4St5FF7gaDqAbNdZh8u/V4dEqHi
	 8bPTgLe8qW+Og==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250709021638.2047365-1-robh@kernel.org>
References: <20250709021638.2047365-1-robh@kernel.org>
Subject: Re: [PATCH v2] spi: stm32-ospi: Use
 of_reserved_mem_region_to_resource() for "memory-region"
Message-Id: <175207536585.695960.5730567147905543825.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 16:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Tue, 08 Jul 2025 21:16:37 -0500, Rob Herring (Arm) wrote:
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


