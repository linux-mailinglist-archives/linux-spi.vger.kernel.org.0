Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C97AEB11
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjIZLKe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 07:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIZLKd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 07:10:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C15116
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 04:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97852C433C8;
        Tue, 26 Sep 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695726624;
        bh=Gt4F50inRzV+ZcLkg12OSc7tV7pu2BBjPLSe3U4COhU=;
        h=Subject:From:Date:To:From;
        b=ixCsy/MVS3Q74JYd3Bes1qh9v39CgRNv1iGcE2puCFEUGzE+8zvIw33i3BMKmDWs2
         EQvXBgrWZrSmw6iLuDftjSnpcpYSjRo49SZJqc24CFJYzs0fqz87c7IdplokV3Wop3
         PyG8xgmF7jrwDfMqLUBH/Tw87AgoZOfjto9hVczx1+rHc/mOi4CMyJdWguFGOU8PIC
         8xS5Tr88ltuCeqLQi2EQZ861Z3lBFEYLipiFJ+zHj4AuV3Ac35+euyQgpfv7xful3x
         fjjMGrW0/KfiPFHf3pma+WXwO3wbQx+kCqdqp13e4q53IoiE114YH+W1bq2aQo5Oiv
         948a/OjIOJFQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 706C2C6445B;
        Tue, 26 Sep 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169572662440.10077.15092564704005820794.git-patchwork-summary@kernel.org>
Date:   Tue, 26 Sep 2023 11:10:24 +0000
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

Patch: dt-bindings: spi: fsl-imx-cspi: Document missing entries
  Submitter: Fabio Estevam <festevam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=787057
  Lore link: https://lore.kernel.org/r/20230924183904.752415-1-festevam@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


