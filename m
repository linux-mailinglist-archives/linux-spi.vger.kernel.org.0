Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7A60B7C5
	for <lists+linux-spi@lfdr.de>; Mon, 24 Oct 2022 21:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiJXTdJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Oct 2022 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiJXTcr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Oct 2022 15:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E92D4A1A
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 11:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7866B81895
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 13:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E96C433C1;
        Mon, 24 Oct 2022 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616876;
        bh=vkZnW0gjSxeSOiEzu/ZRPD5x7ksD6U0yEsC+P2WMStU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hT6ZBVzbR/R3X8agHdaNiqwoEa596+RKXDALu68o0wBkhQKCdrA+3kebCRpGEbgUn
         BEv9MayIq9CcTZEi0zEM3dDKvLTsHbq8+/J6tUFRh2VgEoHOF20HJdvMn3RA3GZ3EH
         NwKqDzxEiJY+XbSg1FN5r3LJgrKRq1v5OUChXuOoJZq1N4gFOcjtFi1oOG8TqHKTWC
         ULp4bIA17lRd1Dr0zpS6PidelG5J5y031eecq0s1xhQ7vgzLksdM0FUWkH+aKqdYRe
         hTOH03ODOhsvNqZTvo0VjbN5yd4dZ1zNg2/P6jvTshmH3YJyvLL89pcXirr5hVKgSk
         ykeJVNIV0wWzg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     clg@kaod.org, chin-ting_kuo@aspeedtech.com
In-Reply-To: <20221019092635.1176622-1-yangyingliang@huawei.com>
References: <20221019092635.1176622-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: aspeed: Use devm_platform_{get_and_}ioremap_resource()
Message-Id: <166661687537.215328.15512815155107512987.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:07:55 +0100
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

On Wed, 19 Oct 2022 17:26:35 +0800, Yang Yingliang wrote:
> Use the devm_platform_{get_and_}ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource() separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Use devm_platform_{get_and_}ioremap_resource()
      commit: 6d0cebbdf29922eaba4648a7a06d0d4ffd00439f

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
