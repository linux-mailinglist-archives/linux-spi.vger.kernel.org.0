Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C37AE93F
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjIZJad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIZJad (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 05:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06199127
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 02:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FE5AC433C8;
        Tue, 26 Sep 2023 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720625;
        bh=YbFk68D9I/m7qq7i+B12P9rdR0Ft/jrlIzp67djrC/0=;
        h=Subject:From:Date:To:From;
        b=hLF/lvd0NEudM/H5+a6N8N3sKrA+uej/Q490MdrmA5hliSQ5yzgSHuWGzLCoJf6HK
         vYMlbIzosZ7/zElR3w+fGPXYvMLr2P3EejuU3s51l8sUKynoG7m68VPfzJUTu8AR2x
         9bBN/jd3rUVCedJVZGcF4sluNmAN/UJW80XJH3m6hIzaCBgHdwbULAqPCCutzJ4V3w
         DwfUPSTQYkr9jHwE/w+RLL/f4n4i2sUyS+uOYbbBRTooK0r7Dsz4XbUB8nn6fT/7oS
         4cy8a3wlpbJM2WezaSYymLuzBw4kDJyhYEdu+De66z4wyvpOyBliZY5GW7nvmnAucP
         JQqioWs3oP8ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A5D1C6445B;
        Tue, 26 Sep 2023 09:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169572062543.18532.12840479308338809951.git-patchwork-summary@kernel.org>
Date:   Tue, 26 Sep 2023 09:30:25 +0000
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

Series: spi: qup: Allow scaling power domains and interconnect
  Submitter: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=785589
  Lore link: https://lore.kernel.org/r/20230919-spi-qup-dvfs-v2-0-1bac2e9ab8db@kernkonzept.com
    Patches: [v2,1/4] spi: dt-bindings: qup: Document power-domains and OPP
             [v2,2/4] spi: qup: Parse OPP table for DVFS support
             [v2,3/4] spi: dt-bindings: qup: Document interconnects
             [v2,4/4] spi: qup: Vote for interconnect bandwidth to DRAM

Patch: spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to spi-peripheral-props.yaml
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=784307
  Lore link: https://lore.kernel.org/r/20230914190049.1853136-1-robh@kernel.org

Patch: spi: at91-usart: Remove some dead code
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=784993
  Lore link: https://lore.kernel.org/r/84eb08daf85d203b34af9d8d08abf86804211413.1694961365.git.christophe.jaillet@wanadoo.fr


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


