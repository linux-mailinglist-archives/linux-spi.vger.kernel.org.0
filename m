Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF66B6ACF
	for <lists+linux-spi@lfdr.de>; Sun, 12 Mar 2023 20:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCLT4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Mar 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCLT4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Mar 2023 15:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A27298D5
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 12:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C258B80C2E
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA68C433EF;
        Sun, 12 Mar 2023 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678650989;
        bh=R6PuaWP2v/sPlrmybCUsCmkIjAp102KQgsYQ9G5uhkg=;
        h=Subject:From:Date:To:From;
        b=KA0H+fRSE/BV4QdE2tLKFdWoq+8lt6F3fcs3Azr8YbYzEb/4kSzoJ2PYz8enSzNgJ
         KYE7BuBngkUvM77407p5ylm0aEc1UVzRd4gnMixz+HQa3mpgPAbO6gWhSxop5n999J
         anClsq4slfgK4qTFqSyK93eHUTMQ4NCcsvJgSOAFrLqF3kt/qDks59alDgRE0tRfI4
         szCW8rTy2lfdxXHNOG+7F70YsNcgt2OacfsalomKSUCM6hKWvGMfICsBoK1NHPnC40
         0uYRRPqxCGal3fyJiT7HE3Y0j5yrt6bysgGiwH55dpCFtbERAHID04oLoxsyzgsg5B
         GnlCQyY6XRdmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA35EE61B75;
        Sun, 12 Mar 2023 19:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167865098888.9034.4272375193047965740.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 12 Mar 2023 19:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add Intel LJCA device driver (2023-03-12T19:04:30)
  Superseding: [v4] Add Intel LJCA device driver (2023-03-09T07:10:55):
    [v4,1/5] mfd: Add support for Intel LJCA device
    [v4,2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [v4,3/5] i2c: Add support for Intel LJCA USB I2C driver
    [v4,4/5] spi: Add support for Intel LJCA USB SPI driver
    [v4,5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

