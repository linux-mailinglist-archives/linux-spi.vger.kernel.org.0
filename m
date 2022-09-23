Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F35E822D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiIWSyd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIWSyY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 14:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F550122062;
        Fri, 23 Sep 2022 11:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA9061251;
        Fri, 23 Sep 2022 18:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA4AC433D7;
        Fri, 23 Sep 2022 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663959256;
        bh=NL83MbwMKvoDGgUjy35miEo+M2RNgSWZIE19grGSXp8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rfYntpmAd4nHpxCM+4hs+aoFLJhcc+1bBWXrhhWUx45PwvIPe1JCuRd0Kv8zcCRXM
         2QAbdeO3+EtuqYK/R3idy6XC/tQ73hFs7MQV7sV6jepaFBK0qz2NKzMwVkcXgM5qG8
         2exIKa9TdobpKCkFbUmr/GtnE4kXOBNyqP8PqEYw3ZJL8o2BvkF+M9lt2qIBotiqCQ
         XihIB28Ush0bjnqafoXd6GsDiSNue/rSgUxA5oB56K2AkEBA9lTkkaFwkIohPhzWYA
         L5P83MWi7+pM/gnV9hS2BoDQOv1DsQXPBAyP2Pk4L4hoY2+MkUbmRPf5YoLGswo011
         PrekFID73G0NQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     alim.akhtar@samsung.com, krzysztof.kozlowski@linaro.org,
        andi@etezian.org
In-Reply-To: <20220920142216.3002291-1-yangyingliang@huawei.com>
References: <20220920142216.3002291-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next v2] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Message-Id: <166395925523.804455.13427451370524340043.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 19:54:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Sep 2022 22:22:16 +0800, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c24xx: Switch to use devm_spi_alloc_master()
      commit: a6bfc42f30d11f22d2dacb2362d6069643b15393

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
