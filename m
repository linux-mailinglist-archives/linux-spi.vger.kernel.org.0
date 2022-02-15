Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A014B6CC6
	for <lists+linux-spi@lfdr.de>; Tue, 15 Feb 2022 13:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiBOMzO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Feb 2022 07:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiBOMzO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 07:55:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272B43AEE
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 04:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BA41ACE1DCD
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 12:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010A4C340ED;
        Tue, 15 Feb 2022 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644929701;
        bh=/K/C5MmofYFveDTJql+hvt9kSya/8PLf1e+nz7pSBUE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R7hIu3rkp7t8TBP1x4dbEH8eEWmADb0fTkAU6r0rvRlsLFoI666arD9towYOQ02da
         66hkTPGC/n0wXBl6SXtj9n/3p74uv3bzdKG/k+vOMh/BYyBZZOfrXUq5UFEdZ5hNNW
         hxqjiTKreZfcfyP198q4JRJ/LMCEdydDQj6GKrO6LGlmOtBZZE+tXGkWE+oNW2X80i
         /pw3rlc3YC0DAdynZGhWuqvEHyjsAZK8apGrEOCp+1hst88lm9HvreRH8vfmhvS9OL
         jolouQSrjjvix1KZUQb6favfRoMCDFA2XqOQ06ysQbRioXhvEj2dSmBIfYf1xv7eOl
         /IBrE2nSO5/cQ==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, Michael Walle <michael@walle.cc>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Lee Jones <lee.jones@linaro.org>, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
References: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM
Message-Id: <164492969770.14011.5135767095761454169.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 12:54:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Feb 2022 15:27:03 +0300, Mika Westerberg wrote:
> Based on discussion on the patch I sent some time ago here:
> 
>   http://lists.infradead.org/pipermail/linux-mtd/2021-June/086867.html
> 
> it turns out that the preferred way to deal with the SPI flash controller
> drivers is through SPI MEM which is part of Linux SPI subsystem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
      commit: cd149eff8d2201a63c074a6d9d03e52926aa535d
[2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
      commit: e23e5a05d1fd9479586c40ffbcc056b3e34ef816
[3/3] Documentation / MTD: Rename the intel-spi driver
      commit: 4ab13489735d9b5b6e91634eab83922914a3310c

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
