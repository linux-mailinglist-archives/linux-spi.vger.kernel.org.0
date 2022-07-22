Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4257E95D
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jul 2022 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiGVV5E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jul 2022 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiGVV4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jul 2022 17:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642542F39A
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 14:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B95A5B82B2C
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 21:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74EC5C341C7;
        Fri, 22 Jul 2022 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658526996;
        bh=OPyXgAsY47vHwx8+SJeCk/sgKHFfMgdoLLiqi2BvK5Y=;
        h=Subject:From:Date:To:From;
        b=M+BGaCNxc/zqvphXbvqaPTTigvUPumYI6yTUBJMd6sgHLRFtR5QzMzFxMzVzXnDVH
         LQy3/bM5iqLJfkX4pyNaN3EzOBik03pHHObVfgHXcbtbmusgOVatAL1omYufsUn9R8
         9m5q3XdIqO+WgeIXb1Br/Smw8vhcYCri1EB6uQ9+pcAmaaLvREaFsFRTVzan/BjaCo
         k9W5ISDg3YnuIrthhZpTvFR6wXkbXq5ixU13kk65AMggJZCjXIlwe9dKqhgnykTF+S
         djp6gjT6RPnEujNKHp/DEt8YZHEbeN/UZxMEpX4RLU+LFsm2Ymgw/VPV/aMpMzF8R5
         nkO8HDZxh3gFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 543DAE451B3;
        Fri, 22 Jul 2022 21:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165852699634.5861.8071025824991406121.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 22 Jul 2022 21:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add SPI Driver to HPE GXP Architecture (2022-07-22T21:49:15)
  Superseding: [v2] Add SPI Driver to HPE GXP Architecture (2022-07-22T17:23:34):
    [v2,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
    [v2,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
    [v2,3/5] ARM: dts: hpe: Add spi driver node
    [v2,4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
    [v2,5/5] MAINTAINERS: add spi support to GXP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

