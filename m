Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A406E50F4
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDQTan (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDQTa2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 15:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564E5BB3
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 12:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8B56207E
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 19:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D683AC433D2;
        Mon, 17 Apr 2023 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759820;
        bh=64Wu29QwU7/+/sn5QKNc4kGBxA6Xy63S8fxNOxeNSU8=;
        h=Subject:From:Date:To:From;
        b=VOUrna1bLAwBcO80Lz+63mUA2La/nBodiz7tmlW0v0oGQROu/2ghaqWziAKxPsxRi
         FVC+GgYdh3uUe6T3TEtw2F9K0Q3e8TkO2HuyE4Y+LiAnk2ueUz/bUuatAeQ3hL9s0Q
         QpLZQJfB7MpLw6pMXP+bp0NqDRowVnAtknLPBowljAv9LKYlyP+g8GjWOaiSJYWb93
         GHow23+y5LM2WTzEcyd4FYElu7SItFR9QHYxqGKtxwml3QPIcula2472xeUm63+QcR
         RmL0D3wDCLtthHCCOZkZAKbAKcb3UWM4YhdJFJyaXkRT6sI4ehGI24SCZpzLFhG6cH
         i+4DV4OJj4ddA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B462BE330A0;
        Mon, 17 Apr 2023 19:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168175982068.402.375873709163214612.git-patchwork-summary@kernel.org>
Date:   Mon, 17 Apr 2023 19:30:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Support AMD Pensando Elba SoC
  Submitter: Brad Larson <blarson@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=738525
  Lore link: https://lore.kernel.org/r/20230410184526.15990-1-blarson@amd.com
    Patches: [v13,01/15] dt-bindings: arm: add AMD Pensando boards
             [v13,04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller
             [v13,10/15] spi: dw: Add support for AMD Pensando Elba SoC


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


