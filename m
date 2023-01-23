Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70A678362
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 18:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjAWRgS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 12:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjAWRgH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 12:36:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4830191
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 09:35:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85E7AB80E1A
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 17:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EBC4339B;
        Mon, 23 Jan 2023 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674495325;
        bh=if5ERRmjKg/QTuuC/d1VDiUmFQSQRowr8ntQTS0LU18=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OMAA/aD+ZM7x4dte/a7Rc3sMNn1+D20Jci1L6xWingjzjdT8zEitYHpEUVxkU3rPC
         OeYLDCVPeqs1VQ4alb7DCVnzTc3oGU9gOV4an6Si5IuLAUeTG6Hw8gl4vw+AqEkTMC
         aGHTGiX/0sDCdtUYnSYPfYAlHKJTI/Td6FmHZ77ux7nybi4QpjVRnoeWyA0sN51aKP
         E08yUcZacGaqF7ZRFUqI46ueOckftnSCrLFgTl/O6VSa2e5+62xzIKxcgl2W2olBIW
         mfDSIUoP16D7nskzfyOXFWU7HCwZN9Zl/VAqtHxZ/ck0Ql2YlhGyBGMU/jx7m4U4M+
         lXUnOxi2hA13w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230110131805.2827248-1-yangyingliang@huawei.com>
References: <20230110131805.2827248-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 0/3] spi: atmel: switch to use modern name
Message-Id: <167449532355.1496106.6234871055126124286.b4-ty@kernel.org>
Date:   Mon, 23 Jan 2023 17:35:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Jan 2023 21:18:02 +0800, Yang Yingliang wrote:
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller.
> 
> Yang Yingliang (3):
>   spi: atmel: switch to use modern name
>   spi: at91-usart: switch to use modern name
>   spi: atmel-quadspi: switch to use modern name
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/3] spi: atmel: switch to use modern name
      commit: b94a26d95cb2790ab62d4c27a6383eeb3d2ddab0
[2/3] spi: at91-usart: switch to use modern name
      commit: 747d4e2c5f0e0469ad6055849f99516ca4b03e82
[3/3] spi: atmel-quadspi: switch to use modern name
      commit: ccbc6554ed66dc37778b8ed823bcaaabfb1731cf

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

