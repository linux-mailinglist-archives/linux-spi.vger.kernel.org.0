Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9426450A43F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Apr 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389017AbiDUPd7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Apr 2022 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390147AbiDUPd4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Apr 2022 11:33:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F029FC9
        for <linux-spi@vger.kernel.org>; Thu, 21 Apr 2022 08:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DD6CB826C5
        for <linux-spi@vger.kernel.org>; Thu, 21 Apr 2022 15:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05315C385A8;
        Thu, 21 Apr 2022 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650555064;
        bh=JTYQxLySbDF73cSHXX+3+wViuw8+6qclZcxBzdYo85I=;
        h=Subject:From:Date:To:From;
        b=EPBrxU9Aeos1p+KJCPiULDjwp0I3Lj40+t6vsJ8pFPpFnbHoTEdx1/x7NEsPLYDIa
         hYYN9F1BI1sPcnHvHxDRHwCoPua5xoG5aKFyGmS0jd7cqoCbXf0sD+M1D4P/9qas+p
         7oWu0GB3SxmtSRO9+vQkw7zZp2mU4Iszg5XghLHrjK01gPMo5Wnpembh9l6gI9uhbt
         W/eIq8qzugesSbor0xMqMDcUQGnLqb/tDorCi1iCcsPIxL473A5S7b37B915xzyVuk
         ONchUpo6Qaqq5WFbBVKWHVPnCZtv24S4CpIpEnYLkIWlGmnPG/cAIhEuKPQucIztCD
         8OcSdxIDbNY2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E54A1E85D90;
        Thu, 21 Apr 2022 15:31:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165055506393.23603.7054816891294663372.git-patchwork-summary@kernel.org>
Date:   Thu, 21 Apr 2022 15:31:03 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-mem: check if data buffers are on stack
  Submitter: Pratyush Yadav <p.yadav@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=633730
  Lore link: https://lore.kernel.org/r/20220420102022.3310970-1-p.yadav@ti.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


