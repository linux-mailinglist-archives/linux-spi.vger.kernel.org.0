Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F878FDDE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349607AbjIAM5T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244786AbjIAM5S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 08:57:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172BD10D3
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 05:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57183CE21FD
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 12:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B90C433C8;
        Fri,  1 Sep 2023 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693573017;
        bh=pdrGKbW6ohQlqq1hKGPpPKTPYXVkwDAQpUjVNWstdGs=;
        h=Subject:From:Date:To:From;
        b=Au6mSxkbfp03hi0afczw88vEt3C+QOgMm+HdHDMKPG49nAob1CkDbjpzmvzjyC46N
         bdjlgjtXouL0fXqbL+VuQnd/U6p5mYtFAm8yWILc8bijFhXxLpFifRZ6QGvlfxvaBu
         G+BPb8a1oiIyeg5bRFixXidre/g0iqva++gDp/30Ij8n9L5XPE9JB6Lid42Z2xpevI
         t5NWdr5WNZrjry2zgxq1vy2bxHZ/6MoomIxD0wHMjG3iZOcYIkX3cgSCvxVa7UeyxH
         5zB4y6bZ96iC/an9zXpwqVW6BQ8lDlt1mpktyYYEbQ8LscXIG3gk07iVIMkTisSPHR
         TblaWKinLoTXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF64C64457;
        Fri,  1 Sep 2023 12:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169357301758.31671.11571232633060131465.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 01 Sep 2023 12:56:57 +0000
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

Latest series: [v2] spi: bcm2835: reduce the abuse of the GPIO API (2023-09-01T11:15:48)
  Superseding: [v1] spi: bcm2835: reduce the abuse of the GPIO API (2023-08-31T19:49:34):
    [RFT] spi: bcm2835: reduce the abuse of the GPIO API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

