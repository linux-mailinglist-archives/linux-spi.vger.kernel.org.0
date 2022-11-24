Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2F637FD7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Nov 2022 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKXT4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Nov 2022 14:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXT4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Nov 2022 14:56:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831E90581
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 11:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACC0621F9
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 19:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 160ACC433C1;
        Thu, 24 Nov 2022 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669319789;
        bh=+MYZurMuo3cxqWINHlMoP+txijskwLzteX21mFmm6cM=;
        h=Subject:From:Date:To:From;
        b=bd3pA9NjszSqakNTZ3O7jkeA+sETzgJ9wcP8gtl2/h3x22/H4XjODa8XkdpJHKUW+
         MJO9p1ulp668WbrO0zZqOPgo4aZ2SkFLADVhQVzjO20p5IQkhaZHaz6QBUzprw2TsK
         vybC5W05wsGeaNO27S+a9Dn1fFPaPW9DZ8hNH1xntEUCMDTMWzh/P6HGEk17kgtKhs
         PCgMf0AsVdlSbkqerELaRUU0AM7Cjn1YveqLTTOJY7s7Y/ApywlXnX/jhe+RzXPivb
         y1YhdLPCAPFEeOS1bwHWq1uKGCPYZtiF9pQWAd9gQDA81zg0cu43aHKEBN5pDuwhY6
         quZJStXALrlgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2225C5C7C6;
        Thu, 24 Nov 2022 19:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166931978882.3316.17755023779488262418.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 24 Nov 2022 19:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Nuvoton WPCM450 FIU SPI flash controller (2022-11-24T19:13:57)
  Superseding: [v1] Nuvoton WPCM450 FIU SPI flash controller (2022-11-05T18:59:04):
    [1/8] pinctrl: nuvoton: wpcm450: Refactor MFSEL setting code
    [2/8] pinctrl: nuvoton: wpcm450: Fix handling of inverted MFSEL bits
    [3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
    [4/8] dt-bindings: mfd: syscon: Add nuvoton,wpcm450-shm
    [5/8] ARM: dts: wpcm450: Add FIU SPI controller node
    [6/8] ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add SPI flash
    [7/8] spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit (FIU)
    [8/8] spi: wpcm-fiu: Add direct map support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

