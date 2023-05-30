Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA1716B4E
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjE3Rkx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjE3Rku (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 13:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516B107
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 10:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDFDF6315C
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 17:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB5FC433EF;
        Tue, 30 May 2023 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468447;
        bh=2ea8N67c7G2yOchRm+WL0kAMJsqs8Q3ilNqdiR2zHuM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i/Vl5v+gv/l3piJuaLKSeHoU1/AQhZIpgP8m0jLqxv9GRcTQqg9sSsje/Ea8kpkgU
         VMY9tMcf6VMSWiWEGDCb/cbKOiK54tCfoplGMNxOGsWlMIUGjs/JROUuJ4/t4opm7o
         vDVewVauKe0nEGBpfMCTxRbAwxL3Md/nlXUypBfmhD2jQUin2cG3dVqyLHvtbnOyTp
         ZuRn09LfPfiMwIbIRaLlqOUPMLjfqsssusES5jDtowwUuXJIfE8yO7NJeE95/J6fRe
         ahJJTzxf6hq1fcVQYkOktBAcoybQxvmrPJvrP98Z/pLXl3zJUT6n/u0aq8yNF303vm
         8v53gipcwNbhg==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/3] spi: mt65xx: Convert to platform remove
 callback returning void
Message-Id: <168546844548.691057.7800675401872237520.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 30 May 2023 10:16:45 +0200, Uwe Kleine-König wrote:
> compared to (implicit) v1 sent in March with Message-Id:
> <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>, I reworked
> patch 1 on feedback by AngeloGioacchino Del Regno. Patches 2 and 3 got
> his Reviewed-by.
> 
> Best regards
> Uwe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: mt65xx: Properly handle failures in .remove()
      commit: 22f407278ea43df46f90cece6595e5e8a0d5447c
[2/3] spi: mt65xx: Convert to platform remove callback returning void
      commit: df7e47196fcef5d5611caa65f91d813578cf3efd
[3/3] spi: mt65xx: Don't disguise a "return 0" as "return ret"
      commit: 6f089e986778d3657247fdc2b38bd38de796732b

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

