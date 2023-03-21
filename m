Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88D6C3217
	for <lists+linux-spi@lfdr.de>; Tue, 21 Mar 2023 13:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCUM4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Mar 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUM4h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Mar 2023 08:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D558233F4
        for <linux-spi@vger.kernel.org>; Tue, 21 Mar 2023 05:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EB261B65
        for <linux-spi@vger.kernel.org>; Tue, 21 Mar 2023 12:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6134C433EF;
        Tue, 21 Mar 2023 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679403394;
        bh=N7SGW3BCTwzPtEQtpG8hdXWlkVWy6Vvpmu3ezE5nYmM=;
        h=Subject:From:Date:To:From;
        b=tYw7T7riyW0By+x069IIX1kKvoXcnwXjwomM7qGsKEAzydxGNyPmnPmuCCSASEoJc
         /JampQe3ZWWH5EI0rg5akk5AGQCZD57v0w/W6hzEzb/V7MwA8dfXa+X25p311xx+t3
         11IK4bpZTRK8O7DK4DLmyoO4ijdxhoOv/aRoJqW5YuGPsVjVNupz1o8j7baM2qQgCh
         3HsR5OzUvpFZ6FiFgnt+fmy+1UHk5JaVtF8C8kwXkyvowkAbb3tilXOCr9uhTzEO/e
         pW3hOcASmSdg78NLKaGU9Jm7eS665zxy+/aqJKakBvNMLBCN496JXdhjDW77SWs7VI
         zzNXPRjn2NuYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD45EE4F0DA;
        Tue, 21 Mar 2023 12:56:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167940339483.31141.10988224678201920638.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Mar 2023 12:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: Add 32 bpw support to DW DMA Controller (2023-03-21T11:58:43)
  Superseding: [v1] spi: dw: Add 32 bpw support to DW DMA Controller (2023-03-20T05:57:46):
    spi: dw: Add 32 bpw support to DW DMA Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

