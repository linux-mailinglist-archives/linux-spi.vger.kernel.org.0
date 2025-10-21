Return-Path: <linux-spi+bounces-10762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFFBF7494
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E0E1880362
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3D33FE29;
	Tue, 21 Oct 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmLaVyzi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A81E00A0
	for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059778; cv=none; b=VCqQUqiNms/2+spA9MezrSCj7vD8m8hSw1BkZAnbQd7MFsB4mg0b9YuwV/FSw/LZ0t2XRis9EsgV5LgQryUGXL2+ZMKKLt8PQPK+1ft2BeRuri3X1dmizEEsrH8iAL8sEyrPMr8d0eX+8mxH1jhKD3eixDAFRQosiHf55UzZVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059778; c=relaxed/simple;
	bh=kvNMb3H5fiVeyt7+FmS6/SSMoJAzNut3Z4EMBO8V1Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ye7yFsk+Voum+AusThC1nZAP5bTdSyl92uazFwOWDCeH/B8Ce7WUxrkIQjRlgZb6SX847zHMfsB+5BHNMhZR6+PgklKRN7dIWdbNRR34tKjgG0JA4Fqs8qVTQbeZgmdp5//t92UVMeKduQSNoQmtxDwDnTKKwjf/a41fLxBB7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmLaVyzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B0C4CEF1;
	Tue, 21 Oct 2025 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761059778;
	bh=kvNMb3H5fiVeyt7+FmS6/SSMoJAzNut3Z4EMBO8V1Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CmLaVyzikhRE2suH3HaGYe6Wa92EjAoIGi/uSwvllqnR4dmxx7A6n9flExIb4Rp4o
	 AoLRQ8oyAzHP6iea+WD69hkX4SMugmzI1/myitbCwGr5SsY/hfLST++7nOkrpS04Al
	 mGL1y6xyXjbm2/jlDdl3cWx95OosXqUYU9IyXE15kM5Ms/9938+1pvr351vNqPYkBF
	 9L2otyEo/7hzxl7Wt4Lj/oKvbPqKpDvtxGHyo4n98cSHX6qKqOVawigb/WNWc34f97
	 WanPnsqC22Gw1EL9b2J+LUgXH72Zk2BDWK/KMkTs2CqvOKWAhZfE0sadq0iyInkYtS
	 7kDwMTiOZFTew==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
References: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3] spi: intel: Add support for Arrow Lake-H and
 Wildcat Lake
Message-Id: <176105977748.185666.13917314217353247204.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 16:16:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Mon, 20 Oct 2025 16:54:12 +0200, Mika Westerberg wrote:
> This series adds Intel Arrow Lake-H and Wildcat Lake PCI IDs to the driver.
> Also add support for the 128M component density that is needed for bigger
> chips.
> 
> Mika Westerberg (3):
>   spi: intel: Add support for 128M component density
>   spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
>   spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: intel: Add support for 128M component density
      commit: e46ee2f07e5848d7ec7aec38b72476dc7941b048
[2/3] spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
      commit: bc25c6e0a4880b5ad70c31fe1466f30c9e4c8f52
[3/3] spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash
      commit: f7e37affbc9085f2b77ccb6596521a44eabf7505

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


