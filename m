Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97492772D25
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHGRiD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGRhu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 13:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7BF9
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 10:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E456862066
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 17:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8483C433C7;
        Mon,  7 Aug 2023 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691429868;
        bh=KxRO8GCv49oJ7LjC1S+CLJ5YzNMpUcR3GpqWoMiY7RQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OqeE2ZK+mrhG+dfvgG+mjSSjjyY7VdgO7GAdXoxaqSQfKZYQ7GeBw0ia34AMFqSPh
         gMj4gnrq1/hDZJAey14HTiLSRPPP+gHqitNXfAIXZW7wHBrPKHJPvRY5dtzI5kK4wP
         8D3tMR1N1d4tysDtr+ziCv8OaIODlT2kKpXWIC8UwBCfLuUFoOKiCEHujYvTH+eD8r
         F/BPYGMyNF9gt4r6JHxE0OU6kmCJ0Oi1RcLupUB2b0ckR3nwD0ccGCEkLgQ7xPiF2N
         972eedUbm3bPkBssjvt1IKdf4/GsULr6FRsih7cg0UKvYx5VvXKx/6mlq4TrsbsX0l
         envUPoyCeOGZg==
From:   Mark Brown <broonie@kernel.org>
To:     florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230802093238.975906-1-ruanjinjie@huawei.com>
References: <20230802093238.975906-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: Do not check for 0 return after calling
 platform_get_irq()
Message-Id: <169142986647.186586.15665528504726933668.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 18:37:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 02 Aug 2023 17:32:38 +0800, Ruan Jinjie wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Do not check for 0 return after calling platform_get_irq()
      commit: 8102d64c04e8ead02c30bb07ff7dd5c41ed61bce

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

