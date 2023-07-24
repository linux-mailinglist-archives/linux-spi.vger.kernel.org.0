Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B775FF11
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGXSae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGXSa1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29537A6
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 11:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF53161383
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4241C43397;
        Mon, 24 Jul 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223424;
        bh=1xLOQEDGpGoGa3XybjKIAhhhS1PRBwrhFyo8uE/iPW8=;
        h=Subject:From:Date:To:From;
        b=nX/UmnjWVjfPGjwz9xDsqIn9sb8GMPsFMre3h5pFrRc7LS2GnVy6IfI56yrepY8Zm
         hDG1RuPjzqOf/flgVw3DHI/EFnS+Z07DDWi9HbY0tEfka+gxUV0XFstIh/D7aDt4lC
         HzV5VkBVDhR6L4ix9c94oCNGVwm+0RsluIUXzHZr1glt7o+mH2uqqz4S9t1kmT85Uy
         74NhSomYyH9SgiCDwetTdKmcFOHnhB3cIylXN6+2nJWbJEBcnEkrS8Ai5bSZ2T+k3E
         CeOUkwu9QPCp3qIUx/9Lhcon/Ene/EP0bmktAqzXfSkm17CSO19zfhLD5szwjlVmOn
         mYEmlLLrKHvPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A27E1F658;
        Mon, 24 Jul 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169022342473.31808.5204114932828299333.git-patchwork-summary@kernel.org>
Date:   Mon, 24 Jul 2023 18:30:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Series: Add SPI module for StarFive JH7110 SoC
  Submitter: William Qiu <william.qiu@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=768830
  Lore link: https://lore.kernel.org/r/20230724101054.25268-1-william.qiu@starfivetech.com
    Patches: [v3,1/2] dt-bindings: spi: add reference file to YAML


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


