Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81C4D1EE1
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 18:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbiCHRYj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349554AbiCHRXT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 12:23:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4E54FB4;
        Tue,  8 Mar 2022 09:21:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 199C260C77;
        Tue,  8 Mar 2022 17:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BFC340EF;
        Tue,  8 Mar 2022 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760086;
        bh=3tX4L2ZEAjrfT5Nq61I4oCuKP1yIHPFegzKPN8nbS70=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K1bvMV+yI83CagGIJq3Yo3VJC7hn/msOqDW9E79MzNPgMpbjXAnjhz2T0OQuzXg4d
         q29qbcyTdEecLdakR6ubvJlJnnCSWn2FOH58MYSqAJwt8WXESNQgcNgIUUsKKSZ1ll
         IRHAanuF1J0orAGtGGOkfdBCm65+tNq1pKTUMPF+vwBiQvxTAlpxptbGwqhSwBq9xO
         6giVWxLXgvFOh1eBt1C5tUXTkspHdlCRe6Yztdf8HvNnFrCCZkrCYI6DWnsHGJyvgt
         p6BDGrXe2CMNdb6mR9sGRjOQy3OctAHp3LTlyACRN8YwMRyG35dy92WxsIPf6U3CpH
         4/WENPx52VjnA==
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
In-Reply-To: <20220307184843.9994-1-biju.das.jz@bp.renesas.com>
References: <20220307184843.9994-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] spi: Fix invalid sgs value
Message-Id: <164676008483.54593.3017081285231022143.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:24 +0000
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

On Mon, 7 Mar 2022 18:48:43 +0000, Biju Das wrote:
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
