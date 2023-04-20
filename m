Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912046E89ED
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 07:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjDTF4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 01:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTF4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 01:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A123C2A
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 22:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46ACB63405
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 05:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4D3C433EF;
        Thu, 20 Apr 2023 05:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681970199;
        bh=Y+opaaHrjH39buw0y8u1S4DHcxmGw+xLgoY+7CJqOx4=;
        h=Subject:From:Date:To:From;
        b=gvUxltGzunIhqJJMs53CDziB6wilvlnrsux33o54QUYvtkbP7Vz3c7Gt/8i9gAOPY
         rEKQ4mj78s8lHLJJdwRwn36HCrHvK1L5sww5/9VXzzMOijc7vrDzqtVrkM+P3zew5W
         BQ5REWT2wmU+hHv+AqovG5HxT2rmx1vencRkxKR0fK5stLRvcddEYpfMv1Ki31Udbr
         Iy7v+HaDVTaippntl6WNKj3rgN56udmGNaLdmMvDVetAEJImXHLW2xGriGVBzo8H+l
         BFbEZZlEQhujE9KejXmCBnz+/VASBm+sD+D6O/X+IjRS0wwp0lVvAwaiMnOjGoQBYF
         jjxZdyGfhyKTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B7BBE3309F;
        Thu, 20 Apr 2023 05:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168197019943.24380.2138312702840555059.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Apr 2023 05:56:39 +0000
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

Latest series: [v8] spi: dw: DW SPI DMA Driver updates (2023-04-20T05:51:26)
  Superseding: [v7] spi: dw: DW SPI DMA Driver updates (2023-04-18T05:28:57):
    [v7,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v7,2/5] spi: dw: Move dw_spi_can_dma()
    [v7,3/5] spi: dw: Add DMA directional capability check
    [v7,4/5] spi: dw: Add DMA address widths capability check
    [v7,5/5] spi: dw: Round of n_bytes to power of 2

Latest series: [v3] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS (2023-04-20T05:42:57)
  Superseding: [v2] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS (2023-04-19T08:48:17):
    [V2] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

