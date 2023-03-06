Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDA6AC139
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 14:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCFNde (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 08:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCFNdI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 08:33:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271552F7A9
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 05:32:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE6AEB80E40
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 13:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA765C433EF;
        Mon,  6 Mar 2023 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109544;
        bh=4wwI0hQDakHiL7l0I0rRMWYhIVloyJWyXyiQc5eRiRM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=vApjjlMZqCNAqvSdqdLPXuP7wEz73skQXQka3Zv1EiDOeUn9DVDdwLK+XMVNGdx50
         7N3LDB1FJ8lA9BkW8okboZBmpQ4S+j4focxWAW7MDDvCUjpx0B17DHCxoAo9z0RBpE
         c+n/ZpPoTOiSasUkdoR8mCu5bVV/9xcMw/Onv2ZWiFJBjdK2B1ecrwKlpIMI9mrBrm
         NGMosIzh8L9aef9qHsNP4UdEysyTEP2DjM04oHzW3lFbsFuwhfDd5bMnxlktR5pzG6
         aDQ3m6ZijsnFOIrQA53Fmw0ohynElCMk+2uZWohLDBazLr2elDW2NW+OiJxweHI07m
         ZdbCwlGdX5FqA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eddie James <eajames@linux.ibm.com>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
References: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
Subject: Re: [PATCH 0/8] spi: Build coverage cleanups and improvements
Message-Id: <167810954160.76172.6882624542653908410.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 23 Feb 2023 17:20:20 +0000, Mark Brown wrote:
> This series opens up build coverage of a bunch of SPI drivers by
> allowing build under COMPILE_TEST where possible, while also adding
> appropriate architecture specific dependencies to a couple of drivers
> that didn't have them so they don't show up in builds when they're not
> useful.  We also have one fix for the dependencies of the s3c24xx driver
> which was turned up in the process of doing this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: s3c24xx: Fix dependencies when FIQ support is enabled
      (no commit info)
[2/8] spi: rockchip: Add architecture dependency
      commit: 330a200d360f8b140b31d7da8b657da0472484e6
[3/8] spi: nxp-flexspi: Fix ARCH_LAYERSCAPE dependency
      commit: c6b15b2437a10b7b381d32f4a5341f655bfa296f
[4/8] spi: davinci: Make available for build test
      commit: e48d57d7203441b7a32b4275462ebb9296ea3fa0
[5/8] spi: fsi: Make available for build test
      commit: f916c7080d28831493518364492e33fc6a437907
[6/8] spi: qcom-qspi: Make available for build test
      commit: ada850541ad33f621425a382d0810b839cb3169e
[7/8] spi: s3c24xx: Only have compile time references to FIQ when building it
      (no commit info)
[8/8] spi: s3c24xx: Allow build test coverage
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

