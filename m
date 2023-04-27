Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A36F063F
	for <lists+linux-spi@lfdr.de>; Thu, 27 Apr 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbjD0M5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Apr 2023 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbjD0M5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Apr 2023 08:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174F49D2
        for <linux-spi@vger.kernel.org>; Thu, 27 Apr 2023 05:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF6060C90
        for <linux-spi@vger.kernel.org>; Thu, 27 Apr 2023 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2788C433D2;
        Thu, 27 Apr 2023 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682600209;
        bh=46XkZGZKWyk0lbTnMBOa9VX0Jgz/6QVpY8p+9P76xRU=;
        h=Subject:From:Date:To:From;
        b=ppecu+iatM0sWyKVFDzeIJc6raezOm3boVlGEW0DjX8/2no1e05RwgOwjAOsi+pCp
         1wa97aDKPobikKll3sCKRmC1HAJAZwkOykZov4GgMFf2QsQpgcWx9//61IEQTtFQyW
         C5QCcsziw4t5qYWPeNk9oIEO2Sy/1XiDTaAZUP9VEugcOZ3Zjlmx+gPZhJZe8CvuIX
         l73NC5UsClIr8INE2F6zumPCEtyejOLB8V1KwhJruHmqWRSks7x44AFXaWJTs0x3v6
         4+blN2kG7W9YOGN5PTA1YWkMbJPojWrYjub/2CWoPoXVGMGfc1KDVKpNjnG47iv8QR
         v9wCih1mWDXmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2FF5C43158;
        Thu, 27 Apr 2023 12:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168260020979.4593.11023580266634537449.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 Apr 2023 12:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] spi: dw: DW SPI DMA Driver updates (2023-04-27T12:33:09)
  Superseding: [v8] spi: dw: DW SPI DMA Driver updates (2023-04-20T05:51:26):
    [v8,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v8,2/5] spi: dw: Move dw_spi_can_dma()
    [v8,3/5] spi: dw: Add DMA directional capability check
    [v8,4/5] spi: dw: Add DMA address widths capability check
    [v8,5/5] spi: dw: Round of n_bytes to power of 2


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

