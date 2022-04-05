Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6F4F35E6
	for <lists+linux-spi@lfdr.de>; Tue,  5 Apr 2022 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiDEKzs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Apr 2022 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347090AbiDEJp7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Apr 2022 05:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEDC51588;
        Tue,  5 Apr 2022 02:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFF6616C1;
        Tue,  5 Apr 2022 09:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88018C385A2;
        Tue,  5 Apr 2022 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151141;
        bh=VRTf+8SLE8ZMTKojd3EASetnluqVW687H4SXF0zsW2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JGtBZ/oDh86pEqP+OmDia+U3LygBe08H1yRMKvoSoDISAgKGXy9tazlTO7w983gk8
         tRYxp5nx+OL45gpWUhCLHHHVZcisMk6kb9WrRhpJPki1J88iS4hLxtKUjHiSVklUSh
         Rb15NCy14wT1yiNxK3cKubuuTUB7A/+rav0vyE0QxGG8ryr7l0xzlR0s2ZBfeR3lsg
         LqpAthEpMyNIaQN8XWNaJGEkWFRZOZhezzEgkukHfO8jnH4i2YwJr0RzgPmYIO6+MJ
         Nd644F067ZxZDUOCGMdwXw9YKd2rYSWqDl23K4eVZwjZo1wB+cY1qcI29ZP4LaZwE0
         H+hZtYTka4yUg==
From:   Mark Brown <broonie@kernel.org>
To:     vigneshr@ti.com, richard@nod.at, wsa+renesas@sang-engineering.com,
        geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, miquel.raynal@bootlin.com,
        krzk@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH 1/2] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path
Message-Id: <164915113927.276894.7805335417707613893.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:19 +0100
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

On Tue, 29 Mar 2022 16:00:38 +0200, Geert Uytterhoeven wrote:
> If rpcif_hw_init() fails, Runtime PM is left enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: rpc-if: Fix RPM imbalance in probe error path
      commit: 2f8cf5f642e80f8b6b0e660a9c86924a1f41cd80

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
