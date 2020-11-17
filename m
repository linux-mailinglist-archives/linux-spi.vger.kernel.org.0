Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B82B71B8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 23:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKQWip (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 17:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWip (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E3520715;
        Tue, 17 Nov 2020 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652724;
        bh=wHy2P0xb54yFxWzSQj7Qowcm8SXFHPL2YFDPyxGpG7Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qKRPLLi1XaoN35ASNfhgDA9V8BAFm+St9tAC7gr9XPoZWv48u5a71S9MoumvD+8gE
         V8JL3cK/b//kgBsF39UvTZvIMEh65IStyn1kSIcU1rFJ8sODFKQi6i8a9BgirHocB3
         vWR1TbP7x9BBkIW8V7rlefSlioXeJ508rYd2A7Mk=
Date:   Tue, 17 Nov 2020 22:38:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
In-Reply-To: <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de> <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe error path
Message-Id: <160565269952.23908.15969685283681589514.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Nov 2020 09:23:10 +0100, Lukas Wunner wrote:
> If the calls to of_match_device(), of_alias_get_id(),
> devm_ioremap_resource(), devm_regmap_init_mmio() or devm_clk_get()
> fail on probe of the NPCM FIU SPI driver, the spi_controller struct is
> erroneously not freed.
> 
> Fix by switching over to the new devm_spi_alloc_master() helper.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: npcm-fiu: Don't leak SPI master in probe error path
      commit: 04a9cd51d3f3308a98cbc6adc07acb12fbade011

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
