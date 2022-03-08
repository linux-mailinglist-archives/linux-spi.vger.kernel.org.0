Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CB4D1EE6
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiCHRYj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349538AbiCHRXS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 12:23:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981554F9D;
        Tue,  8 Mar 2022 09:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB8D60C59;
        Tue,  8 Mar 2022 17:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D549C340EB;
        Tue,  8 Mar 2022 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760084;
        bh=FNYz6OULLa+Rcya9s7lAeIE0QFHR5q6J+q4WCzlyLFA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QX6PQ2XVQSPb3kMLPTkuFOKZqg88AXJMs8KXFGb2tBi9gE7aUaYbz1op+QwwLECZQ
         2K0bf6WgVl/gISygMJr6/pCHHreoWii9c2LmPQ9/APYybufYhRobO45qynY0YUkyvI
         xYGE66y8fe2z9XYOhxsI/iPYleNs3i1J6Iim3GSw8xBK6yFJW0Lpa3I9oBYniYtcJJ
         VHldwxSF6Hb/GzJMghTAYDhongf73oLjfgS7VBSdWSQuIX1qyuhKFzgBZoHwZfoKXQ
         4CtDg4EMUftwiNbgKVC3OJvNlqR6wzNyodemWrejlUTyKLrtnJp1gCrv97J8aDjcjA
         GteKq5C27DSQw==
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: Fix invalid sgs value
Message-Id: <164676008296.54593.5754827707694046382.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 7 Mar 2022 18:01:16 +0000, Biju Das wrote:
> max_seg_size is unsigned int and it can have a value up to 2^32
> (for eg:-RZ_DMAC driver sets dma_set_max_seg_size as U32_MAX)
> When this value is used in min_t() as an integer type, it becomes
> -1 and the value of sgs becomes 0.
> 
> Fix this issue by replacing the 'int' data type with 'unsigned int'
> in min_t().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: Fix invalid sgs value
      commit: 1a4e53d2fc4f68aa654ad96d13ad042e1a8e8a7d

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
