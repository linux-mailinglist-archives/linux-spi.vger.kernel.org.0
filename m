Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE44DD355
	for <lists+linux-spi@lfdr.de>; Fri, 18 Mar 2022 03:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiCRC5t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Mar 2022 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiCRC5t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 22:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281D1F2DD6
        for <linux-spi@vger.kernel.org>; Thu, 17 Mar 2022 19:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5F06164E
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 02:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 692DFC340E9;
        Fri, 18 Mar 2022 02:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647572190;
        bh=04T+pNEyzV9uBQx2s9SuAb6xQzkLNh4s72X0QCRxZCU=;
        h=Subject:From:Date:To:From;
        b=g+MgraMUl2Op1j8ZjjG18fF+gByGR4A5mdUAHniQ6t8F15uvSCFVecd0BTrb+jWg6
         ycVvw2atixpgYWP/3hMU9PmdneY3sHq86X8yFGu+gDBK/zqkoOcAwogAX/reQ66qXA
         QuoaVTQ24IhcuWNRkmKvJDm0eHpamWNA1GCKZ1PHGst7EiHH1vB4wfigR6gQvrFj0s
         i7XtxzpZC5VsaqWGt7OB8C3TTMOShKbPPM7eI5OxDxwPt4HRXDMgx0RAZkDN2MrYuV
         Al+f12QeKVVs4ZbcXvbMSaob8+oIRlhahVUpDB9cpBo7w1jsgULqjftVlF9QFqCLlH
         w8aCD1XPJHrkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F35EE8DD5B;
        Fri, 18 Mar 2022 02:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164757219032.1445.11689522584278348161.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 18 Mar 2022 02:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: mediatek: add single/quad mode support (2022-03-18T02:50:24)
  Superseding: [v4] spi: mediatek: add single/quad mode support (2022-03-15T03:24:06):
    [V4,1/6] spi: mediatek: support tick_delay without enhance_timing
    [V4,2/6] dt-bindings: spi: Add compatible for MT7986
    [V4,3/6] spi: mediatek: add ipm design support for MT7986
    [V4,4/6] spi: mediatek: add spi memory support for ipm design
    [V4,5/6] dt-bindings: spi: support hclk
    [V4,6/6] spi: mediatek: support hclk


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

