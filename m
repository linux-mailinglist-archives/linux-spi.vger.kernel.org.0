Return-Path: <linux-spi+bounces-10704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFABE519F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CF61A61490
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37214F125;
	Thu, 16 Oct 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0/nYnl6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC53DDD2;
	Thu, 16 Oct 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640544; cv=none; b=OiWzaY1XeF25ZpP0pUlMZpA1zvyEjJ2QDRfLnIRhgcZCZhSMrggiRMC1Y6wvG5214zR1Ti4XTAKfgvc/9qraMOMAUpZ26x4ANTSt1BeYvZ6BX4jA8o6YUQqCD3y6YtclblFztmqPAJT8EGEFFw24lScBcQSmQc/zQA8ShVFqrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640544; c=relaxed/simple;
	bh=1TvsNySS/ii619yRBomO8Shvk95ED2emXEbjTPkgA+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzKk4EJya6xrxcMRWeiNhZTy7fzftGTIbp74NGGcb45kylxyPQCyPYRaSJd0Iz/+/CKJ0Do/oLZ4TJcx7D4wMwfB1wFWr3J+Gmqaf/XfACKmhSRjYY6uMNrB+Njym4KIZkLhU8mxc5mo+g3xsPe6YmBpcZiEucpqjIoJ3DFewBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0/nYnl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E14C4CEF1;
	Thu, 16 Oct 2025 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760640544;
	bh=1TvsNySS/ii619yRBomO8Shvk95ED2emXEbjTPkgA+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K0/nYnl6qvn+UNnZq1lrw10RG/Gdx6hWYCLPnyOt7ZIyaBKZLw6e3+qg+B7WVo5Y3
	 YTibjb6/jRBuqzbjtdFbWKL37Fl39IaXtn1MkPmPsr6E4UZipnV0LEwb5CdrBO6wIT
	 Jxfbm8UTeEdFJnGI0+uYokyxMgZomw1AQhNFZ/EVgSQcrsJPMFaMeet6msUQMrTPeb
	 zHS7dXku+iXLSYBjrR8JFlVA3EmOFWLhTPA049mSPY2YAOHFLewNjpw5qIrL6NCeK5
	 GyI+D/5frdSk81snrtmXgCGjYOHIVxS6DL42bLh8jwlSZSRLUg7yg29lddVCTJAemr
	 eByPYIRjnOwpw==
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: (subset) [PATCH v10 00/16] spi: airoha: driver fixes &
 improvements
Message-Id: <176064054115.223781.11856902416382505599.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 19:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Sun, 12 Oct 2025 15:16:51 +0300, Mikhail Kshevetskiy wrote:
> This patch series greatly improve airoha snfi driver and fix a
> number of serious bugs.
> 
> Fixed bugs:
>  * Fix reading/writing of flashes with more than one plane per lun
>  * Fill the buffer with 0xff before writing
>  * Fix reading of flashes supporting continuous reading mode
>  * Fix error paths
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/16] spi: airoha: return an error for continuous mode dirmap creation cases
        commit: 4314ffce4eb81a6c18700af1b6e29b6e0c6b9e37
[03/16] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
        commit: edd2e261b1babb92213089b5feadca12e3459322
[05/16] spi: airoha: switch back to non-dma mode in the case of error
        commit: 20d7b236b78c7ec685a22db5689b9c829975e0c3
[06/16] spi: airoha: fix reading/writing of flashes with more than one plane per lun
        commit: 0b7d9b25e4bc2e478c9d06281a65f930769fca09

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


