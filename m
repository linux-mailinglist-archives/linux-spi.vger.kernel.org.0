Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDB7504F5
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGLKlM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jul 2023 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjGLKlK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jul 2023 06:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16521FD7
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 03:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A81361741
        for <linux-spi@vger.kernel.org>; Wed, 12 Jul 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB88AC433C7;
        Wed, 12 Jul 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689158421;
        bh=n2uS9czcOwgplWTqeHuEEk1aqhnC0casKNs/c8XCZ4c=;
        h=Subject:From:Date:To:From;
        b=OCvvaZ9CcpBaTF8BbTOFVRjSXyF7A6QOaK0bX4b6g0pumhnWzA6tKK+nmeuiQabfJ
         w3nWteehHZgmo6Au950QPyEMwtcdr2s+OOLtJh9Hy3DW8yMN0Ja+eVH+tKbtOmfCMR
         bzEwcH/UiUHkL6rNA/Ge/k2PRpawkAhyWhzQv71lZcHnRZi+y/AB3u6Ar5Y7x2IAXA
         LRS23RqS7KlGB7TSEWWUxd0gPqynScJ31TLM/ZBifTB4AVjAv/D9DqJT+Xpko6x6fM
         b0IjR4TWusH3GqSt8CMgkl/8sOKAUkOT1F7biW59qXGi8as8hrtNbkFWZa3upkjJUc
         oCalRJGN4N1tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 863E1C4167B;
        Wed, 12 Jul 2023 10:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168915842143.19107.6820577797206940446.git-patchwork-summary@kernel.org>
Date:   Wed, 12 Jul 2023 10:40:21 +0000
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

Patch: spi: bcm63xx: fix max prepend length
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761125
  Lore link: https://lore.kernel.org/r/20230629071453.62024-1-jonas.gorski@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


