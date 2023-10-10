Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5967C0390
	for <lists+linux-spi@lfdr.de>; Tue, 10 Oct 2023 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjJJSkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Oct 2023 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJJSkb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Oct 2023 14:40:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD494
        for <linux-spi@vger.kernel.org>; Tue, 10 Oct 2023 11:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF050C433C7;
        Tue, 10 Oct 2023 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696963229;
        bh=ACUjBmc8xxqnQ/5rr4uGJgBfBAYHiFp+1+jL5DzrnE4=;
        h=Subject:From:Date:To:From;
        b=JJ4kPY8b7ZcZFKNP0sV4ZOmLyvsTnOz6YE/7mpdPJteO8QeAPOpDjuJo5HNINBseZ
         PMod4NRQM/7h4FPV+KspMtD0MBozPolLSsQZBvO5kqwIxThx6yTf57MxFAhnyo7yUQ
         qsgnIT9EK0GzX1TVmK8Oa7QEpYawINNNT6vWJXtL3Mos/xpLKygg4Fmz/hrHcKtHTp
         XMTAOpVPcEwPAoOnKmjMZCEZ6uuzAGxrIQ0v1NJiKxAqhB6k6gXt4He3Td3ey+PiWi
         PjkzgFqbGURCZbMJN/HXD8X5jQAbRqiLcn3IOGAtvciScZysEpJUyyT0IWy83UGMxf
         CCwd4BHY+au+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7423E0009E;
        Tue, 10 Oct 2023 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169696322961.22645.18230622508436463607.git-patchwork-summary@kernel.org>
Date:   Tue, 10 Oct 2023 18:40:29 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add RZ/V2M CSI slave support
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=788185
  Lore link: https://lore.kernel.org/r/20230927162508.328736-1-fabrizio.castro.jz@renesas.com
    Patches: [v2,1/2] spi: renesas,rzv2m-csi: Add CSI (SPI) target related property
             [v2,2/2] spi: rzv2m-csi: Add target mode support

Patch: spi: bcm2835: add a sentinel at the end of the lookup array
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=790042
  Lore link: https://lore.kernel.org/r/20231004183906.97845-1-brgl@bgdev.pl


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


