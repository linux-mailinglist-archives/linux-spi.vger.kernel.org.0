Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB55742582
	for <lists+linux-spi@lfdr.de>; Thu, 29 Jun 2023 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjF2MPI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jun 2023 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjF2MOj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jun 2023 08:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC33A89;
        Thu, 29 Jun 2023 05:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A846861539;
        Thu, 29 Jun 2023 12:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BFFC433C0;
        Thu, 29 Jun 2023 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688040877;
        bh=bizqfKgWHTLB7pw+cRgkPxhEcDkKM0MxFZ+MJ5n8MhM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GUIzA5ng19pusWeRo30LUJswTd3du8qtVgs5R4y0Z4nKb2BmywilpHfOjPIgcoTLA
         TF3AiUg8HCXcRxCR20ErAzjTEJfpbU5o9sfjaCALkdJTgDUsvMs2ShjVqgV+oJl5E7
         vBTmf2VgLthyDD/WOQEVuiS8jpEtzTbMUwd1mLZRw2Ws99qZyVM7OQGGelDlTPMnIE
         oHirjJdFpvYz21BXCxanSlWHC7E4NhsWUk20p3zLNyph5/H8tgOl9EbBC2y/4Dz6iR
         yFM2rFIUBXVtN7gWQVsNTo6dDFZQwaKhBOOHokl4sjhJCgVYHAqmnhC3+jhKosDh0K
         18iG6zfZoOyPw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20230629095847.3648597-1-dmitry.baryshkov@linaro.org>
References: <20230629095847.3648597-1-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for
 GPI DMA mode
Message-Id: <168804087532.50260.12035266321493926896.b4-ty@kernel.org>
Date:   Thu, 29 Jun 2023 13:14:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 29 Jun 2023 12:58:47 +0300, Dmitry Baryshkov wrote:
> The GPI DMA mode requires for TX DMA to be prepared. Force SPI core to
> provide TX buffer even if the caller didn't provide one by setting the
> SPI_CONTROLLER_MUST_TX flag.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000815b82000
> [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : gpi_prep_slave_sg+0x3a4/0x5a8
> lr : gpi_prep_slave_sg+0xcc/0x5a8
> sp : ffff80000a2c3930
> x29: ffff80000a2c3930 x28: ffff80000a2c3c58 x27: ffff4e744d8307f0
> x26: 0000000000000001 x25: ffff4e7440f55810 x24: 0000000000000000
> x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000003
> x20: ffff4e7440c1f800 x19: ffff4e744d1f8618 x18: ffffd8ac41787e68
> x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000100
> x14: ffff4e744d608000 x13: 0000000800000002 x12: 0000000600000004
> x11: 0000000000000000 x10: fffffffffff9f980 x9 : 0000000000000000
> x8 : ffff4e7440c1fa00 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 00000000ffffffff x4 : 0000000000000900 x3 : 0000000000000200
> x2 : 0000000100000000 x1 : ffff4e7451f73400 x0 : ffff4e744d1f8610
> Call trace:
>  gpi_prep_slave_sg+0x3a4/0x5a8
>  spi_geni_transfer_one+0x190/0x558
>  spi_transfer_one_message+0x424/0x800
>  __spi_pump_transfer_message+0x248/0x670
>  __spi_sync+0x2cc/0x3a8
>  spi_sync+0x3c/0x68
>  spidev_sync_read+0xb0/0x108
>  spidev_read+0x54/0x110
>  vfs_read+0xc8/0x270
>  ksys_read+0xec/0x110
>  __arm64_sys_read+0x24/0x38
>  invoke_syscall+0x50/0x128
>  el0_svc_common.constprop.0+0xd4/0x100
>  do_el0_svc+0x40/0xa8
>  el0_svc+0x34/0x108
>  el0t_64_sync_handler+0xf4/0x120
>  el0t_64_sync+0x190/0x198
> Code: 94079d2b 17ffff94 a90573fb f940a660 (f9400b06)
> ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
      commit: d10005837be83906bbd2078c3b4f9dfcbd6c95b6

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

