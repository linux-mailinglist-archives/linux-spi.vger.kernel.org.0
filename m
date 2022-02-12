Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773B54B3819
	for <lists+linux-spi@lfdr.de>; Sat, 12 Feb 2022 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiBLU4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Feb 2022 15:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiBLU4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Feb 2022 15:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2F606EF
        for <linux-spi@vger.kernel.org>; Sat, 12 Feb 2022 12:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD1960DFB
        for <linux-spi@vger.kernel.org>; Sat, 12 Feb 2022 20:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13015C340E7;
        Sat, 12 Feb 2022 20:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644699380;
        bh=hi6gGOK0gzs8XigUi1iAw+gZQ7oPb5j76XdgfSQapSE=;
        h=Subject:From:Date:To:From;
        b=D6flz2pYhP8xGYaMLhZ3xMUUkPSTwkeei09EiDz2tQZK1EMNG737CF4CtNbF6M5yS
         E25MI/p3cMIi7sCPWEygStfyyuuVtbmiWxqlR0ODaiOUcyf1kYTBpTGWVAJAGirr9J
         ltyaRPNhsfuy7wH1ugKtH8OwK8TbG2BXq/1MhjbHnZtxuIIhSv3p2+x+OxA7y1QPTU
         y0Dcz4hYFuFVC3k596nZHqh11pv3OustzyMZh4rinOrD+i2tz6BMU7GcdWt2zpdyzQ
         wAYqvpCO/A4Fp7QD7FnWzKJa4yrn7+IS1SAWwe2s/pZSFLccFBp0lqOogKzAG5YjF4
         66PZIrZSlHneQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01346E5D07D;
        Sat, 12 Feb 2022 20:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164469938000.11692.15626578551436146670.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 12 Feb 2022 20:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] platform: make platform_get_irq_optional() optional (2022-02-12T20:16:31)
  Superseding: [v1] platform: make platform_get_irq_optional() optional (2022-01-10T19:54:49):
    [1/2] platform: make platform_get_irq_optional() optional
    [2/2] platform: make platform_get_irq_byname_optional() optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

