Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C852C716B4F
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjE3Rkz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjE3Rkv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 13:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C4102
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 10:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E682C6313B
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 17:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CC5C433D2;
        Tue, 30 May 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468448;
        bh=yxVZ91y+n0HBSYpBdfPpqkc331hITmr98Xwjxyg8m/0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kA0E843iBW+VlO+IKaEYXQefV34ohoI2/g/miL8vepuB0/4Z7vITu5A0Pl/xGjT43
         e0LLvhR6iDBYGx2GAo4IrnA+btYgCHP0etncutHBbXSHw1N2Mv82WPpQuNbW42CcoF
         bALr+SaP7jZnoBpVYk2p3NOl/76bbReEDEIvrohFUTNCb8quMGUvjT5RZTCtOEoRgo
         Aer0lPdg03hKm3juigrTnfqBfUT1LpiZ+ML8cmz1z04yLoMZryz77hHaHKoaC0+ylY
         Uyq04YOUcj3aATrYES7lNSwWyXEtBNfDm14PEP3UYfOg1+y/C9QyuuYTHhRiZMXIgD
         +PFLZY9frfozA==
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20230528195830.164669-1-lars@metafoo.de>
References: <20230528195830.164669-1-lars@metafoo.de>
Subject: Re: [PATCH 1/3] spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
Message-Id: <168546844739.691057.17537818338753176075.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sun, 28 May 2023 12:58:28 -0700, Lars-Peter Clausen wrote:
> Replace the combination of devm_clk_get_enable() plus clk_prepare_enable()
> with devm_clk_get_enabled(). Slightly reduces the amount of boilerplate
> code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
      commit: 5363073dfcf087393c0587e9217ef50b1d63fcce
[2/3] spi: spi-sn-f-ospi: Use min_t instead of opencoding it
      commit: 282152fa9d54a84a486b93a913934c21503fb5db
[3/3] spi: spi-sn-f-ospi: Make read-only array `width_available` static const
      commit: 81ea9a0710bcf74934446f63898f0186aeb2b5b8

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

