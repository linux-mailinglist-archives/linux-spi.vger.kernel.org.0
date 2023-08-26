Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F209F7899E1
	for <lists+linux-spi@lfdr.de>; Sun, 27 Aug 2023 01:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHZX50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Aug 2023 19:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHZX4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 26 Aug 2023 19:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2559139
        for <linux-spi@vger.kernel.org>; Sat, 26 Aug 2023 16:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7812660F2A
        for <linux-spi@vger.kernel.org>; Sat, 26 Aug 2023 23:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0854C433C7;
        Sat, 26 Aug 2023 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693094212;
        bh=bdJzZxRHqDBuzt1X/NKzTPKSuTmHkqZljEymgf9Wl0c=;
        h=Subject:From:Date:To:From;
        b=uEQjvu7AU6URPU4hLN5u24WkDmSjis4yKR6pr3hnjSWRPd/w+1E4ZIZJ7Ya1CGUGt
         7cA6E2tpiBNFqXQMFAR4kEDckM7Lzom+FId6Jo8bQz2BFYXTm7+ldqLmdww6HqdRhs
         p53ntgVWRpRrAgYhjbFuUGHwVqfHpS/7ZOp46bSOppydWFs/AitPfYSID/aOpl8ndx
         ETpOUsIrGVeFnJV2LenraVHlcV7vKwBjA54pT6r0da8mDhed+hwaBYa8wwGtdaUbLr
         7NBPKfvYbIGwriQRuS656gnsb+Da//Ktf6hS+Jwfy+A+gVAyGmNIT9voW875eDiIFP
         sN3BnSCCrGMUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1A43C595C5;
        Sat, 26 Aug 2023 23:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169309421272.22809.8329017647212709868.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 26 Aug 2023 23:56:52 +0000
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

Latest series: [v10] Add Intel LJCA device driver (2023-08-26T23:13:59)
  Superseding: [v9] Add Intel LJCA device driver (2023-08-16T22:31:47):
    [v9,1/4] usb: Add support for Intel LJCA device
    [v9,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v9,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v9,4/4] gpio: update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

