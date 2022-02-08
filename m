Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA734AE1B8
	for <lists+linux-spi@lfdr.de>; Tue,  8 Feb 2022 20:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385631AbiBHTAZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Feb 2022 14:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385660AbiBHTAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Feb 2022 14:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7D2C0612BA;
        Tue,  8 Feb 2022 11:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 047A3614E5;
        Tue,  8 Feb 2022 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91181C340ED;
        Tue,  8 Feb 2022 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346822;
        bh=x7Cg6DsGf+3kZH0y3tn63HpnQtCVa0lOTBUssXE7/jk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u2nZcWx9vdDcN5f8YxyKuKdv+DcFNJOu8INNPbfgMhmXsZOexeG4bjKXxHz95ngWg
         wTQ1BzHnD7dzv4NBNS2FJbDM7J+OKMIQk+kmTo4HRr8QQdIcwpMABnYAlzNt5qBq8Z
         5XOgIPYpWUSNjoBErT6HK8s6gAk8UAP6sQibfedvWrASqQapAEubbaSgbQ67+0stVd
         /UdQx/itwa5jDtckv8d+vfU3PTyjjxE+CUKubOe1fyRyGfxEm7uRhpymgGegcMnEbV
         cOx23m2grlp/dhfC4nHZ/WPXQlrZTYKqLoOVkm1AKEhqLdiTiqekudoaH3ZUmFAw05
         gPGeEP78XKAjw==
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220125065202.GA8807@kili>
References: <20220125065202.GA8807@kili>
Subject: Re: [PATCH] spi: spidev: prevent spidev->speed_hz from being zero
Message-Id: <164434682130.1135514.6941363158812350659.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Jan 2022 09:52:02 +0300, Dan Carpenter wrote:
> A zero value for spi->max_speed_hz or spidev->speed_hz does not make
> sense and trying to set that can lead to divide by zero crashes in
> a some of the drivers.
> 
> drivers/spi/spi-s3c64xx.c:874 s3c64xx_spi_setup() error: potential divide by zero bug '/ spi->max_speed_hz'.
> drivers/spi/spi-fsl-dspi.c:613 hz_to_spi_baud() error: potential divide by zero bug '/ speed_hz'.
> drivers/spi/spi-xlp.c:146 xlp_spi_setup() error: potential divide by zero bug '/ (spi->max_speed_hz)'.
> drivers/spi/spi-orion.c:162 orion_spi_baudrate_set() error: potential divide by zero bug '/ speed'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: prevent spidev->speed_hz from being zero
      commit: 833026ad56f76d1a1035d6511fd5aeed308465fd

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
