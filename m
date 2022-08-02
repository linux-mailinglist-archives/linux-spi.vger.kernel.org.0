Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302A5587879
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiHBH4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiHBH4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 03:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7543AE70
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 00:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED4B6145B
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 07:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 490DFC4347C;
        Tue,  2 Aug 2022 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659426991;
        bh=HyO1DoW5aXxdMmvDqI3JM0TA1sD266R1C/2QklBQGwE=;
        h=Subject:From:Date:To:From;
        b=K8XAdjkqt4BHaV6ZXGNjELh9zMgRB/z+134VYTk+Op+iRM/7Hy9vYH7V0ByT1jik9
         yC1YSnW8nSgoAwpekid9YTtSoDQij+Lm47Xa9GhAndu5YF/crd9CJ6XgJSn7RdMeeA
         FISikHEeLy0jJz4dJTqJLGHL6M1bMorIvpMQWaGCZX8+fCPPbV5i9TTGP29yr972g9
         yTpXaE63wFei/H19SCYnhrHCDqp0MSIK6cvTWEpowzdkEIYjwaTznW+OpliEZf5Mu7
         1cwh2ezBC1a+5QoEMR74RjAkfFNBRM0fAs6n7L+s6X3LQqn9Jt3NsWfxoXicePrp33
         n/hW9CiOTvcBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 225B6C43142;
        Tue,  2 Aug 2022 07:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165942699107.4515.13882879856945172405.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 02 Aug 2022 07:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add support for Microchip QSPI controller (2022-08-02T07:05:15)
  Superseding: [v1] Add support for Microchip QSPI controller (2022-08-01T09:42:53):
    [1/2] spi: dt-binding: add Microchip CoreQSPI compatible
    [2/2] spi: microchip-core-qspi: Add support for microchip fpga qspi controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

