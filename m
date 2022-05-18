Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3452C83A
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiERX4w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 May 2022 19:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiERX4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 May 2022 19:56:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D33A3080
        for <linux-spi@vger.kernel.org>; Wed, 18 May 2022 16:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D280DB81C03
        for <linux-spi@vger.kernel.org>; Wed, 18 May 2022 23:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88F49C385A5;
        Wed, 18 May 2022 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918192;
        bh=7JtfBM7pW6PCoZhRs9OVZa7kbChWZQbG4D7M+badY5k=;
        h=Subject:From:Date:To:From;
        b=aIXflUx4Tp/hw55EgIUumNuEyKdhAtXStkxOpmPVj8BgFawePo2TjPafBJZCSpf2d
         g6EL5yxnKllgWQ8FIjNevDKqlSo33B0FPAh4yhPI/g2dW5ELAoHjVyAG5Z9QjueuU1
         2ke8+Rp4LU/gwyZPvngvNcFu07nmw9xQonRogADHjDL7n6uvrvYclw72e6udzOKnSj
         8joQfd1uap6fBk3l5Q7U4/Hdo+LXpvcryvXEygX+7RF8Yy7gdvdAU2y5+2wQ6obspm
         7l0MLY40Az5bx6iBgc8HIvt4Q8fDKWMhhtTXLFLZFFiv9OE/sM8HiQAaOeeslWSE5G
         TUJC8182dSlWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FCE5F0383D;
        Wed, 18 May 2022 23:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165291819245.9705.8406087620922277699.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 18 May 2022 23:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings (2022-05-18T23:46:04)
  Superseding: [v1] spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings (2022-04-12T00:19:18):
    spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

