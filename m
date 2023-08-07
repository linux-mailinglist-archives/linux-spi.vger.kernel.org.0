Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C867731B1
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 23:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHGV5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 17:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHGV5b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 17:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271BBB
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 14:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7177C6228E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 21:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1481C433C7;
        Mon,  7 Aug 2023 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445446;
        bh=91Qe9DV/o6poJXYvQS3ExrlJNoeSKX0wlcd20TXJnXY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C2XPAWiADK8F2ye64oL/ayNwS5ldGc9oNFYNOBTh42/oBpPM67+rKUoLRIbdikTFW
         9JjI94kNEBrXFrFBmPcc/8nTryYnrHiuKfTnkr1RK5Hoxqigb6/ij0wM9rHpejNk+/
         qnCIYkT0nFfnqWqSj3XojMJeE4StNo5qJEg4ipLvzqS5tTiG13lBUc4/othvsby863
         GrTIBCYR2is3A3+jgYkuOFd/GTQOLhVKlCekp5Dc4HgEuQvivQeuQcnvqUs0DHz5i2
         jYXSEtggjBW+gWG5EKXTZTfac2s7xEGAW/Yn499ajZ7erwcUFmQmXxENpthjRtdDMh
         KR54AL+608qfQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 00/21] spi: switch to use modern name
Message-Id: <169144544570.329334.13867891594524371179.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Jul 2023 17:32:00 +0800, Yang Yingliang wrote:
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller.
> 
> Yang Yingliang (21):
>   spi: amd: switch to use modern name
>   spi: aspeed: switch to use modern name
>   spi: spi-axi-spi-engine: switch to use modern name
>   spi: bcm-qspi: switch to use modern name
>   spi: bcm2835: switch to use modern name
>   spi: bcm2835aux: switch to use modern name
>   spi: bcm63xx-hsspi: switch to use modern name
>   spi: bcm63xx: switch to use modern name
>   spi: butterfly: switch to use modern name
>   spi: cadence-quadspi: switch to use modern name
>   spi: cadence-xspi: switch to use modern name
>   spi: cadence: switch to use modern name
>   spi: clps711x: switch to use modern name
>   spi: octeon: switch to use modern name
>   spi: spi-cavium-thunderx: switch to use modern name
>   spi: coldfire-qspi: switch to use modern name
>   spi: davinci: switch to use modern name
>   spi: dln2: switch to use modern name
>   spi: dw: switch to use modern name
>   spi: hisi-kunpeng: switch to use modern name
>   spi: npcm-fiu: switch to use modern name
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/21] spi: amd: switch to use modern name
        commit: e9759d403baaeda9ea4d61d64c3151e214561217
[02/21] spi: aspeed: switch to use modern name
        commit: 21ac58f59125f1c45fdd3791cbc5cc3683514564
[03/21] spi: spi-axi-spi-engine: switch to use modern name
        commit: 9d5920b37ab4a970f658a6a30b54cc6d6a7d2d3d
[04/21] spi: bcm-qspi: switch to use modern name
        commit: ec271c04ae93b8b5ec392f9aa1cb062714157a7b
[05/21] spi: bcm2835: switch to use modern name
        commit: 00be843bc1c3c77574f566ef78b1b7ec1ef92be5
[06/21] spi: bcm2835aux: switch to use modern name
        commit: 901fcd0740df2f907d56709e208325088265c662
[07/21] spi: bcm63xx-hsspi: switch to use modern name
        commit: 2c40be6bc95bd2b9681b4acc434feda05b16eb00
[08/21] spi: bcm63xx: switch to use modern name
        commit: 1a9e76190f72e4e3aaf7eb89da22876846ff9b3d
[09/21] spi: butterfly: switch to use modern name
        commit: 5a59b9a1070da555f44e81d09e3d096694deb1c0
[10/21] spi: cadence-quadspi: switch to use modern name
        commit: 1c75d749b5ebd2352cc72ed33d4fb522c624d974
[11/21] spi: cadence-xspi: switch to use modern name
        commit: ec7cfadff25c1177dadeb1b2fef29f14d530f0df
[12/21] spi: cadence: switch to use modern name
        commit: f75c04a99100b27749bf0d13b96e4fe0cbda6e87
[13/21] spi: clps711x: switch to use modern name
        commit: 1baba77b1f2c6143866463e11749d8dd4c544181
[14/21] spi: octeon: switch to use modern name
        commit: d2a44ae8d2cf9142f5555a2007cb370dc0a2efa5
[15/21] spi: spi-cavium-thunderx: switch to use modern name
        commit: 556aca5be04c83c25ff4e96f53cb82b44cd7f8ff
[16/21] spi: coldfire-qspi: switch to use modern name
        commit: cd9fdf5ae81c01d7d927bb090e25419e9f5165f1
[17/21] spi: davinci: switch to use modern name
        commit: ad5602ba3113b99318a726d6452228b0ce137804
[18/21] spi: dln2: switch to use modern name
        commit: 5ab7a7e37d2fe73465f521155672ccd3b138c35a
[19/21] spi: dw: switch to use modern name
        commit: eefc6c5c2451126c27f4098536d659d07635a1b1
[20/21] spi: hisi-kunpeng: switch to use modern name
        commit: 9f5890466e93a7392c618e50de53cdd3a0dd1fd5
[21/21] spi: npcm-fiu: switch to use modern name
        commit: 1f6c80a74cd4686b5b0b9aed55d7195009c96330

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

