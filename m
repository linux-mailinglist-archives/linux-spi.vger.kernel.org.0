Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720937EE84E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Nov 2023 21:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKPUad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Nov 2023 15:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPUac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Nov 2023 15:30:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216398
        for <linux-spi@vger.kernel.org>; Thu, 16 Nov 2023 12:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 894B5C433C7;
        Thu, 16 Nov 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700166628;
        bh=uCq4HtiTu51hhUlmfLy+DZwd3x0ZhdhsyunEy7irfn8=;
        h=Subject:From:Date:To:From;
        b=m2EEJ47qbTiczUplZtow2g2Jp8hAIKcSLqTV3zITV6xJA+4OXWwTT8zDbjnEoVh8H
         bJOce62f6rNDbOBeH3f2GVxDbaM9QW7/bX4I7DBcst//jdS4jBzdrjhv1y3qFEUKCh
         yoEFFUSFhIBcMYZbN8UT2e1Bvi88cBl4jvLrXcO/iR2FP8cP+q264ou5uUq3qWfl5G
         K5z0xvFz96b7vkfG86+QTBeaMs+FIbYC3PV4Dt7ZfpBybwqCTH5plPfUMOhziYjZWQ
         45eMG1mxEIn34hgAk4KpNzezymKdZqmD27/XET64g41LD1l0kAGEaz1Tq5FFJ59Gxm
         BrbgAHkJ6Dd+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64210C4166E;
        Thu, 16 Nov 2023 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170016662834.17187.9908591495394863462.git-patchwork-summary@kernel.org>
Date:   Thu, 16 Nov 2023 20:30:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=800612
  Lore link: https://lore.kernel.org/r/20231113111249.3982461-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


