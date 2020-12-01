Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385912CA4C9
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403887AbgLAOAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 09:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbgLAOAL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 09:00:11 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7407208FE;
        Tue,  1 Dec 2020 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831171;
        bh=Rn/Kl40yNcBnOCyq294nMqi1Xg+6oVIOdLhl43RGVVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CHhvei+mcRvoUbGW/Fmp59pwQISUgsxfqrGqIgApT48MHbz9uPAyn+G/krgbBw1tz
         Cm0kbONV9mhh2+8wmEP+lHgqf2FbpNtsZpT9YrsmdmHcRGRfLToxThkmTXujnLLlh4
         ZndI+hsCH+PMJJ+LqkyoCrWbBYNguAVvrfz76aFo=
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
In-Reply-To: <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de> <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe error path
Message-Id: <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: npcm-fiu: Don't leak SPI master in probe error path
      (no commit info)

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
