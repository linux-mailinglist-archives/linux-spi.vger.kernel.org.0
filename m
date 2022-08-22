Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541DD59C349
	for <lists+linux-spi@lfdr.de>; Mon, 22 Aug 2022 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiHVPny (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Aug 2022 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiHVPnE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Aug 2022 11:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7D205D2
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 08:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10DC0B81283
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 15:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA47C433D7;
        Mon, 22 Aug 2022 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182979;
        bh=w4/4SzBtTwywYR8deWlJIDJaepffBamUI4UtQ+Jr0gc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ghGYNUKkhBowwYIdPzVJ1ujJm719zu+5lEkHUNMljNSc1vDDuFY2ucnGTLJgpB94H
         taVOSVDSP81VCoON1xk1BrA/BiC9Vxvo1TfunJwGPLhcNJRwy6v/Y3L+PL70UJueVP
         jAoCi1PFo+ACRJU51Ylf2yAVgefrOBiDjO1DNYSN3I9/FygBL89dBtDwL8f496Ztwd
         R3W1sNCpj8jqg634ghaFz/yGiZJfXvK3Lx5z/iy/QldDt551r/I0cVcN2xdLcLkWUZ
         oteYCW9/JU+gwDwCnT1sdQJKcnHyTQ4k79hVvbJFa1rYUlLt9UMRc1+gj5hwW4+6nr
         Q/Owyx6BD+BTA==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220816130818.89600-1-mika.westerberg@linux.intel.com>
References: <20220816130818.89600-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add support for second flash chip
Message-Id: <166118297892.188530.10771525827521489007.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 16:42:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Aug 2022 16:08:18 +0300, Mika Westerberg wrote:
> Intel SPI flash controller has been supporting two chip selects long
> time already even if the most common configuration is to have a single
> flash chip for the BIOS and related data. This adds support for the
> second chip select if we find out that there are two flash components
> (this information is available in the mandatory flash descriptor on the
> first chip). The second chip is exposed as is without any partition
> information.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add support for second flash chip
      commit: 3f03c618bebb024bf8770a74480a9416c847ce53

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
