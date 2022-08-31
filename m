Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372445A7DA4
	for <lists+linux-spi@lfdr.de>; Wed, 31 Aug 2022 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiHaMlT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Aug 2022 08:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiHaMlR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Aug 2022 08:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDA9C8FE;
        Wed, 31 Aug 2022 05:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E422B82062;
        Wed, 31 Aug 2022 12:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0365C433C1;
        Wed, 31 Aug 2022 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661949670;
        bh=GlqPyBG/2QZHbPqaaWonjRMxL4niWdBcQJxyKEdjQSk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gNwuWskc/jXU/OrebX3y24EoJciyi62c5H6tEuPGRlLQ+alc5tVqmdzZDmAVXi3Ud
         MTw042H61ryMiZrFzQqF28RjgkCVuMWzValPBezeBZSbkfjqhmRAS4fasfq35SMot3
         xQtL9Q6Q+DQga6bzAe3ws6RbvHwAaaLmzlOYB0y9RDIdcyUAlxm6j/Zz7XiBaZVTF9
         kKoUWS5XduYHs8kbhkKS2YrFa+G2TQxJt813jLoNQJg5Ene0jKdVJAiALr4OtpVuvf
         v1Twttg65eM9lvEKG9AKDgvVhfC0WW7xBilKgwSUXNKynQq5bvBJRpmdV7d+p0q70f
         XI0HOQftONieg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/3] spi: add generic R-Car Gen4 and specific r8a779f0 support
Message-Id: <166194966864.85432.14716335347687736430.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 13:41:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Aug 2022 11:43:23 +0200, Wolfram Sang wrote:
> Here are the patches to enable MSIOF on R-Car S4-8. They also introduce
> generic Gen4 support and move V3U to Gen4 (which it really is).
> 
> Wolfram Sang (3):
>   spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
>   spi: sh-msiof: add generic Gen4 binding
>   spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
      commit: e1e62f05d5d9d7726349e00562299d829e478ce9
[2/3] spi: sh-msiof: add generic Gen4 binding
      commit: ea9d001550abaf2f4c75cf4fcd936ea19f932b84
[3/3] spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
      commit: b076fdd02133e6a31db167f8acc368edc2530cc0

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
