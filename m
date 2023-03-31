Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3B6D239C
	for <lists+linux-spi@lfdr.de>; Fri, 31 Mar 2023 17:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCaPId (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Mar 2023 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCaPIc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Mar 2023 11:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199174209
        for <linux-spi@vger.kernel.org>; Fri, 31 Mar 2023 08:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB13662A1E
        for <linux-spi@vger.kernel.org>; Fri, 31 Mar 2023 15:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB1C4339B;
        Fri, 31 Mar 2023 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275311;
        bh=jy1icU8rtlov+UdtygoZwTGeyK/4rNBTQGJkMhsrGks=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FftH189sRWB2iZmV5H9p0pNqkLbiF+MiEmjcnWhAaiaxlgHYex4ntxnMXeJ9OS4Eb
         3bMR/rBkqmAJlSkApHeDRAzX+jm61e5UEFaar6edKfIekl8Q9Me1WVGmMzHwPsnKXl
         lQi7+VugalJDht2quaxBHPpFoxXvThn09dt6kVzEvzHPJh82uvvKp/WHuVLDf/GwrM
         h0sNiSZAhK5YbI9IecgUy8+v3bqMILFCAVavf/KbeaccS/nzQyzw7tk4vMlP+JfOBM
         eIprtL1r9KwOmhv7bD3T9xcJ6kTKauho8OoEpzQywc5KeAWfSOJzMyWrpgs54hAB/7
         H3uak03c0A0eQ==
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
In-Reply-To: <20230330211022.2460233-1-u.kleine-koenig@pengutronix.de>
References: <20230330211022.2460233-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] spi: bcm2835: Convert to platform remove callback
 returning void
Message-Id: <168027530876.3368485.16768985506253948694.b4-ty@kernel.org>
Date:   Fri, 31 Mar 2023 16:08:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 30 Mar 2023 23:10:22 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Convert to platform remove callback returning void
      commit: 497667ab9016ba508bb0591b6e9d15597127b034

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

