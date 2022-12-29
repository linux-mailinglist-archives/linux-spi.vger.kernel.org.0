Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995F65912F
	for <lists+linux-spi@lfdr.de>; Thu, 29 Dec 2022 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiL2TYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Dec 2022 14:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiL2TYS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Dec 2022 14:24:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D961572B
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 11:24:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F446179E
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 19:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251DAC433EF;
        Thu, 29 Dec 2022 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672341856;
        bh=AvW+taSHtH36sZaHlh4Qqtid//S51ZSMfiFXH/iIrxM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SZZJxiDZHn85wmbZA2hs5Gp2iW1O/pllEB128PekHtrC28luQZ7oIYrMmbjvX3wHH
         HgraQk6Um7kzpXsl1JKHGm1ENetaEV6ztsrjOOPZdQoHwi6PPrquRipKBMVrfDz/Iv
         80P5qVr+Uodai5vOACzKnPUZS2ewPCiTleIW2ZT18Z+taORkLLMgWpdMVtNPrHg3jh
         9BURSkzcbVnm7QRvVWqnres30jD4LlQoTZ80eklbKRT8Bxi4ouWbSmIGUIyiyIH2Zb
         R7rQ3cECzKcV4gbEg1uS2J8K6hd3EPIGkjLlKBgwUqHm8muItl6ZKPcxnHrNviH/bb
         G68UKZoQph8mQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20221229103837.4192759-1-yangyingliang@huawei.com>
References: <20221229103837.4192759-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 0/3] spi: altera: switch to use modern name
Message-Id: <167234185489.15056.2288710738504265066.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 19:24:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 29 Dec 2022 18:38:34 +0800, Yang Yingliang wrote:
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller.
> 
> Yang Yingliang (3):
>   spi: altera: switch to use modern name
>   spi: spi-altera-dfl: switch to use modern name
>   spi: spi-altera-platform: switch to use modern name
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/3] spi: altera: switch to use modern name
      commit: 26c48aea147cbf3dcec1df67d0684457ddf00fea
[2/3] spi: spi-altera-dfl: switch to use modern name
      commit: ec168190c1cace92cba22ffa2048e79f41ba5a13
[3/3] spi: spi-altera-platform: switch to use modern name
      commit: 02c9e5b768b26239be7459438275f8fc835e9dc4

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
