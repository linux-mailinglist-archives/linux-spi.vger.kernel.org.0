Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4C74AACC
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jul 2023 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGGF40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jul 2023 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGF4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jul 2023 01:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1EE3
        for <linux-spi@vger.kernel.org>; Thu,  6 Jul 2023 22:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B206173C
        for <linux-spi@vger.kernel.org>; Fri,  7 Jul 2023 05:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DB84C433C8;
        Fri,  7 Jul 2023 05:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709383;
        bh=FKykGnvtiM5Br8I1wc/6JlI4krEb9KxxVWWnqBjN4PY=;
        h=Subject:From:Date:To:From;
        b=S0NHHAUbRIGn+Epk3DI5c4cDB2gzIv6AV6GHbODZs/wn7hHuioa5PyD1GE1sMwelt
         shPOW7n+ZfCG5bErcHehmTHpkvJ6vJdB6ozFH1r9caK24OjZWnQ/N5yWRiunmM7s7k
         Y+O7ZSATzI6r9n4lq27zhyeNoj4zYhXTvSMx4QrM9PrL0T33Odjwx589zpFbHnh82R
         6KJZrsM6tuqcYJ5ZB/xS7wmuU7F7dFiw51kLQqyWrZqoq2IKYftHPQe2kR3tSE6r4i
         G0zbG+2t4sZS6b6N5HlUJ8Ncu/Okh3W6EqsljOgCLYqPNccTeTygV6UXUlXvAtc90y
         nVfjcdayQdCMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38F6DC4167B;
        Fri,  7 Jul 2023 05:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168870938322.8072.10024682020007803604.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 07 Jul 2023 05:56:23 +0000
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

Latest series: [v5] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-07-07T05:16:34)
  Superseding: [v3] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-06-22T13:59:52):
    [v3,1/3] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
    [v3,2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI device mode support for GENI based QuPv3
    [v3,3/3] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

