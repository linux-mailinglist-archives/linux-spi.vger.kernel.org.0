Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8C563199
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jul 2022 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGAKkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jul 2022 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiGAKkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jul 2022 06:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5657B346
        for <linux-spi@vger.kernel.org>; Fri,  1 Jul 2022 03:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B407AB82F7F
        for <linux-spi@vger.kernel.org>; Fri,  1 Jul 2022 10:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C66FC3411E;
        Fri,  1 Jul 2022 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656672014;
        bh=F5fZ7dQUCe6lcg6D94QrUqpszlzLxsBlqS9yfzT+fTI=;
        h=Subject:From:Date:To:From;
        b=Kx3tZZD58o1A8All3qx+tuILg8e9nAaPOcyGUF+8LqnhnlP5k/fI1Erv9WkfeYaaS
         f37Uy1d/5JJU04/Bmqx7z9lclId/PKjmAHV2SJmRj4YuTzEwpSDdDZ698dCFoufVCL
         7HFqV5Tx8yPXG47tObRbEIVXeR7ek0tHJTUn4vyfR+ix8BpblF5aJEnf5bn//jSWzi
         TCnka6NHOw1+nZirUsRUNCGbqzKP4YRC2eunAf2WWstP9WqGXsPUhapY36zihkAYwQ
         a5f2Q1rCmbSlg5r4udUvYA7cjfFQuccjjWoJVvRrB5puRuDt5bIOFEgx9XN47V/3W/
         WCe6WamVOQnsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A2D1E49BB8;
        Fri,  1 Jul 2022 10:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165667201431.26485.9597070074499987243.git-patchwork-summary@kernel.org>
Date:   Fri, 01 Jul 2022 10:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Canaan devicetree fixes
  Submitter: Conor Dooley <mail@conchuod.ie>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=655138
  Lore link: https://lore.kernel.org/r/20220629184343.3438856-1-mail@conchuod.ie
    Patches: [v3,01/15] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
             [v3,04/15] spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


