Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB5543DCA
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiFHUuR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiFHUuR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 16:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01981EE8E5
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 13:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A44A61CDF
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 20:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F314C34116;
        Wed,  8 Jun 2022 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654721414;
        bh=YNuccj44SZQ49slAxP5fGjzO7HZ4mJ+y8AouetOyF+w=;
        h=Subject:From:Date:To:From;
        b=A7wTLquFPfi72ymclTLC21dSuavQa37MOrpUdXMGuojQMcdMoWElRxUUO/kzSfXAS
         HsPcItXEjc5sG6aua1V8Npx4jjJFpGbFjfi7cwYWy2GGIPGvmcCOujKxWrKWbFtqv5
         nOJvOaO2rZufEtfu3rWVTN4c4ivYfvpvrB9MavRPNyyil1gbpg4Qg8o3O5OyNK3Nx9
         nLfTLurx3VTdSZUilo1RySr8OLjBqrfLbyZLWVlNIYOZwPuUYx38rb3ElwyEMV36CI
         RXkKP4RIGtoKlmX31U5hOF8134ebkREN0mysXCbRRUuk2lIacXS1Up+lshsBJDFRnG
         dEPyMjrb/eARA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 662EAE737EA;
        Wed,  8 Jun 2022 20:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165472141436.20463.11669666207837630422.git-patchwork-summary@kernel.org>
Date:   Wed, 08 Jun 2022 20:50:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: include: linux: spi: spi.h: Add missing documentation for struct members
  Submitter: David Jander <david@protonic.nl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=648443
  Lore link: https://lore.kernel.org/r/20220608122917.2892953-1-david@protonic.nl

Patch: [v2] spi: <linux/spi/spi.h>: Add missing documentation for struct members
  Submitter: David Jander <david@protonic.nl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=648540
  Lore link: https://lore.kernel.org/r/20220608153309.2899565-1-david@protonic.nl


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


