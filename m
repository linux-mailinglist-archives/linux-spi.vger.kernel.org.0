Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43C68814F
	for <lists+linux-spi@lfdr.de>; Thu,  2 Feb 2023 16:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjBBPK7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Feb 2023 10:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBBPK5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Feb 2023 10:10:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB331205A
        for <linux-spi@vger.kernel.org>; Thu,  2 Feb 2023 07:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBF561BB5
        for <linux-spi@vger.kernel.org>; Thu,  2 Feb 2023 15:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E17C433D2;
        Thu,  2 Feb 2023 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675350618;
        bh=ryMtdbxYooFbxfdRG4bH5kcBRUvQilxDemxdodhyFBI=;
        h=Subject:From:Date:To:From;
        b=F2mjyRReRzyPdxvoGeVrfiN6YfrgMK51f1rrEW0GxGiA5me4TO9yXMVZ9m4j1YURx
         tcp0hZO3/tgiQP5KR5xRvZ8SVQ4GVsfOVWXEzlw2VHGrM4iWq2qjc+soZJtu0wRtyH
         Q0PJFXpdIgk4O3F2GcXLU5nNj5BuhEInBINKBh45V9xt1F4Id0jH+gsCTKJ/MCnZSm
         wxy0rmzjPEVoA1c0ZsL2dB5nPQfiEzH67QiIHvbCxXa2cViPK5hp+oavPNZ/nnqUaX
         EmOseYO08+gRKasAKtF7o5b5ZgDH6ui1iwH8ngusfTKwyDkBNs1M84er3kCsdFwWMo
         j32Y5TBS0OTcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2CAFC0C40E;
        Thu,  2 Feb 2023 15:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167535061779.3302.9276843718142489471.git-patchwork-summary@kernel.org>
Date:   Thu, 02 Feb 2023 15:10:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: intel: PCI driver housekeeping
  Submitter: Mauro Lima <mauro.lima@eclypsium.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=717889
  Lore link: https://lore.kernel.org/r/20230201205455.550308-1-mauro.lima@eclypsium.com
    Patches: [v2,1/2] spi: intel: Fix device private data and PR_NUM for Broxton controllers


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


