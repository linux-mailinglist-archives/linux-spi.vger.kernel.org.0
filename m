Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B27760067
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGXUUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGXUUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 16:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CAE4F
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 13:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7ED61360
        for <linux-spi@vger.kernel.org>; Mon, 24 Jul 2023 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F80C433C8;
        Mon, 24 Jul 2023 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690230021;
        bh=hBkcuvPQUjItsLYwD/cWrDTjt81VWlpfxkRqeJve/WQ=;
        h=Subject:From:Date:To:From;
        b=OeQLDBINh4ekP+gV/fO9Ew5y8rgXNpAaCj2B1aJ12CRjLJDTdBCEJv9m39eWxSdcL
         a2lLOHgjrPZkNj/ctDWFccA6p+PtDBo2p7hpHFRUAP44XunsOGh7OuciUf5iIVcvYL
         kUEuFAuc32zo3uIPvwXzc1gSXSKgFBW55lNggGiKkCzd/qO5gqPjItIGsr4kcXH7dC
         aZYnsB7b5wAHG/nvTaOaQugYpTw8TYVB5oNa2qSFbIHUzOKyBTWeIgCyIj3yvDMSdr
         zDwqKPSe4794zj24gsx2rUHXPDIxrBfemWpA5QWL2wJqF6dCJKrlnQsIcP7fFKMr+v
         C2hxellij16MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4A8BE1F65A;
        Mon, 24 Jul 2023 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169023002071.26389.11767345160719934911.git-patchwork-summary@kernel.org>
Date:   Mon, 24 Jul 2023 20:20:20 +0000
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

Series: [v2,1/3] dt-bindings: media: amphion: Fix subnode pattern
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=768879
  Lore link: https://lore.kernel.org/r/20230724122101.2903318-1-alexander.stein@ew.tq-group.com
    Patches: [v2,1/3] dt-bindings: media: amphion: Fix subnode pattern
             [v2,2/3] dt-bindings: spi: lpspi: Add power-domains


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


