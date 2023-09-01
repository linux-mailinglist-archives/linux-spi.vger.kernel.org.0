Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8178F83A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 07:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjIAF4z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 01:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIAF4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 01:56:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48C10C0
        for <linux-spi@vger.kernel.org>; Thu, 31 Aug 2023 22:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A022CE201A
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 05:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46EFFC433C7;
        Fri,  1 Sep 2023 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693547807;
        bh=vI1qks7zBBK3wYZ0NAuWufbP9ud2H0UrYUpYHV+UM+M=;
        h=Subject:From:Date:To:From;
        b=siv0WqFqm5XI3nCrHdzG/X1XZZuMxGwO6mIWoHA31qTJyjXFtfD8+A1uJMpVgqrWT
         IrngfyqAowEsBiNNKZJ2ZDktKBz4wQUpKsoL0KtOG+1W5Zyxsay0XpgEnfuOnyNaVb
         qvxtrZlW4KuRJhiOAKkw9ZGM1SaJrQrk//nMwiQbiLu2KBwu1Rs52bThVBtGYTT0lN
         WAV3ta4c9Yi7+xhS+us/BtBWdgLX2MrI4FuD6dv/NTMW4pMzDS/622GkMc15ac5ilk
         PrPwJ3YhFq9IUGGVj3Hs4CJGoqexy4C8bF+zSPIUdgYotHIOgYLE5xIISa5pFbsr8Z
         XntLapwChYkfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 268ACC595D2;
        Fri,  1 Sep 2023 05:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169354780715.13667.13114784981238484329.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 01 Sep 2023 05:56:47 +0000
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

Latest series: [v12] Add Intel LJCA device driver (2023-09-01T05:36:13)
  Superseding: [v11] Add Intel LJCA device driver (2023-08-29T04:54:04):
    [v11,1/4] usb: Add support for Intel LJCA device
    [v11,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v11,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v11,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

