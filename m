Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C118177E62D
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjHPQRR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbjHPQQt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 12:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6D2D4B
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 09:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1327565C00
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 16:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988C5C433C8;
        Wed, 16 Aug 2023 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202598;
        bh=nMMWreXvfClcXryoB7nXAOJkosGostBWCUNcWgOFCC0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VJr1mgFX7aQpYraDRL2QXLCD9Abhr5szoxoOsgPLm0w5k6P8YgQ8K8fqWAWXlFplp
         Gud3z4TOWIlQNAbmNQ+NX/dWnvS8H5zzL+ZrakqbHgJ9KeejqggV6SWaWkuWKKKoMc
         Q5MyoKSF/NeokXhFVaJILBZ3ohOJ6e50UgawUbzsjbCN5P6uRMJqqt+DoayPzpASkq
         fb6vMP/JDkMKpJiAaKb3ONxZVXDBqA9jD1CTa4AN5zKYbjeUILnN08YdGh2rxNESve
         cX2cczc+7ZCXed0hlErB0xPEnVMJME1P2Me0aiSUSIeTcuqmdC5eLRyGaSCt6AxONU
         fb/FlByyuJisA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
Subject: Re: (subset) [PATCH -next 00/24] spi: switch to use modern name
 (part4)
Message-Id: <169220259734.817565.5650906107283035207.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 17:16:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Aug 2023 17:39:49 +0800, Yang Yingliang wrote:
> I'm trying to rename the legacy name to modern name used in SPI drivers,
> this is part4 patchset.
> 
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller. Each patch compile test passed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[14/24] spi: rpc-if: switch to use devm_spi_alloc_host()
        commit: 46f53bde6e69edf8a2e0943babb3f160b30ee436

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

