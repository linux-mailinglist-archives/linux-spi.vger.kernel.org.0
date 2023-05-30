Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99D7716B4D
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjE3Rkw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjE3Rkt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 13:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FACE11C
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 10:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC66E6315B
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 17:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2DC4339C;
        Tue, 30 May 2023 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468445;
        bh=9/VTo/U8Y27wlwxBTkPK9EJhdYwlyyuveYD1A6GQW2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fzt0l5QzQ9LIhT/UsnD/zi5KyBJo9G9Y55kC3Eirjp4RavaBqN+SXSCkrebQUxBGW
         v9w2S8bTL4c3WrSeT6B+rJ8Iyva8dwc12cQtEi2d8TEr4pkJNV8O9PRGjFuPhEWXNS
         pb6IspnYyA+l+qeaMBTlBbQ9W48hjb4WxFcQbr/WNkaD3VE1f2oUESTFyhvtRSW7ep
         wFGm3SrRwAFWToemu3u8g8ihiFnsP86oYOCyc5pECjs2xn6J4TaX7mKukJ+xX/MkiU
         m2eF/7gN2ETxTCPabODcGVnRYQMw3CROoBwhqP2fR5G66uZUP4oaif4mcsRiPpKLMy
         IlDEy4FDbPPtw==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] spi: mt65xx: Convert to platform remove callback
 returning void
Message-Id: <168546844352.691057.11112317404702040826.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:43 +0100
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

On Thu, 09 Mar 2023 10:47:01 +0100, Uwe Kleine-König wrote:
> this series converts the spi-mt65xx driver to .remove_new(). While the
> preparing patch that gets rid of an early error return is in many cases
> a bug fix, it's not tragic here, as the early return only skips steps
> that are not necessary after resume failed. Still rework the code flow
> to prepare for conversion to .remove_new(). The 2nd patch actually
> converts the driver. The third is a small nitpick cleanup the I noticed
> while working on the driver.
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

