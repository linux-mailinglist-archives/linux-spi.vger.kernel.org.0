Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A4706B8F
	for <lists+linux-spi@lfdr.de>; Wed, 17 May 2023 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjEQOuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 May 2023 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjEQOuX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 May 2023 10:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7F3C0C
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F9260B8F
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 14:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 542AFC433EF;
        Wed, 17 May 2023 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684335021;
        bh=D5HQoirXFPja35LzjfgLJi/hj8T4ut+alTlkWdOsgEQ=;
        h=Subject:From:Date:To:From;
        b=WJ3joG6HWPRen6iSSqQKfqR5ZK7Xg5MPgV4bXk9koR2VPtsZ+HLSfF6LLBoX8rqDq
         6zsusLr9IxCRvoze4PoI/domUYToDHe7HkwbId2Ou4crRA53R+KBMkC8Lt4SFQ9F+g
         wlmqf6TdlTmzRYMOW9otX5vLZ865ujAkYyMCDj2etwg1IEP8BjE+j7SMKZKv+GnDhu
         S/kbYc0tF0wa5uZmybot7OfGuN8/QEg1bh1+wb0QoSn8x2wbHKwTSUrMRjGOFXOubw
         ruHOqrqYE23ZLsJbnzQlXQBcNO0if9rFmjYT4/Z0rWma6yZACAxVDctfX7szIpk1K0
         XFNAhI+WX59Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FE1DE5421C;
        Wed, 17 May 2023 14:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168433502113.1779.4373521421783303118.git-patchwork-summary@kernel.org>
Date:   Wed, 17 May 2023 14:50:21 +0000
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

Patch: None
  Submitter: Brad Larson <blarson@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=741122
  Lore link: https://lore.kernel.org/r/20230418214945.54690-1-blarson@amd.com

Series: Support AMD Pensando Elba SoC
  Submitter: Brad Larson <blarson@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=747721
  Lore link: https://lore.kernel.org/r/20230515181606.65953-1-blarson@amd.com
    Patches: [v14,1/8] dt-bindings: arm: add AMD Pensando boards
             [v14,2/8] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
             [v14,7/8] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


