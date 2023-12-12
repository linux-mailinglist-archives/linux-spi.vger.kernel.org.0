Return-Path: <linux-spi+bounces-243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E080F16D
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D688E1C209DA
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F567543F;
	Tue, 12 Dec 2023 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGuSYHc4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79F745EF
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 15:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE7C433CA;
	Tue, 12 Dec 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396001;
	bh=npFv0GC2jS38Wue09TN42fa8abBDimUnv2/tnlDWw9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CGuSYHc4KZ31GO9Eo0TIgGapwyHaBTh0dMftbDk5VoaHIRiPnCG5ssPZU1RF1mAiR
	 qUKxRKeKyQ7lEGFulA0ddYaBKyuPPSXCWRYVD0Aew4pQYG2UNlUK9/37PHQuhjAmBN
	 GgyC04lTZfrv+Ytj1ShES/enda4MqlEIGZ/19iSLk+ZhQU1KffLeUwSY/NJB9AR7vv
	 xAZ+rqQeqICFBe5xID3daufmrpKVN9LPZzYVt3hjorqJT3DWd/bAnrZsA0l5SC+xxE
	 9msH9U7dXm0dIJIJoiVTQA6jpSjrS4gzg2SOJTPZGRf0zHhci+QKnWdI+lm0RA7eNH
	 mNpYUHm26v4TQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
Cc: geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 00/26] spi: switch to use modern name (part5)
Message-Id: <170239600077.81606.3314413555263764870.b4-ty@kernel.org>
Date: Tue, 12 Dec 2023 15:46:40 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 28 Nov 2023 17:30:05 +0800, Yang Yingliang wrote:
> I'm trying to rename the legacy name to modern name used in SPI drivers,
> this is part5 patchset.
> 
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller. Each patch compile test passed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/26] spi: sprd-adi: switch to use spi_alloc_host()
        commit: 0a3d087d09a8f52c02d0014bad63be99c53c4812
[02/26] spi: sprd: switch to use modern name
        commit: 8c53784757b7fb2bf75e36ae5356628a8baeffd9
[03/26] spi: st-ssc4: switch to use modern name
        commit: e6b7e64cb11966b26646a362677ca5a08481157e
[04/26] spi: stm32-qspi: switch to use modern name
        commit: d9ea4bcf244d936d74a5993ae1f778f8cb9a479b
[05/26] spi: stm32: switch to use modern name
        commit: a5c1fa1318ee72b9809f105207570ef55c7992d9
[06/26] spi: sun4i: switch to use modern name
        commit: 6d232cc8a7e59af0c083319827541966a68817a0
[07/26] spi: sun6i: switch to use modern name
        commit: 9f55bb79893a9dc75982372bee1307bdce48976b
[08/26] spi: sunplus-sp7021: switch to use modern name
        commit: 90bbb007a06aa7b0f428a89531dec064ec584d8a
[09/26] spi: synquacer: switch to use modern name
        commit: 3524d1b727a66712f02f92807219a3650e5cf910
[10/26] spi: geni-qcom: switch to use modern name
        commit: 8726bdcef62eac46c80830e6154c442fbca6d928
[11/26] spi: tegra114: switch to use modern name
        commit: fe2e1c2225986b49988189ecd42dc233c10f237f
[12/26] spi: tegra20-sflash: switch to use modern name
        commit: 5ee8cd26d8ebd889c270a6851824b7aeec38f3a8
[13/26] spi: tegra20-slink: switch to use modern name
        commit: db34aad4d61b0034c896a7abb481b32fcdcd8332
[14/26] spi: tegra210-quad: switch to use modern name
        commit: 767e45324bf8fbbaa5463a692ad697226425d28b
[15/26] spi: spi-ti-qspi: switch to use modern name
        commit: 9d93c8d97b4cdb5edddb4c5530881c90eecb7e44
[16/26] spi: wpcm-fiu: switch to use devm_spi_alloc_host()
        commit: d1d8b09d0a0a86fb785dbb0d69765fb98dde429c
[17/26] spi: topcliff-pch: switch to use modern name
        commit: 40daed14705ee76b35717ffedc80a7f281023bca
[18/26] spi: uniphier: switch to use modern name
        commit: 4c2ee0991013ca8a32bb093a017d460204790112
[19/26] spi: xcomm: switch to use modern name
        commit: 4e4856e721041fb6e7386369433a4850b34dde1e
[20/26] spi: xilinx: switch to use modern name
        commit: 709b785a377c06535a98663a227fa82f61b08aec
[21/26] spi: xlp: switch to use modern name
        commit: 1633ffd290c77eb6e2c5500a25faf9fc2640b0d1
[22/26] spi: xtensa-xtfpga: switch to use modern name
        commit: 061851a0cc5dae1a992edd4d573a7dc514bb7fbe
[23/26] spi: zynq-qspi: switch to use modern name
        commit: 178ebb0c505b0a35edb4fb2a0e23a1f29e1db14d
[24/26] spi: zynqmp-gqspi: switch to use modern name
        commit: ca6f114372ae4d05387f0ccb5d4b2b1320bf22b3
[25/26] spi: cs42l43: switch to use devm_spi_alloc_host()
        commit: a23271718e767e8b701693b140fcc021a4e90b1b
[26/26] spi: ljca: switch to use devm_spi_alloc_host()
        commit: 4ac9ed81aaaab128b98855cd6005a52fa65dd4da

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


