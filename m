Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A933602C06
	for <lists+linux-spi@lfdr.de>; Tue, 18 Oct 2022 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJRMpl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Oct 2022 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRMpk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Oct 2022 08:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C976468
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 05:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E226B81E05
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 12:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F8C433C1;
        Tue, 18 Oct 2022 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097128;
        bh=M7HWP2I8N0CJ/enYJccZNvtny3B6zJKXPSbiBGl3PCs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DW/JhGUoGC93rp2bhm7MNtADk7l56RJK5zIMYQ2lnBJ6/SGmqhHedcuQpRaB8p2nt
         IWme/KoUDZ5oHOH6Iqly161ewVbBztCCKQNJ25Bta0TkNhBQSc7Q+w83NiSt8fkruu
         +VAxf2lB3OVt8KKs7ZU8VfW5T+9PIvs5RtGg42J3Bl7POlaXxWqTNqeOPkVH4C9Frr
         GLofyg+FjW1Oi0SVk4Co7O52dg7h/YywyvgCdGc7DMRVbgYJtvlruLwwHB5Q2qZU1Z
         RDQvRifqwETkAD4wLO/JCvcW17kV1TliKRGOxEKjmHzkAhBgWFEZIeNv+QQ6Yi2B16
         isYK70/YwCF8g==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     p.zabel@pengutronix.de
In-Reply-To: <20220928145852.1882221-1-yangyingliang@huawei.com>
References: <20220928145852.1882221-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/2] spi: bcm63xx: Use devm_platform_get_and_ioremap_resource()
Message-Id: <166609712700.385867.3047625085191857256.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 13:45:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 28 Sep 2022 22:58:51 +0800, Yang Yingliang wrote:
> Use the devm_platform_get_and_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcm63xx: Use devm_platform_get_and_ioremap_resource()
      commit: a008ae9f8336d79df589eb343a38080a4b98340d
[2/2] spi: cadence-quadspi: Use devm_platform_{get_and_}ioremap_resource()
      commit: 4e12ef2b2e3f65c4fba895262363c499476848a1

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
