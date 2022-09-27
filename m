Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17795EC57C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI0OHT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiI0OHO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 10:07:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF63167048
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 07:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB47AB81B2B
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 14:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8038C433D7;
        Tue, 27 Sep 2022 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664287630;
        bh=hld466zl33HHFlpe14ACet4OIRkkh9WtQnHraZhHheE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ivcm5jRhbFU4SaybCM4A3nOvhJwCEShEF6lmy9q0XNszy4auYaB4rnYj1ofcg2ay0
         GAnFOkrCmnYs2fxrb6yMW8jq1GDegpRnfhbwCJi0CeHuT9JphBY5Pq7KCwU66eym7z
         p0Lo3D04I2qdt4+ot//GYGXihgUS9iH5mhjXKr2sPWkFnw2FCHYCAUEGwhGNHsYgu7
         WleHVpf/w69Vun7VXOG+wuR8Bszom8xhzVC9Jm0QgM12kSbGIknLhDQLKJPiSWjbsj
         3I8rMhww7No6fAITKeTFh/jl0FN9hQ0PhKD8fq2fUoRV+U9/9CbzC5iVLXL/dCKIbt
         FbygUeoXb+TcA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Zhichao Liu <zhichao.liu@mediatek.com>
In-Reply-To: <20220927083248.25404-1-zhichao.liu@mediatek.com>
References: <20220927083248.25404-1-zhichao.liu@mediatek.com>
Subject: Re: [PATCH] spi: mt65xx: Add dma max segment size declaration
Message-Id: <166428762966.411857.10933365033486535060.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 15:07:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Sep 2022 16:32:48 +0800, Zhichao Liu wrote:
> From: "zhichao.liu" <zhichao.liu@mediatek.com>
> 
> Add spi dma max segment size declaration according to spi
> hardware capability, instead of 64KB by system default
> setting, to improve bus bandwidth for mass data transmission.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: Add dma max segment size declaration
      commit: 309e98548c2b144512d0a212f2d786ae9694f5e4

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
