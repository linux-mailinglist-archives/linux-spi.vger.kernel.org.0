Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7606459DE2C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Aug 2022 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352777AbiHWKMj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Aug 2022 06:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353462AbiHWKLb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Aug 2022 06:11:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0E7F0B5
        for <linux-spi@vger.kernel.org>; Tue, 23 Aug 2022 01:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D337CE1B4B
        for <linux-spi@vger.kernel.org>; Tue, 23 Aug 2022 08:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9652C4347C;
        Tue, 23 Aug 2022 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661245008;
        bh=Ou2X4+FcwH3jMEPxorPlLVuoE1+c7Pr5YPiW7NHPvVA=;
        h=Subject:From:Date:To:From;
        b=BqxHIlG8vHCH+rRSV9Y8r83pLpJp3R8o6YnxQlRq2nfVhL3SSKQtLF8TO8sjVlZse
         tlPDrafcPztLhnhQXh2RO63Y0Da/RUQu87nFCNLKNW+GDhUBycBHuNxIMwXkHQx9Zu
         +pbRzxZEwR78UTUJppJXjTxyXWuGl6OHziEgHkmK/W2N+6xdGVRRMvQ3RYUBn9csMp
         UGL5p6PqhHnNX/HEUKvSZ9K+Jt+8Uzw+IYRb8VQA2TFtmjvboRr/AoGwj+ZF4QEHs1
         /PkR4X/dPb6f6Gro0/puBSvKUXhj2nnvuVuQl5dYqNWBQSfrwQSEh/1lIyq4lRjcUj
         3PBzx69fAdLAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4DEBC004EF;
        Tue, 23 Aug 2022 08:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166124500873.9245.6329855350683362198.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 23 Aug 2022 08:56:48 +0000
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

Latest series: [v4] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-23T07:58:49)
  Superseding: [v3] spi: stm32_qspi: use QSPI bus as 8 lines communication channel (2022-08-16T16:13:42):
    [v3,1/2] ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi
    [v3,2/2] spi: stm32_qspi: Add transfer_one_message() spi callback


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

