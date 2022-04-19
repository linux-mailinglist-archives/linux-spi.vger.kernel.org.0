Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071A8507CBC
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358295AbiDSWs0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 18:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358293AbiDSWsY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E1220C0
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 15:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 508CCB81CA0
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 22:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5328EC385A8;
        Tue, 19 Apr 2022 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408338;
        bh=MPM6F4hEHxteJLrP20rAghvWYbhiS5GXxcCSpvjwNpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kgtJ8GT9L8jYLN4UfvHvugU4jx6A4yCx3dnmRQtU3kgj6TlckQUPwKlDcbJ7ii/zC
         TBuUJmBB4cI7TrsgDTYvUKj6OHpospWt1jenr4xfQiq5pMolXWdisecSmgLv0qJUbb
         fSZPx/O0Ah9kSHvCQ2Asy0Wc+RUDsFgNOVs4de2YIfqPt8YAzK42Y2tApofZgJnOjj
         ORrZLLiMqYgtRG8VTGkOwb03EPurwncBU0qkVb9bfxdReFIXX5wwYiSDq+d0IN3iwz
         gYfs5KxOEg8ACnkOi4HYZqkMtOVYkt+bEvstgrghXSJ7foqO/t5Ib0DVWzun4y18EZ
         Qj6q6jmvGiLAw==
From:   Mark Brown <broonie@kernel.org>
To:     baruch@tkos.co.il
Cc:     linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        baruch.siach@siklu.com, shawnguo@kernel.org, kernel@pengutronix.de
In-Reply-To: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
References: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
Subject: Re: [PATCH 1/3] spi: add SPI_RX_CPHA_FLIP mode bit
Message-Id: <165040833605.1910395.14510755928127229030.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:36 +0100
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

On Mon, 11 Apr 2022 21:45:27 +0300, Baruch Siach wrote:
> From: Baruch Siach <baruch.siach@siklu.com>
> 
> Some SPI devices latch MOSI bits on one clock phase, but produce valid
> MISO bits on the other phase. Add SPI_RX_CPHA_FLIP mode to instruct the
> controller driver to flip CPHA for Rx (MISO) only transfers.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: add SPI_RX_CPHA_FLIP mode bit
      commit: b617be33502d2bfefffef71924c7a7ba50264ff6
[2/3] spi: spidev: add SPI_RX_CPHA_FLIP
      commit: 178d0cbbfe8ec652083058968c7a27485eaa33d2
[3/3] spi: spi-imx: add support for SPI_RX_CPHA_FLIP
      commit: 79422ed9bd7fbd79f84d8a5abb0094c16221f55b

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
