Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15477C338
	for <lists+linux-spi@lfdr.de>; Tue, 15 Aug 2023 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjHNWGi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Aug 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjHNWGd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Aug 2023 18:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF076B0
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 15:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 452876134E
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 22:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA55C433C9;
        Mon, 14 Aug 2023 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692050791;
        bh=9hyrtAHZ0Ep8woeBdWaNATNsBwrnmmmQsOmobZ6mF/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fyKT/tVtlOfXc7AspkgmOZBOj7TYyMd4Wq5DcjGWSMuc6OnTGFyGR0772tqiWT9Nl
         yCb4hIj68y7+cUcDkQRsfHtn2W89o9FSy8xEWHhLgSa6/jwDA3dE1owH5sO43EuQqG
         HCISiJW2g+kr0hjc4fmPOk+tYziudArv48uq2uvviGRpTyOofxksenC9Dl+4peMmmM
         DvwL7eyU7yFPCfAn2ocaUlN7hcPc7QEeUHk5rpOnSYsVqoFNAz5oJpTbNRPq639VBm
         UM98I9T9mJtbtn1X3GRP3180k3K9aeflTaAxl9QnJHl41haYzFvliUyvH56KVKz9IS
         wZ2Efuw6qPD0w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 00/20] spi: switch to use modern name (part2)
Message-Id: <169205079055.99213.14947262792177199106.b4-ty@kernel.org>
Date:   Mon, 14 Aug 2023 23:06:30 +0100
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

On Mon, 07 Aug 2023 20:40:45 +0800, Yang Yingliang wrote:
> I'm trying to rename the legacy name to modern name used in SPI drivers,
> this is part2 patchset.
> 
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller. All compile test passed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/20] spi: amlogic-spifc-a1: switch to use devm_spi_alloc_host()
        commit: 40f78b74b6d425115d1df78516d14c35384172e7
[02/20] spi: au1550: switch to use modern name
        commit: 0c35cc597b211eea2f26eae35904204cbd8e0e94
[03/20] spi: ep93xx: switch to use modern name
        commit: 24e9b75c0cc3b465cb8f355b2e1b239a54625ae3
[04/20] spi: falcon: switch to use modern name
        commit: 45d9591105a63fa80d69552ebbd5073c3b16d6bd
[05/20] spi: fsi: switch to use spi_alloc_host()
        commit: d40f10d009d405a82b533633c126be7fcc88b4ce
[06/20] spi: fsl-dspi: switch to use modern name
        commit: 6230d6cad1a70d78f3fe3a0cda2beb1e478c4a40
[07/20] spi: fsl-espi: switch to use modern name
        commit: a87935899f9c51fc6272c13339fbfd2ccec37d21
[08/20] spi: fsl-lpspi: switch to use modern name
        commit: 2e2af40b57ad4464eb6c3bffa1fd500551a32c4a
[09/20] spi: fsl-qspi: switch to use modern name
        commit: ec6a79529670bf6bea02ff134d881e165cd085ab
[10/20] spi: fsl-spi: switch to use modern name
        commit: d32382ca5614614df0cbb91a1b7fab9c47bfef9b
[11/20] spi: gpio: switch to use modern name
        commit: 20becf43e8ca3a9ff00ed24e19695347e0a2f0e7
[12/20] spi: gxp: switch to use modern name
        commit: 6588d43ae8e3046996b315cc6dcb2a7e0c2bb547
[13/20] spi: bcmbca-hsspi: switch to use modern name
        commit: 3dc6e684b4f3854a867b5745db868d6f60466f7b
[14/20] spi: hisi-sfc-v3xx: switch to use modern name
        commit: f64e6ee3725ec41049a2c724b624e19f87192c7d
[15/20] spi: img-spfi: switch to use modern name
        commit: d6e19216e8167adbd6c44f5e0f8aa127267a8b24
[16/20] spi: imx: switch to use modern name
        commit: 756d5bf0770662ebf14f0eb274d862be5cf3e044
[17/20] spi: ingenic: switch to use devm_spi_alloc_host()
        commit: 452edead18d7ba14b018f85f9eda0922a23e7412
[18/20] spi: intel: switch to use modern name
        commit: 5fa0ade1851f7766e75ebb453ef8d6de089318d4
[19/20] spi: jcore: switch to use modern name
        commit: 810ee62dd81d05c2305132804c021c2ac406b2b5
[20/20] spi: lantiq: switch to use modern name
        commit: ea11a8bb79d6c2655d145ec003deb77ab03dcb71

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

