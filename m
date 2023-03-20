Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC62A6C209E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Mar 2023 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCTS7Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Mar 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCTS6z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Mar 2023 14:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60694367D8
        for <linux-spi@vger.kernel.org>; Mon, 20 Mar 2023 11:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28005B8109D
        for <linux-spi@vger.kernel.org>; Mon, 20 Mar 2023 18:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E8C433EF;
        Mon, 20 Mar 2023 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338250;
        bh=o2EILG64CMbwIg1B7Eyv93qV2xgJAhf/DOchQYwZArc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lj6ZpH7xtGstkLyJCaP4p50sM9MFDBpLPIaSiP9y+UkMvNM7Z+kiC8970ZW2Kffrk
         oc5acigGWQcLUq8JmCZX2p4UB4SdgPoyFfXYrqK9+dFe/Ox7NpzwM2ehum4+J9b9Uu
         X2LOmfqQJYWA7bUJhnLSy978Gmpzmjvw+pNgT227VwyPriY15WG5l1M4CqrxmmtAH3
         PG6msPMVoyPrVLklG2ESzN/3sYQuROy0zUNUwg3C+/dhVoqYAo3PFP2SCoiAqqqH+Y
         Mssh/Jx21XhOiEaEIaZPq36Ugo+OtKkkLFAYA91eeBfhwI1eSUb11wdj6KOPOoLrL8
         eoylE+M2DLLfg==
From:   Mark Brown <broonie@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
References: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] spi: sprd: Convert to platform remove callback
 returning void
Message-Id: <167933824910.203761.16428038901346444875.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 18:50:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 07 Mar 2023 22:14:24 +0100, Uwe Kleine-König wrote:
> An early error return from a remove callback is usally wrong. In the
> case of the spi-sprd driver it's not that critical because the skipped
> steps are mainly undoing the things that a successful runtime-resume
> would have done.
> 
> Still it's cleaner to not exit early and not return an (mostly ignored)
> error value. The second patch converts to .remove_new (which is the
> motivation for this series).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: sprd: Don't skip cleanup in remove's error path
      commit: 5cb79889a0bab6832662ec5b8f7d1f0e6e7c25ed
[2/2] spi: sprd: Convert to platform remove callback returning void
      commit: 3b74dc8acd5c2e59d4a1988a87d64b08fba56d5f

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

