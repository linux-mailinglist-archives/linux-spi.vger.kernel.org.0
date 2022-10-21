Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D976078F7
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiJUN4v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiJUN4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57242793DD
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6782D60A77
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 13:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C71F0C433C1;
        Fri, 21 Oct 2022 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666360606;
        bh=wKsfTC+ehNze7n4HEANRwAgf1dIIDIuprlPL+ZSq1yM=;
        h=Subject:From:Date:To:From;
        b=A6g1vP3AgyO/YzC1Nl8pxgMBm5FHWDBk/nsQ6piWx75OTJVzkkRUgqBibwxSmEs07
         kCLPW3FiHuJloofE0ti1t0I7V/NzMWSrkQQQkQ/xNrDFwUFlxTHxpjrpKPVgOJDomS
         hR/rLeeim/znJhvyUwt6AOfFJIB0fAAw/WIYfvVQ2UyCMv4MMLZxshZjSY1GsEXNQU
         oQQnApADi8Hm4RMHm3WDvIb2iDQ3ox9G3M/SwTLVLQxDcQa/j3VbWtAAkzpSsLJMFe
         pfTr/kIwDOk3lHHB9PJ99mp1PoL940ebbYQ49stdPjtD8HFKvozjQqbguLjPBVGg6m
         hkqvm7QcJp82Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5EA6E270E0;
        Fri, 21 Oct 2022 13:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166636060666.16345.10278380286651768962.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Oct 2022 13:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-10-21T13:31:24)
  Superseding: [v3] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-10-19T14:01:03):
    [v3,1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
    [v3,2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

