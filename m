Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E385EFB24
	for <lists+linux-spi@lfdr.de>; Thu, 29 Sep 2022 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiI2Qoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Sep 2022 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiI2Qon (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Sep 2022 12:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B51B15A3A
        for <linux-spi@vger.kernel.org>; Thu, 29 Sep 2022 09:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BA661F53
        for <linux-spi@vger.kernel.org>; Thu, 29 Sep 2022 16:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17059C433D7;
        Thu, 29 Sep 2022 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469878;
        bh=2Eek/eVqWp+8NxqMONKuh0X4QSeZvK/WqXOtgRt3O2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iZE+UmwSmO2jxmUlv9/Hxn1OS0f6YCp492be109fs6RRc4prbgSjgvlGk6F1A0fIb
         IhLi0bah3v0qwzwyy8eVu/3JLjFUwb+Vu4Ri18cWKIe9JtQj4PGjiEziJySor3yMQ2
         KP1gQs6IauqNunEpFWapUOjNaWKET/3+NKNod7KIxfzP34AzrKanjcPK4UjOQSsux6
         BC0zWxu8neDD+6GYlcTWs2fjQ+m9lsHi9mq2Kwu0wFTrj7IcdsMnIjoGyfN1oTAJ/Y
         mjE90e1gILLWCQUNU7ZQ3Ctzlk5AgRcA/hHhnLzqQlCQkZTXMkgDD8VeSWFk4tqhc+
         ixmhOIhLftm5A==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     nick.hawkins@hpe.com, verdun@hpe.com
In-Reply-To: <20220928145256.1879256-1-yangyingliang@huawei.com>
References: <20220928145256.1879256-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: spi-gxp: Use devm_platform_ioremap_resource()
Message-Id: <166446987780.210386.3002557586962223080.b4-ty@kernel.org>
Date:   Thu, 29 Sep 2022 17:44:37 +0100
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

On Wed, 28 Sep 2022 22:52:56 +0800, Yang Yingliang wrote:
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-gxp: Use devm_platform_ioremap_resource()
      commit: 28366dd2ecb2c47cfd706a0743dd78f287f1abd7

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
