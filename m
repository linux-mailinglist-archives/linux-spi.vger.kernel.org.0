Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FB872096C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjFBS4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBS4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 14:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB9B4
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 11:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DDE60EA8
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 18:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18CF3C433D2;
        Fri,  2 Jun 2023 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685732210;
        bh=IcnpA9tgLz+gvNpDcbyhfI48mTv8dA6ljSjWyvxmV3A=;
        h=Subject:From:Date:To:From;
        b=EnJN7ZqbXyHgg6p4yvKCyGJKcLTvPeB3a3xpEt6IHsVRh+4SApveYXs5ZpmT6WKPf
         1sUXhtGbMcJAC7QF9vR86l2cVwLXhdB7vQx9ZLguSDcspov0RpSb/jejX+05cOK3pJ
         7FMOEVZabNEJIG2acIqd/RxvRTMJXKT0nEzpKtEGfMU3sZRPsDfDkA18CO7fITvlZ5
         6SpILEPdawkmlcYrZe35NHOWeVToZIGg7WiG2nFbjyanhF9OdI/aFd7BNAQXpExX+q
         dPh53fwGRwYD+u4fAX707/2TVTwpvF0p8/kja6DDMabM137LmerRehl+yFMKwGxVmW
         qVvqJNhA0yAFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E08F9E52BF5;
        Fri,  2 Jun 2023 18:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168573220982.2283.12659973008272265551.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 02 Jun 2023 18:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spl022: Probe defer is no error (2023-06-02T18:12:54)
  Superseding: [v1] spi: spl022: Probe defer is no error (2023-06-02T11:11:51):
    spi: spl022: Probe defer is no error


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

