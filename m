Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF604AB3F0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Feb 2022 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBGFx3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Feb 2022 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349388AbiBGC4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 6 Feb 2022 21:56:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E23C061A73
        for <linux-spi@vger.kernel.org>; Sun,  6 Feb 2022 18:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9849ECE0DEE
        for <linux-spi@vger.kernel.org>; Mon,  7 Feb 2022 02:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCCAAC340E9;
        Mon,  7 Feb 2022 02:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644202574;
        bh=VJFc//yiiJucI3mfsxqRY2LuZfKLH1S/Dwe8YqCors0=;
        h=Subject:From:Date:To:From;
        b=ZMRFWvSicjDPFWA6ZHIi9ptxvidUbGziBaw2e7KMxip5SLTX6KKPVubFg/EsxXqVt
         q0d7a0EqkTsCwGGJm3z06A4LxckOXNyYuEKModZXtF4qivM2Np7K3uKa5/gOspvhM9
         lFSGeaIEu1N/xyU0fHAIWyPBmOi11SI/wvWVexh0CmTTs4nkBM+lC36W8qiJwhEeHJ
         oRMENPbqdhw1Yw/oewQRxKNoJDAVYbgO1qXvUN4x4w2LK9+4n0x2K2+wBBXrupcJAs
         De1NObO/FByPFO4rfNYoWrMqojMuWo26PsVoeu8ZOaOwbpyPgL7vwe6t4akAFrlOzH
         9DQBu71mj8UHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFD1DE5D07D;
        Mon,  7 Feb 2022 02:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164420257473.27853.9902800110830086841.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Feb 2022 02:56:14 +0000
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

Latest series: [v1] spi: Modify irq request position and modify parameters (2022-02-07T01:57:22)
  Superseding: [v1] spi: Modify irq request position and modify parameters (2022-01-28T02:59:20):
    [-next] spi: Modify irq request position and modify parameters


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

