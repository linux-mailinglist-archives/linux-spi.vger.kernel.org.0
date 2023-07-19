Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59D75921F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jul 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGSJ4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jul 2023 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSJ4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jul 2023 05:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4F10D4
        for <linux-spi@vger.kernel.org>; Wed, 19 Jul 2023 02:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2546D6135B
        for <linux-spi@vger.kernel.org>; Wed, 19 Jul 2023 09:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 586F3C433C7;
        Wed, 19 Jul 2023 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760590;
        bh=oX6bVEc7ETcQXx1myfbUViDu9jmzW9NXu06sNDl+s/s=;
        h=Subject:From:Date:To:From;
        b=PKu4Qyi5VjYueWKLRPlDPvy+3jUNgMEHZiBlcwfnCxHeTecorAUhM301C6iyaacWq
         alzBLxdx3WOC0A8xs3z1H4NSdUtFViKfFavq72Rq6Xn3lRiajwpt9D6nnvadgO/bGw
         s2IZRjwmK402MgADWMoQZ0prG53UJiU51bHxqA7NomD5/eSzwSosqnkKhzuS6/FQM1
         9LG1l64wEZZHqcCAcjVqQE6dYQh3sga1KsriHiWDR/q0eQZaxO3Ipv2GeWOaorrtbq
         ky8cSqJoK43RhqPQ4nWzF4fFx63ZHeDkJ2fDBKYY4zOlnFxUe3A5rJOb29vorQ051x
         YMFA3OJoYAvWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EDC7C6445A;
        Wed, 19 Jul 2023 09:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168976059025.29344.14281826477944197897.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Jul 2023 09:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add initialization of clock for StarFive JH7110 SoC (2023-07-19T09:25:43)
  Superseding: [v4] Add initialization of clock for StarFive JH7110 SoC (2023-07-04T09:04:50):
    [v4,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
    [v4,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
    [v4,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

