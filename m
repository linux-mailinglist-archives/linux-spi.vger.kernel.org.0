Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651E645FAF5
	for <lists+linux-spi@lfdr.de>; Sat, 27 Nov 2021 02:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351887AbhK0Bf1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 20:35:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55936 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351867AbhK0Bd0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 20:33:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE4CCB829B9;
        Sat, 27 Nov 2021 01:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE946C004E1;
        Sat, 27 Nov 2021 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637976609;
        bh=kH2fRFc/FniuJ4KWRxODCZgNHM5SzLBnXgHbeOzTyrg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ujJsC9bje4YrH+K3KMC2R1/Mxwyrl8YGLsQfPre5P7WREq2Llslv+apLbwG1gBXk9
         GVzMitsi+17nc18lgApaZgNNXkp9POtLw2xl9KhyO4lAH5EabLFw5u8jmkJk6jbXrp
         7YKYYuFKzWOdOatLfzdUWQdNzu5XLpkJhXa+sRdmTRm562CTAoBL7IirEt1e/bn7cu
         Prlz8FqotmN31pj5sUGHuKmBLU9QwMsF4GXX3KXY1+S8N4grChbGMgjqh34m+vID2J
         o7jEf8sY9HCpjngBOpiP5I//NaOE1Ot9YfIFF+8jhvwcyNf1nMfrc8DvCOa0qQQ8+6
         EFuQCR7FKYZLg==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        linux-spi@vger.kernel.org, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-kernel@vger.kernel.org
In-Reply-To: <20211125124110.838037-1-tudor.ambarus@microchip.com>
References: <20211125124110.838037-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/2] spi: atmel: Clean usage of DMA
Message-Id: <163797660761.2988146.6224858401999788835.b4-ty@kernel.org>
Date:   Sat, 27 Nov 2021 01:30:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Nov 2021 14:41:08 +0200, Tudor Ambarus wrote:
> Cleaning patches done when reading DMA code. No functional change
> expected. Tested on sama5d2_xplained with at25df321a.
> 
> Tudor Ambarus (2):
>   spi: atmel: Drop slave_config argument in atmel_spi_dma_slave_config()
>   spi: atmel: Remove setting of deprecated member of struct
>     dma_slave_config
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel: Drop slave_config argument in atmel_spi_dma_slave_config()
      commit: c1b00674aab0c6950970e52c0f059756064a9e8c
[2/2] spi: atmel: Remove setting of deprecated member of struct dma_slave_config
      commit: f44a29ceb99fc99832ee1d55d7fe9c4dbf594660

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
