Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71E6DEAD3
	for <lists+linux-spi@lfdr.de>; Wed, 12 Apr 2023 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDLE4n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Apr 2023 00:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLE4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Apr 2023 00:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D4B8
        for <linux-spi@vger.kernel.org>; Tue, 11 Apr 2023 21:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBB262DF3
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 04:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B292C433D2;
        Wed, 12 Apr 2023 04:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681275400;
        bh=DQaJQHQ6H1G4aWWOTdfs4NcMS2sGDlS91vrxmtN4vdo=;
        h=Subject:From:Date:To:From;
        b=jd0m9zQg3vbyWZJ7txGP2nY7vzh0NfUqZiiNTYLN7pudUKxGECG0s2bkGGtQ45EwV
         xXtwdROMle2UYtKijYUiTRteqf+hEhMXnuZriJxTv88WiBIwWrXuCLYq90gTjVuWHX
         bFao62MYosPJBTgxGea1BMdl+7vyf1PdRYX97Bse3CKbGU21llh2c8KdX/ZKSIpG8C
         1ruM23K0Zve0kkwhmHy0tvgjL4qkgAx3LBeccv7ChSWRLPinqoo+JDV/t49sGvy6JG
         FZ2Yyk+0oY+yB7R8lxJnaZVKTnpZodLfRsVvNXob8KQvYRheQFYS5FniQb+mhChhgz
         yyG/eprycqJ9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68571E52445;
        Wed, 12 Apr 2023 04:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168127540036.23268.10110222703972805230.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 12 Apr 2023 04:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: loongson: add bus driver for the loongson spi (2023-04-12T04:51:51)
  Superseding: [v6] spi: loongson: add bus driver for the loongson spi (2023-04-01T09:56:51):
    [v6,1/2] dt-bindings: spi: add loongson spi
    [v6,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

