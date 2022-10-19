Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85E8604CBA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiJSQGY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Oct 2022 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJSQFt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Oct 2022 12:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935AA60C98
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 09:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E6E61939
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 16:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB1C433C1;
        Wed, 19 Oct 2022 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666195441;
        bh=Cf/43Kqk72RkMdZ9HuA4YPi5nlt4RV+jBXg6QIQs9Mk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=fGKGQ6HfOGM3HmKMtQAkdKdoUceZSb0zCzmS1JwZrpqoEXnRc61wpHQERlcvdPEy3
         ytMmDqvULI8698q/IuetH/OLt6FCybdKR55RqZ4uN+mU/cFkJnFiGnR2O3Ol+rRGqO
         3DH8Gce3r6tsjJu2eqWHH/bECy4Vrt8GDgcwxVbXv1aZLlpN1nVxeuCvV/JjgyVMba
         8L1gKQHd6iTXbDmft+LjezpFhCb7GIkFYml9J77n6+5tFfKMgTWSY0hA+qjGO7UY0B
         cbJLaXQET+KbJj08BFt0+waSiES1FGuqSxqWz0YJ5VzPMGSopxvzr75M4lY3C6boJy
         MqLl3cCav6FCQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
In-Reply-To: <20221019093318.1183190-1-yangyingliang@huawei.com>
References: <20221019093318.1183190-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: img-spfi: Use devm_platform_get_and_ioremap_resource()
Message-Id: <166619544045.915751.4519532293442067641.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 17:04:00 +0100
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

On Wed, 19 Oct 2022 17:33:18 +0800, Yang Yingliang wrote:
> Use the devm_platform_get_and_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: img-spfi: Use devm_platform_get_and_ioremap_resource()
      commit: a977c3a93fa9ed75fcd77b770c7e557d7b4f7bab

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
