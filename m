Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8C725ED2
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jun 2023 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjFGMUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jun 2023 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjFGMUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jun 2023 08:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AA1BD7
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 05:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E70863357
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 12:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0B42C433D2;
        Wed,  7 Jun 2023 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140419;
        bh=cf72In6Ih7DBLWQL4lLqhqhwlqrTwBHAQ80drALSxh0=;
        h=Subject:From:Date:To:From;
        b=ujlfWLoFnkVQmdWydSCP/Ag2P1T2OSVtZGLCc2KjyiBxcEVvU5R65D92VNZpouubi
         1HuAh2KlQoalHq3o20CGhHKVMFZ6+Cmzptr/liygTvdVSoGJVbhEsNc0NEkJMJq3TA
         7VqRZP1g4//XdzCWhG52PYgzJ5d2hM9bS+36r64vTP61m+SnjBQTNIeMZL/W1HNmgY
         I6SG8Ed8Njh0qb0kjIm7+LFWMg1N/OUtChlR9TGqdVgInSFuXl4I2V8fzkU7oMjjkT
         Qzc2HgicP6iW8AZEJuSjfs2HH7aWvOqPir+NeFuDNn9nPGDwZvZoaahhNEwqf7vIvE
         znDQP+QOqBMmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9A3EE29F37;
        Wed,  7 Jun 2023 12:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168614041964.26027.10203328080358554651.git-patchwork-summary@kernel.org>
Date:   Wed, 07 Jun 2023 12:20:19 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsl-dspi: avoid SCK glitches with continuous transfers
  Submitter: Vladimir Oltean <vladimir.oltean@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=751959
  Lore link: https://lore.kernel.org/r/20230529223402.1199503-1-vladimir.oltean@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


