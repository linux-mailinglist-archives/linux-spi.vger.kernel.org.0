Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3A6A726A
	for <lists+linux-spi@lfdr.de>; Wed,  1 Mar 2023 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCAR4U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Mar 2023 12:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAR4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Mar 2023 12:56:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133E48E22
        for <linux-spi@vger.kernel.org>; Wed,  1 Mar 2023 09:56:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9B5EB810C5
        for <linux-spi@vger.kernel.org>; Wed,  1 Mar 2023 17:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BF94C433D2;
        Wed,  1 Mar 2023 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693376;
        bh=rTJid9APTqyYZE0rB9UYf9MdzQ0opboqnJOP8o5js4w=;
        h=Subject:From:Date:To:From;
        b=ahITEFa+bn3X8wWekyn404LNEWVAJ6fQrvoHvv2nFrQDly3ga07ow27d4kcOb5AA5
         mngOcc/lBcC9WuKZCk9mWpjnajHe7ZliIcWnz8tjZFKyoVugPTLi5o5INqevx9j9+t
         MG5ENpZh06aOU2DcAb3gGwiIKBW9ZL6ZTSrgcz3EBTUTLx5sq/RR3CAE5jqgvXKz8n
         dyU4HjE2bshWmLn60Lharkbgzbuf3xxmd+7YCGlfTjBXfMn8eByI1Gbi+bmJFfblW+
         W58/CW6zMwDJufWz9yKmmygrU1U6pYr6k8p4vEW1HFkkTP5dnXEn3ya8ovJ6ugtkWA
         HgBMjjDPC31fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83949C41676;
        Wed,  1 Mar 2023 17:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167769337652.5532.11082441383461875389.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 01 Mar 2023 17:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Tegra TPM driver with HW flow control (2023-03-01T17:33:50)
  Superseding: [v6] Tegra TPM driver with HW flow control (2023-02-27T17:21:05):
    [V6,1/3] spi: Add TPM HW flow flag
    [V6,2/3] tpm_tis-spi: Support hardware wait polling
    [V6,3/3] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

