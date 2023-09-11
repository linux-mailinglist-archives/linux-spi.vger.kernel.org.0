Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6CB79B564
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 02:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350679AbjIKVkl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Sep 2023 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbjIKPuM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Sep 2023 11:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C0121
        for <linux-spi@vger.kernel.org>; Mon, 11 Sep 2023 08:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 460B2C433C7;
        Mon, 11 Sep 2023 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694447408;
        bh=gQ+XhIGHOiveHnUdSUeKvucVC/os/lzHbFA6ye+KwtA=;
        h=Subject:From:Date:To:From;
        b=XqJSSWg51oGk5l633gYSpU6pM+ler50LXzCsYXuYVHfeenhwTqz4BT+udovjbqLBc
         4rxcsjS6bBDcFNdJry8Y1nw7KTOBRReFgbaoXYwG8fXzV53ayF8TXK2IbW804I0/wM
         +1ii2gN4tyTDrEaNCTy0gVd5bLIKZObJwtiGJ7z8EZjLwGADIedr7CXjZrRt8HA5ZG
         ug7dGFSdFgSMJCbK1WQio0oWUxF+v4H41NqYi5qVTSAB2W2pmbxKxZ3hjAqWHxkcQM
         UtIxD+kE/SKHA+lKPFYFuVv/Am+3jdN70naaodAaJI3c9YwW7/tbqHVsET8fas06KD
         5KaCRt89eJavw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2651EC64459;
        Mon, 11 Sep 2023 15:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169444740805.23759.13258564965283409782.git-patchwork-summary@kernel.org>
Date:   Mon, 11 Sep 2023 15:50:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add interconnects to QUPs on SM8250
  Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
  Committer: Georgi Djakov <djakov@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762155
  Lore link: https://lore.kernel.org/r/20230703-topic-8250_qup_icc-v2-0-9ba0a9460be2@linaro.org
    Patches: [v2,1/4] dt-bindings: interconnect: qcom,rpmh: Add SM8250 QUP virt
             [v2,2/4] dt-bindings: interconnect: qcom,sm8250: Add QUP virt
             [v2,3/4] interconnect: qcom: sm8250: Fix QUP0 nodes

Series: Add support for sam9x7 SoC family
  Submitter: Varshini Rajendran <varshini.rajendran@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759897
  Lore link: https://lore.kernel.org/r/20230623203056.689705-1-varshini.rajendran@microchip.com
    Patches: [v2,01/45] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x60, sam9x7 compatible
             [v2,02/45] dt-bindings: usb: ehci: Add atmel at91sam9g45-ehci compatible

Series: Add cs42l43 PC focused SoundWire CODEC
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773051
  Lore link: https://lore.kernel.org/r/20230804104602.395892-1-ckeepax@opensource.cirrus.com
    Patches: [v7,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
             [v7,6/6] ASoC: cs42l43: Add support for the cs42l43

Series: [v2,1/3] dt-bindings: media: amphion: Fix subnode pattern
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mauro Carvalho Chehab <mchehab@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=768879
  Lore link: https://lore.kernel.org/r/20230724122101.2903318-1-alexander.stein@ew.tq-group.com
    Patches: [v2,1/3] dt-bindings: media: amphion: Fix subnode pattern


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


