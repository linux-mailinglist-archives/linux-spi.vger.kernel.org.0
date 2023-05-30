Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D4716D8D
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjE3TaV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjE3TaV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 15:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A34EF9
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 12:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00B5662EE6
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 19:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D530C433EF;
        Tue, 30 May 2023 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685475019;
        bh=RuhS9vxZ16bXH2kHU0vofO1K+onNeMToc/PAwnnjvQ4=;
        h=Subject:From:Date:To:From;
        b=E3eFxbTEDFCSu4AHqY14HkJT2Ayl5Vlw/ayP0XR47VU0yo4xCQyMVMfj7eZ01iUcW
         hn7qEUGa2BCm0Oe/NT9C99HvnZLuJ/yur1+LeFJ8dFLTz9y2bT2OaeWcieiBhwL0SM
         1n72MXhvsU9YPY1UC1pBwxFUDZ5k/LCQc2uwW2Ti1FXzBmcIU534u2IyhW4NswpvSk
         1eUtNpTRq6Dt5VIedWlTpeScpOumInSJjz6P6RReCHyDiKU6HUYnUO4u8Yob6EMvpY
         8MsjWJJXjvDEa2G9prYbTHU8+is+RviDzvVp28scmy45WaSK5iGgLDXYG3ppAvLfl3
         sGfiWRZHG3apQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 398A8E52BF5;
        Tue, 30 May 2023 19:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168547501915.11706.15034478559601856983.git-patchwork-summary@kernel.org>
Date:   Tue, 30 May 2023 19:30:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: spi: spi-qcom-qspi: Add newline to PIO fallback warning
  Submitter: Douglas Anderson <dianders@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752412
  Lore link: https://lore.kernel.org/r/20230530111348.1.Ibd1f4827e18a26dc802cd6e5ac300d83dc1bc41c@changeid


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


