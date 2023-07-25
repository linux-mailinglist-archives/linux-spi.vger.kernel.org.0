Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB9761224
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjGYK7v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGYK72 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 06:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C41FEF
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 03:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5595B61655
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF805C433C7;
        Tue, 25 Jul 2023 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690282584;
        bh=DI+O4fLOxiiorfR/IzsXN9rAz//s+eBpmQhTdZmA/tk=;
        h=Subject:From:Date:To:From;
        b=Q00w5UH1jZCOn9lDCUvY3MwM2Nkemej341492TxGISCcuTHTP6O2HJxn1loMGu/R6
         m4r6JTiiQSZrfalgfOl+D6W+63Z05iiFmI5dMe0hUGjV9dU6PBZCNOOMLKP22lzIbf
         SIUi804jlLAq0lf9pqlltx8ECloFvPILIUIKLBjsqlSldzRwgbLqAvZ1YCPkFcAkZY
         4nn0ZDuOaqwFAqR02j2mNqafoSPmUBh0j4FtKtTgCvp8b1+bwWXvpUFNtIUksvIZUm
         C1FI8gkfwo5VRtmgEZquxZmG300CJr2vNVqFcbXJ60RKHSDGjBuJJCpp4CMuhiC6K4
         IveNg+MfbmKJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA10EC4166D;
        Tue, 25 Jul 2023 10:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169028258469.5589.15400626143903520779.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 25 Jul 2023 10:56:24 +0000
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

Latest series: [v6] Add cs42l43 PC focused SoundWire CODEC (2023-07-25T10:25:26)
  Superseding: [v5] Add cs42l43 PC focused SoundWire CODEC (2023-06-19T09:56:20):
    [v5,1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
    [v5,2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
    [v5,3/6] mfd: cs42l43: Add support for cs42l43 core driver
    [v5,4/6] pinctrl: cs42l43: Add support for the cs42l43
    [v5,5/6] spi: cs42l43: Add SPI controller support
    [v5,6/6] ASoC: cs42l43: Add support for the cs42l43


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

