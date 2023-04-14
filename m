Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DEF6E23BB
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDNM4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDNM4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6393F7
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA7A60C8E
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 12:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD2A7C433EF;
        Fri, 14 Apr 2023 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681476999;
        bh=+hq36SMDDTw8Q4qjzZ5MT7/qLgPNKDs6M7I8WbNnnAY=;
        h=Subject:From:Date:To:From;
        b=fPlAWAy7P2HLU6V3A16wtVcJJPAOUdtxPGeTgBozlVR8bRhucmUFQcPDs56VjMgvx
         v4QekqMLrTfsM83laFEcN++rftErzGSFt8z62lmEZQJ1VcGYvZjRVpb0rWcR5tYIwj
         jaGrBVbC6wJcsRjVVzE1SylNKcRcn7PuSZZFhVs2l+SbKbKkcXvykrO968GwgBsKeM
         UVoCU85EurHM17lodlpDng1TzcH5ohWr0pKaz135JKCofIOrzGT8xxrGISlHB833sl
         YalEmC9tu2nU1doTDVSN2BX3GDEfhp/MB3A41SuDsA64UCl87ODKzsMRGPLRPAZNFA
         gZ/K0L5z++FAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2FCAE52441;
        Fri, 14 Apr 2023 12:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168147699958.15033.597486377405322232.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Apr 2023 12:56:39 +0000
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

Latest series: [v6] spi: dw: DW SPI DMA Driver updates (2023-04-14T12:05:15)
  Superseding: [v5] spi: dw: DW SPI DMA Driver updates (2023-03-30T06:34:48):
    [v5,1/2] spi: dw: Add 32 bpw support to DW DMA Controller
    [v5,2/2] spi: dw: Add dma controller capability checks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

