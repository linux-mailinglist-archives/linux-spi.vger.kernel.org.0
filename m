Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EB580606
	for <lists+linux-spi@lfdr.de>; Mon, 25 Jul 2022 22:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiGYU4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Jul 2022 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiGYU4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Jul 2022 16:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0A237CA
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 13:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D954B8110C
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 20:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8964C341D1;
        Mon, 25 Jul 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658782598;
        bh=zmBy0ux7PAD9w96VuzS/yjT7infrS4NNqhIsLw7wMl8=;
        h=Subject:From:Date:To:From;
        b=X+g6m4czJrkY+tS6WY5GLB31PznQVkSKbZm6NMW62iZFpXNbQ+8pieZvwOOH+j+ML
         Xc8gXo6mMHRN1K+en1OnkJlr40cM0JIJ2WSeTboTYoOcsLtRZYbgLgrnbN8pi/bqIz
         MDmbtVOjFWxM/FOk0xuV8GyYLQ+H1YheaDufP6o61L6KZvCKZXhqHJ74kk22kcGMjy
         Jaid+FvIDmo7WM7aIOmkK11cpGFQ6k+rQCG8ZneFX8p2AHMnglhIj/CCPzNjl22z2V
         07Ai7u3JftEn+7ynt1S87G99yQV7nuQ/T1mYjxXkvnEEMZ0nStEWkRFPRW/23Xe8ga
         oBBjGnWMmqPKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA08E450B4;
        Mon, 25 Jul 2022 20:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165878259878.8212.5586726109497677345.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 25 Jul 2022 20:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add SPI Driver to HPE GXP Architecture (2022-07-25T20:13:21)
  Superseding: [v3] Add SPI Driver to HPE GXP Architecture (2022-07-22T21:49:15):
    [v3,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
    [v3,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
    [v3,3/5] ARM: dts: hpe: Add spi driver node
    [v3,4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
    [v3,5/5] MAINTAINERS: add spi support to GXP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

