Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1255469A
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jun 2022 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiFVJ4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jun 2022 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFVJ4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jun 2022 05:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA33A183
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 02:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A0761920
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 09:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7406C34114;
        Wed, 22 Jun 2022 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655891790;
        bh=MfZlYFKdxqatoLL622JBRLV4k+rM6zQzw8UGcgZZZy4=;
        h=Subject:From:Date:To:From;
        b=Z+Y5nHseD2+UrQ5d3PdYbouZRGiKV+xX1219g1aM9NIYHo1UvIxRijHzwK4LSr89t
         5bROtQZCwSrxxMoGNhq1bZz+4FFt/X8/GqWXjzFrjaArI9SjpuqF4XeDy+zigIi3O7
         q8EXh70LULsFKiXaXseo1azlBODydUFVisezbGbOLl/9crBu1Ji0i/NBlqIkpSCYc+
         B/YWzpVkWA7iLV+Eq00Z44Oh93peCuxt19y1++QOeGBTWuKljYfG86chvSodeyKFy6
         L+fJIzbHli7GNS8Yf2hu7M4PFexVkQVWZLFTTmogQE6fyYaP4cnzdc1XY7Pc1TbtcF
         TOMdKyPCju2Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E667E737E8;
        Wed, 22 Jun 2022 09:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165589179052.13871.18158695789593962958.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Jun 2022 09:56:30 +0000
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

Latest series: [v2] spi: aspeed: Fix division by zero (2022-06-22T09:42:31)
  Superseding: [v1] spi: aspeed: Fix division by zero (2022-06-11T10:39:29):
    spi: aspeed: Fix division by zero


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

