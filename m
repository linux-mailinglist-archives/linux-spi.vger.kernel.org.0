Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788F735135
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 11:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjFSJ5N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjFSJ4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF669E4F
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 02:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 491C660039
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 09:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC39DC433C0;
        Mon, 19 Jun 2023 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687168605;
        bh=hRl7Lc2CvWP6Rc9bZ2rtzG5ZD8qBXZ36osEFLmagpsE=;
        h=Subject:From:Date:To:From;
        b=mQ5H4aKXNyUhqyZuWeNarCBIFUd09scToEofGgFjQAp0PmFQ6XDEWCAH5mjbeaDBx
         RCWTbVZvD0Dcz+KXGYFy61Gf7sAIbv1FNH5L9duwNo+hjkrx3ivOYBSWGv7kq4AVcR
         cDmYev9zvXBLJ4Lkv4x96HenR2KUQiAwZubEagacZOdZ6s5Le8nBaqm6dO2+3WaFWH
         8ML2oe3RhcuVEn6aeiIBpJitXmUDqGuYYlsZOMXQvG/cOjL+jrAE4akDKp15uiIvZZ
         VVVGmqx0/7Ktyn+nc0VMh+valHhYeQLzRfB6NAedxdmMJhIYXN7pp8MiHpTZbewQ5O
         PYQG8kMdYRQYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E265C43169;
        Mon, 19 Jun 2023 09:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168716860557.26648.14050756748531115631.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Jun 2023 09:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add cs42l43 PC focused SoundWire CODEC (2023-06-19T08:43:23)
  Superseding: [v3] Add cs42l43 PC focused SoundWire CODEC (2023-06-05T12:54:58):
    [v3,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [v3,2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
    [v3,3/6] mfd: cs42l43: Add support for cs42l43 core driver
    [v3,4/6] pinctrl: cs42l43: Add support for the cs42l43
    [v3,5/6] spi: cs42l43: Add SPI controller support
    [v3,6/6] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

