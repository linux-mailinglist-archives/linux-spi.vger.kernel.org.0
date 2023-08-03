Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987676F1DD
	for <lists+linux-spi@lfdr.de>; Thu,  3 Aug 2023 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHCSa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Aug 2023 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSa1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Aug 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C86212D
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 11:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A8561D95
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42173C433C8;
        Thu,  3 Aug 2023 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691087425;
        bh=OMBXbJ7O9j29scyUuMRuXnC5ztv2VLUVGgpKZ1PGlqo=;
        h=Subject:From:Date:To:From;
        b=VlrNb4l4mg54tunoYwM10bDpzNYF94iUbYoUpKou5Y6g6ZSzx8Hjt2y+AGOSODGil
         uoxQ6qQ39jQ7nThGGVbBNl84oPpUc77/VnketnGeGl7ZfnmmVENfX5d7vFutRkMX9w
         BxaiYdlaFbp0SbP5dZQut2mInKdc4wYlvO45eVEGW457p29njR4op3JeCSjzWfOE8W
         YzkvOj2eWCRC5FbC9cGQnxQsC0qn3ZvuPjPoTVcxGx4/YlnhFR+JiF5xZLeS0daWBm
         xeE/CJbrAwvFTz0fIaouTe2AE96PL/tEnKS++064Pfa1bUS+EbO+9A2KMMVQy2TJYD
         aQ1WXbSYe3j4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BF96C43168;
        Thu,  3 Aug 2023 18:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169108742500.1891.325923662120559662.git-patchwork-summary@kernel.org>
Date:   Thu, 03 Aug 2023 18:30:25 +0000
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

Series: [1/2] dt-bindings: spi: spi-cadence: Describe power-domains property
  Submitter: Michal Simek <michal.simek@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772466
  Lore link: https://lore.kernel.org/r/987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com
    Patches: [1/2] dt-bindings: spi: spi-cadence: Describe power-domains property
             [2/2] dt-bindings: spi: spi-cadence: Add label property

Patch: [-next] spi: mpc5xxx-psc: Fix unsigned expression compared with zero
  Submitter: Li Zetao <lizetao1@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=772656
  Lore link: https://lore.kernel.org/r/20230803134805.1037251-1-lizetao1@huawei.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


