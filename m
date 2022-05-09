Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70B520685
	for <lists+linux-spi@lfdr.de>; Mon,  9 May 2022 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiEIVRc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 May 2022 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiEIVRb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 May 2022 17:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBE253A8A
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 14:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B803461731
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 21:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861B1C385BB;
        Mon,  9 May 2022 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652130815;
        bh=eX5RGjni7aVHVj7ofAU71C/bqCjvu2a5IhhgBjvmk9I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SIpDFmizVRabw2UxwtaxVyRVNKFJkAeZ9BTPhKowbUPl6ES6ZV79VpjxSEUG6sQKu
         idge/oHQLQLxUySpLaiduJbFKrgdonbpc6IdE90RbYVRNSUcWjzHqtmwLD1u4xax1p
         a/3p8G0xEV2Wh7R1v9Qt6aoudUufd26mzHkmOJZlIj2Wn2JBxKnfiLcmBWAMv7hmtS
         xrtFvcWFR89aj6jqul5a1Wi/p3bLfMOSx13B73MkwPNLV2w+F4sB0JyHfbOzeJU6+P
         abnjqUBij50FJYT7DiSuBlmPXRa0rYgVf6dUIsWyFPONOX3gQdzlmg+iUiEo0MQuu3
         AE5gUYYLD7zdA==
From:   Mark Brown <broonie@kernel.org>
To:     marex@denx.de, linux-spi@vger.kernel.org, mkl@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        baruch@tkos.co.il, linux-imx@nxp.com
In-Reply-To: <20220502175457.1977983-1-mkl@pengutronix.de>
References: <20220502175457.1977983-1-mkl@pengutronix.de>
Subject: Re: [PATCH v1 0/9] spi: spi-imx: cleanups and performance improvements
Message-Id: <165213081325.1980477.1425594067155934605.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 22:13:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2 May 2022 19:54:48 +0200, Marc Kleine-Budde wrote:
> this patch series first cleans up several sparse and checkpatch
> warnings, then finished master -< controller conversion. Then PIO
> based polling support is added. It's activated by default for
> transfers smaller than 30 µs (like in the raspi SPI drivers). The last
> patch optimized setup of the MX51_ECSPI_CONFIG register.
> 
> Changes since RFC:
> - rebased to broonie/spi.git for-5.19 (thanks Baruch)
> - 4/9: use swab32s instead of swab32
> - 5/9: use swahw32s instead of swahw32
> - 7/9: removed "select SPI_BITBANG" from Kconfig
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: spi-imx: fix sparse warning: add identifier name to function definition
      commit: f7b8787164551a09fca287b1dea15d0c4d646e4a
[2/9] spi: spi-imx: avoid unnecessary line continuations
      commit: a8c785c1e75538876b524247a3738db53b1f78b8
[3/9] spi: spi-imx: mx51_ecspi_intctrl(): prefer 'unsigned int' to bare use of 'unsigned'
      commit: 1a23461a8a08c4a32972dec31a394eee3302511d
[4/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): fix sparse warning: use swab32s() instead of cpu_to_be32()
      commit: dae336d0dca669143e0fdf6b82c333bf6a8d9e0a
[5/9] spi: spi-imx: spi_imx_buf_rx_swap_u32(): replace open coded swahw32s()
      commit: baaadffe8854ea14eed1a5f3c09f2136c3aa4427
[6/9] spi: spi-imx: complete conversion from master -> controller
      commit: 63cd96b70f9366f67048fbc07294ce5823001ded
[7/9] spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller
      commit: 307c897db762d1e0feee9477276b08f6deca4a5b
[8/9] spi: spi-imx: add PIO polling support
      commit: 07e7593877882fbd07c55b26b7dcf88760449323
[9/9] spi: spi-imx: mx51_ecspi_prepare_message(): skip writing MX51_ECSPI_CONFIG register if unchanged
      commit: 184434fcd6177b76f929570348935d7c9f22d296

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
