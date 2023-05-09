Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39206FC228
	for <lists+linux-spi@lfdr.de>; Tue,  9 May 2023 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEII4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 May 2023 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEII4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 May 2023 04:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27E10CB
        for <linux-spi@vger.kernel.org>; Tue,  9 May 2023 01:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B89263240
        for <linux-spi@vger.kernel.org>; Tue,  9 May 2023 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61CC6C433D2;
        Tue,  9 May 2023 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683622600;
        bh=lJF8H815c/ZPgCA7MJpFgg1qzn0SAqT+JgennCyqgYA=;
        h=Subject:From:Date:To:From;
        b=GU3lgHezL/sK098fVMRp92AtfWEwCZ2tdQrPMysSB4JLgwXTmZZNJDuwbazmuQbqA
         1Q6zlvUKcVbkfoCN4OVc+YIWoLnR9dsXcGM7YtodEQSchqdpk7IJViOgl1Qv/EM+zZ
         RDc/H/k4LipMMFfeOAA1hAch4fWQdBEVLFZLun6VAxDflMl1pmxUAKADW3XMlDI/IS
         2jnrEaVFdShrV0BlXu2rIg9FHbhm0qOO96dJB2J3xgAF8IzG7r9g0HCotWsUPY5Qw3
         jpuwe4i1sO/j0pFyNqFQHuobQTIhsXPddkNSBKrE4sO8O/FBCYfbsOZI0TapL9WbgV
         uP1cKtPzYl3AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43DBDE26D20;
        Tue,  9 May 2023 08:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168362260018.9935.2743566622654114049.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 09 May 2023 08:56:40 +0000
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

Latest series: [v10] spi: dw: DW SPI DMA Driver updates (2023-05-09T08:22:39)
  Superseding: [v9] spi: dw: DW SPI DMA Driver updates (2023-04-27T12:33:09):
    [v9,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v9,2/5] spi: dw: Move dw_spi_can_dma()
    [v9,3/5] spi: dw: Add DMA directional capability check
    [v9,4/5] spi: dw: Add DMA address widths capability check
    [v9,5/5] spi: dw: Round of n_bytes to power of 2


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

