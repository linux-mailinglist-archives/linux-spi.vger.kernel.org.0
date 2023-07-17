Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210E755FE2
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jul 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGQJ4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jul 2023 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGQJ4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jul 2023 05:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EEA4
        for <linux-spi@vger.kernel.org>; Mon, 17 Jul 2023 02:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FDFB6100A
        for <linux-spi@vger.kernel.org>; Mon, 17 Jul 2023 09:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE201C433C8;
        Mon, 17 Jul 2023 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689587781;
        bh=MDpCJVTcPt71vJN5JXQt2Jbs1dyK70iOYWGro55vNW8=;
        h=Subject:From:Date:To:From;
        b=diK4tzFkBlB9AEzC2BARqLpjemfO+K3np2rdgl9HdaaXLc/pi5sLisqQR0gWTS+yL
         FD/WeiM40yWwFQN9hWC0kJa6r1MuQt4vuYggrsWyEoA6qwyXjZsFRbX4Lu/QNaNWQQ
         oQM00h8s0LZHQLuIdlJSaIslx3Y9xZD4utu9tcwNLNW+qjc9AQO8TKQlJZFYcPHKQH
         J+hJzJdtPUNQe1kuHQYEeLEgsVLjwK6bSMKabdyl9NIblgsgaRuDbpDAI8TRScpNvf
         QF4wWnmgoNRTYqvwC0PWFxwqusW5IQpFBEGDI42nN0OZqBep/2xhYm/9F9gjjxb+aX
         Hu4jFkYhFaBPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7EA5C561EE;
        Mon, 17 Jul 2023 09:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168958778170.16229.15807408833562767540.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 17 Jul 2023 09:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-fsl-lpspi: Remove num_cs from device struct (2023-07-17T08:59:32)
  Superseding: [v1] spi: spi-fsl-lpspi: Remove num_cs from device struct (2023-07-05T09:01:43):
    [1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
    [2/3] spi: spi-fsl-lpspi: Move controller initialization further down
    [3/3] spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

