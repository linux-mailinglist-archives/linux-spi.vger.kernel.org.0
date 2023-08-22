Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19FC7847BE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbjHVQeJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbjHVQeI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57133CE8
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76DB65CC9
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 16:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67924C433C7;
        Tue, 22 Aug 2023 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722032;
        bh=N1nQWqd2q191FUD9ApaJU7zCcZlSSferga76H3/31CQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YVzKZmiFrVh44dZM0GLIMvdJCShv/nOR8AWetiNuC4ayUJFtlEUUrNVZUH2Zwuwnu
         aJz7fMuY8qs6EnYgAzy981No1+oxBP3/TP4OkfA7q9+T5esIOI1Vk1E6C/8Kc2LAsd
         rDA/ysWw/FoYQx0VujGlZSxYm421QlSEjlGZYsmRSgTJCfiO1PWrNsg+MfMCjDf9Z8
         gbtcbZcp31RxlLiHpLgzt0Qbc93HEoOqE34OSxuRAEU/jijIccK3QI3zdRmrklojJm
         DMSFSavbBKDSDmWqPoMA2Lmw8tKzhc2183XKuiSOmXqTJtUaHIYhub/GZeJB531N0r
         E0F6+bQrdXHqA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next v3 00/23] spi: switch to use modern name (part4)
Message-Id: <169272203114.71899.15565176901576158538.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 18 Aug 2023 17:31:31 +0800, Yang Yingliang wrote:
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

[01/23] spi: orion: switch to use modern name
        commit: 08e6c5038fee470d9f240c12dcf69927e204a56b
[02/23] spi: mchp-pci1xxxx: switch to use modern name
        commit: f9977bb164a26d3bec31cdaf04865accf97e4353
[03/23] spi: pic32-sqi: switch to use modern name
        commit: cc64ab491b4236cbeb8aabf2cd41db4499a0745b
[04/23] spi: pic32: switch to use modern name
        commit: 0273727c3bae812e12d9bc32830af9d7b3767d3b
[05/23] spi: spl022: switch to use modern name
        commit: c97a43a54600fd977acf654802ccf3c94f5f592a
[06/23] spi: ppc4xx: switch to use modern name
        commit: 71345830575984c01c4c2b655ef3a7877100fba3
[07/23] spi: pxa2xx: switch to use modern name
        commit: 60ba4431c8e8c137f92d050b9f0bfc8e8c26a364
[08/23] spi: spi-qcom-qspi: switch to use modern name
        commit: 8d3ad99ad8f7370a0f9c8bdb741747fdd70e4e49
[09/23] spi: qup: switch to use modern name
        commit: 597442ff4f6226206b7cc28b86eb2be0ae9c6418
[10/23] spi: rb4xx: switch to use modern name
        commit: e6302d00d985d49f891d4b007afdae824d873edf
[11/23] spi: realtek-rtl: switch to use devm_spi_alloc_host()
        commit: c84036243c6bc0e1b5846e379f5d4b3e4658688e
[12/23] spi: rockchip-sfc: switch to use modern name
        commit: 7d5db7251997da069ca22c837a53ca8a84b4036e
[13/23] spi: rockchip: switch to use modern name
        commit: 1a3ccff3bc39acc04e69e3a65833d474471598ec
[14/23] spi: rspi: switch to use spi_alloc_host()
        commit: 1405efe76f2a242832a53b56deda15f17d51219b
[15/23] spi: rzv2m-csi: switch to use devm_spi_alloc_host()
        commit: 6536da62e4378caafa309ae372ca88f065f3e47c
[16/23] spi: s3c64xx: switch to use modern name
        commit: f4bc49eda254c6f49c6679149d31e93271d6ee74
[17/23] spi: sc18is602: switch to use modern name
        commit: 82a779231805c388e09921f4a28d9daebf95aeda
[18/23] spi: sh-hspi: switch to use modern name
        commit: 0c8e5afc879f5b693dd2db68a7db3ffb3dc6823b
[19/23] spi: sh-msiof: switch to use modern name
        commit: 1cb3ebc417fe6cc5bea1b37682c0e860ea9ffb2d
[20/23] spi: sh-sci: switch to use modern name
        commit: 91a940bb1075337184c3aa537c6e5b9429380400
[21/23] spi: sh: switch to use modern name
        commit: 0ec6a15091a17dc5af7a4b23a2d02e554cbe3549
[22/23] spi: sifive: switch to use modern name
        commit: 8d9ae783fb706ae98db18d050201d96a9634bd45
[23/23] spi: spi-sn-f-ospi: switch to use modern name
        commit: 557efcf4c64f27f1b69af464246bf90b4d52e5be

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

