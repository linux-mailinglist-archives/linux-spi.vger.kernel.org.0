Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA0790CD4
	for <lists+linux-spi@lfdr.de>; Sun,  3 Sep 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbjICP5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Sep 2023 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjICP5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Sep 2023 11:57:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA1E3
        for <linux-spi@vger.kernel.org>; Sun,  3 Sep 2023 08:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 774D6CE0ADF
        for <linux-spi@vger.kernel.org>; Sun,  3 Sep 2023 15:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A12EDC433C8;
        Sun,  3 Sep 2023 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693756614;
        bh=xMoXQB8lPRx9d+9t1KGieRrzjlgeXjXPPNxTUDxk3cc=;
        h=Subject:From:Date:To:From;
        b=Tefg+Eg+w0YivXxRp1TTvYFsR6QI65jjD1mtUoBwS/aDFz1ScquQ1+Wp52zwzodlf
         kbzM1j85LpxIsy+mBpVu02XcJ3VITAQyoD0/xN1Ph9xOqnTNpLb+uQH8TmjCo0PIdU
         6E9uSqdAKjm+7bFT6gEO0ILMRYmANfVDaEDUN5E2Y8Y8gQZn0Gjg0diF27/qTITnGa
         wD6yvVE7JzDjiNI5H49yJ9R18DbbXMQQaMkan1AmBvFsQZKxFy8XsEoTgVJxSVvE12
         LhxwC9HVzeFJEJdz2pQIIzGbUpKbgXS/+yyCnjXAb290TdIsHmIo7TDIiaA8xPADZL
         xzOjyBNjdNFTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80A28C64457;
        Sun,  3 Sep 2023 15:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169375661451.27538.5338369364341458415.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 03 Sep 2023 15:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-09-03T15:37:20)
  Superseding: [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-08-13T14:12:07):
    [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

