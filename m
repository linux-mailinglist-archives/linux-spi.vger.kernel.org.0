Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC358EA21
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHJJ4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiHJJ4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 05:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E471D6EF0F
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 02:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D2C1B81AEF
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 09:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42CD7C433C1;
        Wed, 10 Aug 2022 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660125395;
        bh=ydfdsep1OiSvvF/fwbEw6+s+sVz6EsZ+hEt9irIYNUs=;
        h=Subject:From:Date:To:From;
        b=XbfdHMUKQC3bMVdwlTYL/Aqo/6UICC/tJowymFeM1b1TULF+l36wvoaQpVkWsDp+N
         SjxAPK0HK7YoqxJ1F42ACVBCGfZXyI8C9PHrZ5tmTbHGWzXnlI8bNBTFrpaaNj0oIC
         6MlLKyyEZkkAhogTtD32wAs7ghNaPlpEg5JppamLtf6nvJR7L7G/fdbt/KrJd4u+9F
         sYxw//Ou/Uc13fhsfiWPvGUW1inAkqjcOfwxumd5KPaDRO9WMU2A7FzrML+j1gjFF5
         BDDT5lSNxKY960g2Gbp/tuuvhvMMS9XJHR/vxf7w1xPgxHbh6gB+Dsf/g2odCOnQLM
         hoTQm1KnbEx1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F18BC43142;
        Wed, 10 Aug 2022 09:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166012539504.12385.7492186905710772122.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 10 Aug 2022 09:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-10T09:32:13)
  Superseding: [v1] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-08T07:40:49):
    [1/3] dt-bindings: spi: stm32: Add st,dual-flash property in st,stm32-qspi.yaml
    [2/3] spi: stm32_qspi: Add transfer_one_message() spi callback
    [3/3] ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

