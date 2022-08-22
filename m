Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3546259C300
	for <lists+linux-spi@lfdr.de>; Mon, 22 Aug 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiHVPkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Aug 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHVPkQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Aug 2022 11:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506DDF91
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 08:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5013961149
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 15:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8A76C433D6;
        Mon, 22 Aug 2022 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182814;
        bh=QvFbePyL2jFWQyaH7OW86d1WL4fZTcd+Bd0fQVFwWGM=;
        h=Subject:From:Date:To:From;
        b=RuUskeTbnzHLo00Qh6YElabMQfLhxP8uVTmBdZiLZZySWsWatcKpAwpqlFTWrDi8e
         ejN2LYHy+r6p4qq71tFHb68KlEbJGHI9/0S3/V5nxOTrZpoIjEhgM+Ga0z93PRkNXY
         U7PZC6ZP8y216aSE1WyT5k0Y8b4JFjOGeuvIjaPRA+dXW+uNpLmFHdRzKRM482yBeH
         oyCOjkAT6vABxnWnomb2XgWbtrQaHTmUeYA7+aYklNWA6WiOdBkOSH6dCGa2zGYKV9
         1gfLqAeAg3LjmUEaDBgLHehNUIKAFqdRMfNMt+Tb5snSxJAkRH2Cc63Hf1TOdiqGRx
         gr0DIwr5Od9Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79E77C4166E;
        Mon, 22 Aug 2022 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166118281442.11041.3514148261880992819.git-patchwork-summary@kernel.org>
Date:   Mon, 22 Aug 2022 15:40:14 +0000
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

Patch: [v2] spi: cadence-quadspi: Disable irqs during indirect reads
  Submitter: None <niravkumar.l.rabara@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=667304
  Lore link: https://lore.kernel.org/r/20220813042736.1372180-1-niravkumar.l.rabara@intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


