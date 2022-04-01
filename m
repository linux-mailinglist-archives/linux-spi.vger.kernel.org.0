Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56A64EE963
	for <lists+linux-spi@lfdr.de>; Fri,  1 Apr 2022 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbiDAH6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Apr 2022 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344067AbiDAH6N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Apr 2022 03:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153351B7629
        for <linux-spi@vger.kernel.org>; Fri,  1 Apr 2022 00:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F18560B21
        for <linux-spi@vger.kernel.org>; Fri,  1 Apr 2022 07:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8B38C2BBE4;
        Fri,  1 Apr 2022 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648799783;
        bh=505NyzZf5b3F9lKq63PHdTgUExb0LD1hork4MfywsCE=;
        h=Subject:From:Date:To:From;
        b=qF09q9OFbgZzqfHhHPmqwuWjggfheGb1GwmZvXRgbU7v5nUz29RHEfnFh0wZ0p1Bv
         kSbDgSr5dZ/r3u4LoT4hED3aOJiWblH48zg1jlWJnEyTNIATB8mmP+7gRERveblMuo
         firdcBtitls7rmfJYahNYHZFyu1bLeL2xf1iwBeyo1GoSS/fTlD3Elx721Iqiv7bUR
         BoFlzzavIPUtkwwt2vubn2M6UzneF+V0I4QmLBYk+BLUazi4VS3TqRFfqNL+XRz9cW
         L+UA7OO4WHRjsMkxMiOo90mEim5Kz8JG6kkccw3Jsw+xVppDrmPYdGhOVDZMybWfgG
         KofiTlryrPOmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2133EAC081;
        Fri,  1 Apr 2022 07:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164879978385.6259.16249570235222223673.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 01 Apr 2022 07:56:23 +0000
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

Latest series: [v7] spi: mediatek: add single/quad mode support (2022-04-01T07:16:13)
  Superseding: [v6] spi: mediatek: add single/quad mode support (2022-03-21T01:39:21):
    [V6,1/3] spi: mediatek: add spi memory support for ipm design
    [V6,2/3] dt-bindings: spi: support hclk
    [V6,3/3] spi: mediatek: support hclk


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

