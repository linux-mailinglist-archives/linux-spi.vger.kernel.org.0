Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53E7847E3
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjHVQmC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjHVQmB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4071B0
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98229623D7
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 16:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BF44C433C8;
        Tue, 22 Aug 2023 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722518;
        bh=D5C0MGJ8DGBBGXMZXnkT7mxdxFwt0qqVMWCW/2YmGlA=;
        h=Subject:From:Date:To:From;
        b=jyj0ydWFnMJ/hk96ioIl3q7mJyjQ4L2sc1aXTfuXre0IFeI8z2/GPid3ZYaAqemhR
         zSp8h5ujbUvWSxcfn0lT499ikICDzPmbyPoWgDHV5Ewu3g4HAc9An3+QcJ4Sn697/h
         BvlJHXBuM2juUUvdDjJbhjyDAkG8ev1iNDtIt3yi9hgZYyLh8b1mSGBzKru6jdIQe9
         OPlhrQifCdVPhqp+dmQco3fBKcMnmlQoUc+IpYSznO8Ohi9g8UVNwWp3vw0+hfzd6V
         Ga3u7Kf5j4QS2uEHmx9joRrMZuIFB0Ybr+L/9c5DHlF77/KXrl6QXQRghGFK+BIdyv
         eQNnrp/5JqdYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D789AE4EAF6;
        Tue, 22 Aug 2023 16:41:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169272251779.28543.6690840950391987272.git-patchwork-summary@kernel.org>
Date:   Tue, 22 Aug 2023 16:41:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to use modern name (part4)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=777345
  Lore link: https://lore.kernel.org/r/20230818093154.1183529-1-yangyingliang@huawei.com
    Patches: [-next,v3,01/23] spi: orion: switch to use modern name
             [-next,v3,02/23] spi: mchp-pci1xxxx: switch to use modern name
             [-next,v3,03/23] spi: pic32-sqi: switch to use modern name
             [-next,v3,04/23] spi: pic32: switch to use modern name
             [-next,v3,05/23] spi: spl022: switch to use modern name
             [-next,v3,06/23] spi: ppc4xx: switch to use modern name
             [-next,v3,07/23] spi: pxa2xx: switch to use modern name
             [-next,v3,08/23] spi: spi-qcom-qspi: switch to use modern name
             [-next,v3,09/23] spi: qup: switch to use modern name
             [-next,v3,10/23] spi: rb4xx: switch to use modern name
             [-next,v3,11/23] spi: realtek-rtl: switch to use devm_spi_alloc_host()
             [-next,v3,12/23] spi: rockchip-sfc: switch to use modern name
             [-next,v3,13/23] spi: rockchip: switch to use modern name
             [-next,v3,14/23] spi: rspi: switch to use spi_alloc_host()
             [-next,v3,15/23] spi: rzv2m-csi: switch to use devm_spi_alloc_host()
             [-next,v3,16/23] spi: s3c64xx: switch to use modern name
             [-next,v3,17/23] spi: sc18is602: switch to use modern name
             [-next,v3,18/23] spi: sh-hspi: switch to use modern name
             [-next,v3,19/23] spi: sh-msiof: switch to use modern name
             [-next,v3,20/23] spi: sh-sci: switch to use modern name
             [-next,v3,21/23] spi: sh: switch to use modern name
             [-next,v3,22/23] spi: sifive: switch to use modern name
             [-next,v3,23/23] spi: spi-sn-f-ospi: switch to use modern name

Patch: [-next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify code
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=778212
  Lore link: https://lore.kernel.org/r/20230822124643.987079-1-ruanjinjie@huawei.com

Patch: spi: bcm-qspi: Simplify logic by using devm_platform_ioremap_resource_byname()
  Submitter: Zhang Zekun <zhangzekun11@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=774982
  Lore link: https://lore.kernel.org/r/20230810131650.71916-1-zhangzekun11@huawei.com


Total patches: 25

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


