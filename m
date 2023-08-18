Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DD78158E
	for <lists+linux-spi@lfdr.de>; Sat, 19 Aug 2023 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjHRWux (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbjHRWu1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 18:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF8D4229
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 15:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21BDC60DBB
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 22:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ECDFC433C7;
        Fri, 18 Aug 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692399025;
        bh=V2PFD5Ss+KArk463noyg9BVh4glFMvWPZzJNG4SBG5Y=;
        h=Subject:From:Date:To:From;
        b=rf/KHBENiAdIBsD0TBNwlFMzkU3ezT4ycoIafJbjvpjs4rnW5KzyyqcpLp0GQy3kP
         TWwF5MbGdKdHoW2ntV+dj1GYPa4dPa8nq+1OiCCSv/9iMqamcfqoaydtysqMIdTsM4
         jXPaMbOWC11JZbYyyIlVZ6NAA/voIFkB22i/65rC+YLqbs0EIi4nbY5Kp3+1PRb+oM
         xIhpG5ZI9U8+XrhSAL331PThULCGtctVhuFMc5tkxgCyQl686VtLNMT1ws74IY3Pgs
         //rOcGB2HsoL5yKgPjcDRahoNil8xIBhtLFegV48SZCEA5INOYKo+ViIX34N+Bk3NM
         Nl2TPxAfljMCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D782C395DC;
        Fri, 18 Aug 2023 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169239902524.7227.284831067363192715.git-patchwork-summary@kernel.org>
Date:   Fri, 18 Aug 2023 22:50:25 +0000
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

Series: Add cs42l43 PC focused SoundWire CODEC
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773051
  Lore link: https://lore.kernel.org/r/20230804104602.395892-1-ckeepax@opensource.cirrus.com
    Patches: [v7,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
             [v7,2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
             [v7,3/6] mfd: cs42l43: Add support for cs42l43 core driver
             [v7,4/6] pinctrl: cs42l43: Add support for the cs42l43
             [v7,5/6] spi: cs42l43: Add SPI controller support


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


