Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B01690F0D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Feb 2023 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBIRUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Feb 2023 12:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjBIRUU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Feb 2023 12:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FEC66EC7
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 09:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E229E61B57
        for <linux-spi@vger.kernel.org>; Thu,  9 Feb 2023 17:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 509ABC433EF;
        Thu,  9 Feb 2023 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675963218;
        bh=oL4OpfUk0U1wgkMDKYYbdX+BK+c5m05D3ICQw6FZTA4=;
        h=Subject:From:Date:To:From;
        b=k8TCROxgdGfT9UZHZu/6CEireXn9Ky9efm1wzXZ4VvcNEKn1XyAIzWVsybaRKJBhT
         wDS3vJpYv3iFbE8fH9ZkS8z7ULwOZnxmv0Q8lvzhyuVXpDUDA3lLU5dWYHqAWDV1yx
         SPpjxwXOzlF1AX55IceiXiFzfzz38jMZLkREHY0+nxDrKGNXNknhHtuNutwmvfdmu7
         JXPNyCX7NIjsitsUeiky474SGs5ved+1Iz503VmtXWsFNwozC33W5HLwTSR4G1aFbP
         +dYrZxGoyOdVbcI9kgb57Dz8hyQ0Wz+Q+5gg+z3cqBNs7OVowWgw1zSDCY6rGQQgll
         rJ0Y3C1UY0zPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B328E21EC9;
        Thu,  9 Feb 2023 17:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167596321810.15921.7003133998763636694.git-patchwork-summary@kernel.org>
Date:   Thu, 09 Feb 2023 17:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: bcm63xx-hsspi: driver and doc updates
  Submitter: William Zhang <william.zhang@broadcom.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=719372
  Lore link: https://lore.kernel.org/r/20230207065826.285013-1-william.zhang@broadcom.com
    Patches: [v3,01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
             [v3,05/15] spi: bcm63xx-hsspi: Add new compatible string support
             [v3,06/15] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
             [v3,07/15] spi: bcm63xx-hsspi: Add polling mode support


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


