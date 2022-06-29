Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16FA560386
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiF2OoS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiF2OoP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC624BCA;
        Wed, 29 Jun 2022 07:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A3561F5F;
        Wed, 29 Jun 2022 14:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCBEC341C8;
        Wed, 29 Jun 2022 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513853;
        bh=VKmQkXSSr0fp8xEEhrHuI4jJj9kI+Q29PnoOBCQnruI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vA081Ef0eFD0cI0hgJ6BpR90sEWAJutJfPskioZSCiyzd77Bif/1jnqHnZNZIgg9m
         VAobGxTWWQMyurZW7mLUkZpRd5ZpE9IwDUevCR00zm4nb6uPGZoMCR3pLU+fTxtLpk
         JgPSisiqIEqY8UfN9l8gNsSu0/uBXmuDKxN5ZV40ebwUKkPLauOuIAvwiar9/Y9WeG
         A8or0hfYud6Y6TkS5TrM2GQwpSvX1n5SAe/vph/Q5FiETupIEDlyhSrCXQzPgLkCet
         idpVeTgzkKWL7NNRr1i0pIO4smmMHuG8ETZVc3pG/Riyx5bo9s62nf4b2XeFA0rXO8
         7Vj+Pe+dXD3rg==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski@linaro.org, andi@etezian.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        chanho61.park@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        alim.akhtar@samsung.com
In-Reply-To: <20220629102304.65712-1-chanho61.park@samsung.com>
References: <CGME20220629102527epcas2p4ab04f91877e5f744c4a4e37827d19ce8@epcas2p4.samsung.com> <20220629102304.65712-1-chanho61.park@samsung.com>
Subject: Re: [PATCH v3 0/4] spi support for Exynos Auto v9 SoC
Message-Id: <165651385163.1635474.11164615734135811182.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:44:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Jun 2022 19:23:00 +0900, Chanho Park wrote:
> Add to support Exynos Auto v9 SoC's spi. By supporting USI(Universal
> Serial Interface) mode, the SoC can support up to 12 spi ports. Thus, we
> need to increase MAX_SPI_PORTS from 6 to 12. The spi of the SoC can
> support loopback mode unlike previous exynos SoCs. To separate the
> feature, we need to add .has_loopback to the s3c64xx_spi_port_config.
> Furthermore, it uses 4 as the default internal clock divider. We also
> need to clk_div field of the structure and assign "2" as the default
> value to the existing SoC's port config.
> Device tree definitions of exynosautov9-spi will be added in separated
> patchset to include usi(i2c/uart/spi) nodes all together.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: s3c64xx: support loopback mode
      commit: ffb7bcd3b27e86fa7bdbabf4488060064ec9d00d
[2/4] spi: s3c64xx: support custom value of internal clock divider
      commit: bfcd27dcb7b93bd1f3b89d03d8b90207876d635f
[3/4] dt-bindings: samsung,spi: define exynosautov9 compatible
      commit: 9dbeef8ad5f8e7d2cab7b888853b4abe9db87ffd
[4/4] spi: s3c64xx: add spi port configuration for Exynos Auto v9 SoC
      commit: 11d50d853dceb2df8d28bf772d3e928c1c5b137a

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
