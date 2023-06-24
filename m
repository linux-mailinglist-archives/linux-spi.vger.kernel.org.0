Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC173C5A7
	for <lists+linux-spi@lfdr.de>; Sat, 24 Jun 2023 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjFXBAX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Jun 2023 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXBAW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Jun 2023 21:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3379B193
        for <linux-spi@vger.kernel.org>; Fri, 23 Jun 2023 18:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C3561B46
        for <linux-spi@vger.kernel.org>; Sat, 24 Jun 2023 01:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E17E5C433CB;
        Sat, 24 Jun 2023 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687568420;
        bh=eMM/+WsfafzZO+ncO7Wph9MDiiXB3tHdVlzLRZqpSf8=;
        h=Subject:From:Date:To:From;
        b=SgddHLiy4h0Fd5IeTVx9ZIUIqKqo6Jbe7dNZRvB6VByqzZ+6JTWC/FZ/Ris/y7UlG
         +1GcKtQ+rxwiBKiszXeEADmrhfdgzf6hiY64pB68+9VNFYfcHHGWU2JwP8O2+qiaZS
         9HYOZok/jUVj2lC1pk0ykGWn2lb2glOygeK9XCVFVDXpVDItDxXSDbBKvUaIqGoEe+
         WSrunxMtS9Z5WJFEWM0FafhUzu/RR69R9iPdf6Te5hSZ+AT0Jh5QZ69AYGLETSodi3
         lndr585pvyIS7ckHwg8N99bQNLczeCr15/+cCgBXPHkJWqbekJc1lEN7RJRJPIzv+5
         8yVSGPM3R3rQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCF72C43143;
        Sat, 24 Jun 2023 01:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168756842068.22824.3600584546583431574.git-patchwork-summary@kernel.org>
Date:   Sat, 24 Jun 2023 01:00:20 +0000
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

Series: Add support for sam9x7 SoC family
  Submitter: Varshini Rajendran <varshini.rajendran@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=759897
  Lore link: https://lore.kernel.org/r/20230623203056.689705-1-varshini.rajendran@microchip.com
    Patches: [v2,01/45] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x60, sam9x7 compatible
             [v2,32/45] spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7 compatible


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


