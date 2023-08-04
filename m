Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2D76FFC7
	for <lists+linux-spi@lfdr.de>; Fri,  4 Aug 2023 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDL4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Aug 2023 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDL4p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Aug 2023 07:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316BB1
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 04:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B0E61F98
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 11:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF3DCC433C8;
        Fri,  4 Aug 2023 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691150204;
        bh=sF7Uq/Y2TaDtllTz4+E9FoeCQl5Ifx+UkwPq/sMCFPQ=;
        h=Subject:From:Date:To:From;
        b=XyLlkHEpPEzDn1xdrMrO1by1nuQEP9uRA/7/XCuhoHGQpcRbPY9KgaglidBJtAxwJ
         uxMCjsmBbFyStOJw9fBu03x/hlHcTfXEWMLAuTO67WA/2QRXyn06jc7osZBqyB26N/
         Q5ZOVsErUKZS61hLl8lh/Xbhd1YDXn/qOY3Oyia5qpepDHo379tTMbIIGRH0U6sX91
         cH90qN02ltmTWYBqE83VGfXZMOZJ1YHigdAtdEvN+cOVvNX0eNCfBnEZd2BO7vxhj8
         8aAhYArYjiF0i5cUsteqZigRtNU2xjyjbXnvVwC+eSz4sWqHvL79XYDJ73sIrqL50F
         DO65jb3FYv4pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0B71C395F3;
        Fri,  4 Aug 2023 11:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169115020384.27789.4681577534906985576.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 04 Aug 2023 11:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add cs42l43 PC focused SoundWire CODEC (2023-08-04T10:45:57)
  Superseding: [v6] Add cs42l43 PC focused SoundWire CODEC (2023-07-25T10:25:26):
    [v6,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [v6,2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
    [v6,3/6] mfd: cs42l43: Add support for cs42l43 core driver
    [v6,4/6] pinctrl: cs42l43: Add support for the cs42l43
    [v6,5/6] spi: cs42l43: Add SPI controller support
    [v6,6/6] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

