Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF5225D31
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 13:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGTLMZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 07:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgGTLMY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 07:12:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B43122B4E;
        Mon, 20 Jul 2020 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595243543;
        bh=9Z11NjrdHxD4ZMDsaTBFbl5whcyGl2ry/jTN0Nd2wO0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=agO4L6N/Y9r2RdoE23pTf1tXzJOz/WCZvUWn8VeZi/c4wXORrWfJczR3uablzHAUA
         qSA84Tb5vjuw+6fzx1HQHYvNaNkX3kLruvzgijpW3TFBWHMeZUeixZtrLpvnnmC7J0
         HEX0N05SY7Af9MebcYEW1suyQ3i9nAj1XG/yefMM=
Date:   Mon, 20 Jul 2020 12:12:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
Subject: Re: [PATCH v2 00/14] Rid W=1 warnings in SPI
Message-Id: <159524352070.8289.18199395609391654734.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Jul 2020 14:54:10 +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/spi.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
        commit: 055fe5f499b6783a3eac4978c9012ff08934f37c
[02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
        commit: c13b5044ab0a484dfe4a8a1d946f3da6abb8d245
[03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
        commit: f6305d2706a7f1427d237044c470057508836590
[04/14] spi: spi-ep93xx: Fix API slippage
        commit: dfa51f6db34608d7829a5ef6add11557e548969a
[05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
        commit: 78a7f0c0a170ddef39822b8ec2b6311f0f27ea9b
[06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
        commit: d9b883aeaeb05d196244383ebe1bc52e39697948
[07/14] spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
        commit: 6b8d1e4739f41fcfb5d9adfd91b0ddfd1487c7e5
[08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
        commit: c7cd1dfbd8bbd4a61a39773537db541e247a7ab0
[09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
        commit: e867feecda9bbbf854a5e6d8c5d765e31ebc545b
[10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
        commit: 4b42b0b498124e4d38eaccbbb6b79e2a0ad1e047
[11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
        commit: decf5326944bc6c32c9256f3992adfb7283cb0f3
[12/14] spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
        commit: c894c265a43ecba365f5a061cf44f739fa639f9d
[13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
        commit: 9b2d611929afefee78037c92919d633aae35636a
[14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
        commit: 85ed0f63c0e362afc51e541a8216a58094c36f6b

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
