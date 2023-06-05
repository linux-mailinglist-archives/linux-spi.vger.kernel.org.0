Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD9722A18
	for <lists+linux-spi@lfdr.de>; Mon,  5 Jun 2023 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFEPAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Jun 2023 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFEPAV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Jun 2023 11:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56388F
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 08:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8012C62355
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 15:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA7CBC433D2;
        Mon,  5 Jun 2023 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685977219;
        bh=OZnqLU7H5iG5oUi5lxQTv1eEnvdO+zEJYq/SlLA8BW4=;
        h=Subject:From:Date:To:From;
        b=RbkrGw9eIMHkXzQ5jxgnLQrSiZAI2e051ZVM6DNtVsrP3/hZxrHBcxNy0hxY16mqT
         Kg2NJ7f3yIZTD55Bs9O1dWjmqRdEQHFM6+T2bk4nu7fEjlBNYwgN+Cz/9lFH0/fZzN
         l15iaQ7wRE1hhAJSOIH8eQPvRr4O3ECOekuAPhMBwBMiGak22bwp5IdjhnJxxZg1H2
         FuvLxJUGV6NYaYhaIrbKRWFgn6PDDgAJ32TI8p+80geul3ZuzNApeF3FRuNnbfHASO
         PLeHWAQtyzvO2zTZBA4JCbyFp4xoSkkYuwtwKT4CmpIlf06sRj6fxGPibUWcXEp62l
         BcTzBq7Sz2/Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADA38E87231;
        Mon,  5 Jun 2023 15:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168597721962.12010.301816326895218952.git-patchwork-summary@kernel.org>
Date:   Mon, 05 Jun 2023 15:00:19 +0000
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

Patch: [v2] spi: spl022: Probe defer is no error
  Submitter: Mårten Lindahl <marten.lindahl@axis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=753630
  Lore link: https://lore.kernel.org/r/20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


