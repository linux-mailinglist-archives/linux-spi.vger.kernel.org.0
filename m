Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8F5469FC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiFJP7M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbiFJP7J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 11:59:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BF31DAF22
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 08:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF5BB83630
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 15:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EDAC34114;
        Fri, 10 Jun 2022 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654876745;
        bh=weHwEH66EfvWXGzmQ2x8i+st3SEIh5/RpAWf9mVLZQ0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sMbDWHBiiz3Ej/nBekjJ9tueu0XtORdZTiDD95KoABp3TZeDZxcze7Wy0a4Efl45R
         Qnv36yQF3jODmIHIvCVqYnMO+MSKj1NA0Bp7hOCTYXpdsTrX/eHwcUk94rhkTWBdtu
         Hd0VDON3pbTBpX3jeUt1XPzLpFbeLK4bhPJIRXf0Kpj5qLwZCgoyagpiSuo+MPoyR8
         HwjENOLAPs79bxe01RyFZKl5U4PUFuet6h5ZIupSXh/FaPbocKhZrp6cSbzzylxZtf
         MIpnAiDkbkDM01MbM99mHpuOiNW9u83Zh5mdzlTW/l8eR+ZNjAdB5SUZxulpj0kKHh
         9Jmf/G+0+LKpg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, andy.chiu@sifive.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com
In-Reply-To: <20220610074459.3261383-1-andy.chiu@sifive.com>
References: <20220610074459.3261383-1-andy.chiu@sifive.com>
Subject: Re: [PATCH next 0/1] Add simple PM operations to sifive-spi
Message-Id: <165487674459.1756526.5750583671148030437.b4-ty@kernel.org>
Date:   Fri, 10 Jun 2022 16:59:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jun 2022 15:44:58 +0800, Andy Chiu wrote:
> The patch has been tested on Unmatched using pm_test. The Unmatched board
> uses SD over SPI and it was tested by initiating S2RAM cycles for all
> devices while reading/writing files at the same time. We found no dropped
> connection to the card or corrupted filesystem during test cycles.
> 
> Andy Chiu (1):
>   spi: sifive: add PM callbacks to support suspend/resume
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sifive: add PM callbacks to support suspend/resume
      commit: a1f0161eadbd7941c09b5f4c6a210c390d2b86d6

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
