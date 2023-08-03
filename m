Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60A76F1CF
	for <lists+linux-spi@lfdr.de>; Thu,  3 Aug 2023 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHCS0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Aug 2023 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHCS0x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Aug 2023 14:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E17A3
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 11:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3545461D5F
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 18:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B1C433C7;
        Thu,  3 Aug 2023 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691087211;
        bh=Dt7kJpA1K8z1lhv+3UmqMe5wvwr7W70+nNpptkJL/t8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ilcW0ShrKpASNG1362RsvjqmlxdB+6tu6nhZDkFjkifY1Kktq7vFNFwfkid55E7ui
         HuLQL0kON9rzvgldkq2pA4OF+8gEeSB+M3gFNeGmO8Jt93gqQ1q+nrSBCJt3Vx7rCF
         CZ0SEuQLw/FfLqYUfats9Gqp0mGpuQd5Qr9OQrsIdhfdNQjDSZFR2ofDEPMrJXwKEj
         hQHgp8xmG1ZU0KtJGMhfV88D67vR9PKYboxXxi4lfh2FxNzUNaha7u8ILuipTKcRQR
         ZZEUXomVGExcBfBJbvT/gzhF6nxwFw5cvPX9WCVer/HhlXngcDBaythH7F71EF2Gdk
         BuFKYP3Pu4phw==
From:   Mark Brown <broonie@kernel.org>
To:     andriy.shevchenko@linux.intel.com, Li Zetao <lizetao1@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230803134805.1037251-1-lizetao1@huawei.com>
References: <20230803134805.1037251-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] spi: mpc5xxx-psc: Fix unsigned expression
 compared with zero
Message-Id: <169108721063.116022.8792896376818972888.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 19:26:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 03 Aug 2023 21:48:05 +0800, Li Zetao wrote:
> There is two warnings reported by coccinelle:
> 
> ./drivers/spi/spi-mpc512x-psc.c:493:5-13: WARNING:
> 	Unsigned expression compared with zero: mps -> irq     <     0
> ./drivers/spi/spi-mpc52xx-psc.c:332:5-13: WARNING:
> 	Unsigned expression compared with zero: mps -> irq     <     0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc5xxx-psc: Fix unsigned expression compared with zero
      commit: de5e92cb5cefd2968b96075995a36e28298edf71

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

