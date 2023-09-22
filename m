Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A617ABA11
	for <lists+linux-spi@lfdr.de>; Fri, 22 Sep 2023 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjIVT2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Sep 2023 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjIVT2q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Sep 2023 15:28:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3E102
        for <linux-spi@vger.kernel.org>; Fri, 22 Sep 2023 12:28:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BC0C433B8;
        Fri, 22 Sep 2023 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410920;
        bh=fIBB4yDNTaUQhW2gJXIjExFumdMsGaiFda7Y4UKC0Fc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hzzGUYbKgkknmj2nDvw7NzSk2UqIsZBH4TDJC6yyyipEY5N1j8NWkQpG/pQ0vt0HK
         kuGKlbOQOne8i5sH1HFHIzobc18dnTo8PHInzhKugZLrPo+F3T+9YrFD/oi3Wa9r3d
         guBnEtQINNZ5LXogp6FUdgzFUtSe9fRwsOcF2NKe8ONZCEjrcekCo8fnsypqi8dnPB
         xrElXxxYF6Q70f8G00ERYEKZkEY875xpR2rEquh2WSCovKLf7QX1KDwJ18h5LQSdnd
         Z2cExw1DM9jSb4kPJLyV836Dtt6XQptRav1Gq1gz0APDfRsZU/CsfotfIahxAuLeqx
         FKZqYoe1Hb03Q==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-spi@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230922090829.1467594-1-ckeepax@opensource.cirrus.com>
References: <20230922090829.1467594-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Remove spurious pm_runtime_disable
Message-Id: <169541091913.56410.4033535832752132627.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 20:28:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 Sep 2023 10:08:29 +0100, Charles Keepax wrote:
> A pm_runtime_disable was left in when the driver was ported to use
> devm_pm_runtime_enable, remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Remove spurious pm_runtime_disable
      commit: f6267c81dbd9c66e5d7dfd65e5a849f688c877b8

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

