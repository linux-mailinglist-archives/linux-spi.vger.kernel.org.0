Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44DD54B78A
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jun 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbiFNRVM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jun 2022 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbiFNRVH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jun 2022 13:21:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693A533368;
        Tue, 14 Jun 2022 10:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF288B81A23;
        Tue, 14 Jun 2022 17:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96982C3411B;
        Tue, 14 Jun 2022 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655227263;
        bh=H1QnnYuu79Brr4UFw4i2NQ/qxYgrNRCtdf3rDoVLQvQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uhY8CRDQu0OOJXrUsTcxOP0IsyIscYKfVEcZBLBEPiSdQR1jQvtth79h98UcMtSHb
         NF+JXgSIQZUK7zgYHnVcZ4ypr2qunvg+3a4+ty79xc4JAL1BJr8HiCf/p9Mu368wxJ
         VMYz/goEbvFBoRcaSJorKRVpNnk+dS9WXMuSlF/jk3AtcBv+g3Z/yvjnzsb8BD8CEI
         8xlpb6B9biXjs8BTrIgkmmZYrWF/UhP4sk1DQAj3XR8jQeJjutk95E/2ixOL9WOoHP
         kES2A5xLLpgLmjSpuqWFxl0a8+YrsUO9b3wYDWtmm9PRIVwmRTpu1/ROd4CAWwfBQ/
         4RUrv5JCuJQxA==
From:   Mark Brown <broonie@kernel.org>
To:     dan.carpenter@oracle.com, david@protonic.nl
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <Yqh6bdNYO2XNhPBa@kili>
References: <Yqh6bdNYO2XNhPBa@kili>
Subject: Re: [PATCH] spi: core: Fix error code in spi_register_controller()
Message-Id: <165522726234.2442444.7031364557722004032.b4-ty@kernel.org>
Date:   Tue, 14 Jun 2022 18:21:02 +0100
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

On Tue, 14 Jun 2022 15:09:17 +0300, Dan Carpenter wrote:
> Return -ENOMEM if the allocation fails.  Don't return success.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: core: Fix error code in spi_register_controller()
      commit: d52b095b6cb4dca3bdbc144e7098abdbbd45e9bc

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
