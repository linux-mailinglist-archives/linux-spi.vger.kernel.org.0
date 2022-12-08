Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855ED64724E
	for <lists+linux-spi@lfdr.de>; Thu,  8 Dec 2022 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHO43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Dec 2022 09:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLHO42 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Dec 2022 09:56:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE48C69C
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 06:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9ED3B82407
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 14:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA1EC433C1;
        Thu,  8 Dec 2022 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670511385;
        bh=0hW7fDl4wblLP5n7smcDrs81KIgz6N2+rhm8d8VL0Zo=;
        h=Subject:From:Date:To:From;
        b=CjoI8IXkeXTK6ecyhqeIgLbyhMPFlXykVgnqyaYDJMytn5TlyEAa/K5Oy23mAVAxR
         prmGnZwG1OXVYbgU5+oGE72JO7GQ/g6wqC2uR2Wy346mxiesTWdw63NcMu6CgXNKEj
         1o9O0eizH8J+OthhgVdEF8tpyCvTiNJ6sMH22qIbjJnWQrO4W5t9xPahSebBxAYyo+
         G8XMnAIo0OAGX1YdvZup582QVIRKcJLHbhvSdhzKSvL6gskFW7U0EfYnloiLQ7lQbS
         NUcAVefj1o9BW0EcKPgJyiQ9xbQPVKK7fbfl7BjJ0idgKc6dxQ5HkCADmLzJ9DMiwJ
         MaqEk953kcJkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F3DEE29F4F;
        Thu,  8 Dec 2022 14:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167051138538.6814.216240176746375869.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 08 Dec 2022 14:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-geni-qcom: Add support for SE DMA mode (2022-12-08T14:25:44)
  Superseding: [v3] spi: spi-geni-qcom: Add support for SE DMA mode (2022-11-29T09:23:34):
    [V3] spi: spi-geni-qcom: Add support for SE DMA mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

