Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4C7F1938
	for <lists+linux-spi@lfdr.de>; Mon, 20 Nov 2023 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKTRAc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Nov 2023 12:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKTRAb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Nov 2023 12:00:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0204D47
        for <linux-spi@vger.kernel.org>; Mon, 20 Nov 2023 09:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BF3CC433C7;
        Mon, 20 Nov 2023 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700499627;
        bh=1krdHdKvPfNirIzn4/pBc31LtZh+QWXC7YSTyxFtBEY=;
        h=Subject:From:Date:To:From;
        b=J/Tt/l08W9upAWL3/45ZAALg2FLSSzCacYAQjbWHA7BJORI8YoqDu2FNnY+tH+6Qa
         BHo9j99ngLTZg3qtTlOa+mAjkCAujGCxxo3OVOuEiBDxXKlUElJ1GU/5TAIWEPokvH
         w0Ow5Yx9JMm0fZsHc2b6RmeRSSAeHXKAfoUoda5qX+5FbxzTs7WizpfQ88VO64P61I
         3IeihI7IT6+L2BMfcxJQYKinB79cAqrolC66EcVL6yJvRGq6+Q8IEli7TeCdFD/WHd
         Oc6hyBaOtlLMVqLZi3twvn+7yV5nuF/sg+oP7yJsSjwO7RKwNXEXVPePYjK9wk6/F6
         c5CTVLwmBtWCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42B62EAA957;
        Mon, 20 Nov 2023 17:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170049962720.4690.8797678165103782120.git-patchwork-summary@kernel.org>
Date:   Mon, 20 Nov 2023 17:00:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Patch: spi: ingenic: convert not to use dma_request_slave_channel()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=802259
  Lore link: https://lore.kernel.org/r/1c88236b5d6bff0af902492ea9e066c8cb0dfef5.1700391566.git.christophe.jaillet@wanadoo.fr


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


