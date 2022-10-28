Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2261177F
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJ1Q1m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJ1Q1l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 12:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E181EEA12
        for <linux-spi@vger.kernel.org>; Fri, 28 Oct 2022 09:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57AD462656
        for <linux-spi@vger.kernel.org>; Fri, 28 Oct 2022 16:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1D0C433D6;
        Fri, 28 Oct 2022 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666974459;
        bh=twtmoKPq09PbQoRZPU2dQafVAjEGTFkcc2yTjdofB0A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OObKZjGFYdiSk3Dk316sZhcAhj161koDjHXqQGhakRJ1BgAHzWoxzgd5vqpVqEX10
         1APIIFyG6vb0dBEUyyR2/89e7DCrDxGISnQtax0EtPklwGcjNmOZB5McYhWz+dIA29
         /QnbY5o2TxQIB6CthwmbHle5s/lEuFTymBaYGjqbAOygGcKV6Kb/TVHOEo473Kys0V
         8BU0xQoTyuko6ZAppc9qsKBqSlLhDaDII9XQQfoGV6liyMgs6OGg3Fh7wtBTVAG0+M
         9VWFn4dh1R5suiUzygi1gO0jy01sR9IQQCCcOeoNvkkvo5mQlHlT8I6she7dZZfWtz
         3cntjuqg7gj2w==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     john.garry@huawei.com, huangdaode@huawei.com,
        linux-spi@vger.kernel.org, prime.zeng@hisilicon.com
In-Reply-To: <20221028023739.4113998-1-f.fangjian@huawei.com>
References: <20221028023739.4113998-1-f.fangjian@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon SFC Driver maintainer
Message-Id: <166697445843.776721.8265091254057596716.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 17:27:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Oct 2022 10:37:39 +0800, Jay Fang wrote:
> Add Jay Fang as the maintainer of the HiSilicon SFC Driver, replacing
> John Garry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Update HiSilicon SFC Driver maintainer
      commit: c1de355e04e6ae8da21cb6bfbd5bbfd8deee0fe5

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
