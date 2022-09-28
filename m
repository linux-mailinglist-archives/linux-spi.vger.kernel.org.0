Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82A15EE328
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiI1Rac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiI1RaT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 13:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505E819C17
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 10:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A28E661F42
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 17:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11A68C433C1;
        Wed, 28 Sep 2022 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386217;
        bh=gijMsslD+uIOnyWJckKDNJaBGnYaCsxePUqve0r+kSk=;
        h=Subject:From:Date:To:From;
        b=oZwvtQUV0FgFeZKo9PSIqetuF9qxLyPt9q5WgackhmMLjAWGFYYgQwJqNHxzPb4f9
         dj4rKxTh+3ngatGpwlGSj/YxNRBymmsQnZmMCGWdVFYPEhnVk8Hs4cBUBP0tczOatG
         /+e2W8luCZoXY5iCh+Dild1jlaC+OjarJePOOgm3YA2DQNa6RBgxoZU1Fy4/25C6vK
         a+7FKwWbYiPOPusp/um3gYmkSa9Ka60TP0pergBYEzN+GDZnaSbZAAVpevpA0JdlqX
         wkQ0NjrYpKbS6W5FEsJOkZB0T7gSKSShVch+thPxQ+mtRZiretxfLq7qpOI2Ah8XJN
         Waz8A5tZINSfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E305CE21EC0;
        Wed, 28 Sep 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166438621687.15210.3566185897513094986.git-patchwork-summary@kernel.org>
Date:   Wed, 28 Sep 2022 17:30:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Fix DMA bugs in (not only) spi-s3c64xx
  Submitter: Vincent Whitchurch <vincent.whitchurch@axis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=680983
  Lore link: https://lore.kernel.org/r/20220927112117.77599-1-vincent.whitchurch@axis.com
    Patches: [v2,1/4] spi: Save current RX and TX DMA devices


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


