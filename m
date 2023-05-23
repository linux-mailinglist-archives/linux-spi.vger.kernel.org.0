Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE570E75D
	for <lists+linux-spi@lfdr.de>; Tue, 23 May 2023 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjEWVaa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 May 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjEWVa3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 May 2023 17:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4218F
        for <linux-spi@vger.kernel.org>; Tue, 23 May 2023 14:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9949B635CC
        for <linux-spi@vger.kernel.org>; Tue, 23 May 2023 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 051AAC4339B;
        Tue, 23 May 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684877420;
        bh=oXpSjom0RpDYkjDL+g1KodWu4M0pTBm47CG6SG0jTt4=;
        h=Subject:From:Date:To:From;
        b=H7zewzm00mfRj4L9oqcZXRkEZyUxk/rrKObrnHLGNUYbVlR9Xtm+ACKJZ2EXVzyz2
         tEOuxxOOfGKbLrdUwNzUwhLmdT25kFNARIXRly0Yw7PsWg4tIoY3TEqJDGzKI9oPkK
         kdZ0fhkdc76EHCkVO8g2bcyZnujODL/OGssMluvLO9dTA2UOOtIwDPvBZ9L6dD8LpK
         +zSG+tAKFGSNcsTz/TOw0efOoNM0ZDvxJK5JJmikAaPxjQ264TZQK91GNlcLCR8chT
         1DzH49kdJPJUlpTdwI5v2GVW879MLqiuXByk4gWGDeHLG3lF27o2Ly+KxuKpcC2hZB
         mekKwz72z0VBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D275AE22B06;
        Tue, 23 May 2023 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168487741974.26644.2658404038991663184.git-patchwork-summary@kernel.org>
Date:   Tue, 23 May 2023 21:30:19 +0000
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

Series: spi: spi-imx: fix use of more than four chip selects
  Submitter: Rasmus Villemoes <linux@rasmusvillemoes.dk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=743063
  Lore link: https://lore.kernel.org/r/20230425134527.483607-1-linux@rasmusvillemoes.dk
    Patches: [1/3] spi: spi-imx: use "controller" variable consistently in spi_imx_probe()
             [2/3] spi: spi-imx: set max_native_cs for imx51/imx53/imx6 variants


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


