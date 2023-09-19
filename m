Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904687A5D19
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjISI4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Sep 2023 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISI4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 04:56:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F8E6
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 01:56:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2391C433C7;
        Tue, 19 Sep 2023 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113801;
        bh=c/KpyR2zPkZ+AUKFyKIXVOGEB6dyyjnsOHi9uJKy6gA=;
        h=Subject:From:Date:To:From;
        b=gEkWgYtLOcDWKss/8e1JMKdAKnrEHuCkTFoEaZEaKEHw6nt7TPDI8XguslA5FeMcR
         TYzvKHSgLlf4fvRRlHlAAcBtgTJ+VpAP4DYrPw1auI7DKF8unShpcmtl915UK20f9y
         LMTIfSCvK3NfRH/+Zwl365QRWT1MiJzbCDL4IRN2Nbhl7zpZwx29vEwlpB7f8+naz9
         W1y8x+q8oYNaE2JVIIZudi3DTzalO8z5kHxmuZzzzDjEVl6AbXqJas7nzOIJ80EzFC
         m2jDI0sqliGHkkLHFKOIMhYA8B9kqSvytQspjqPKAibjihAJw/0hkzr3RG8p5kMP/+
         dX4h+Cddth2Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5F0AE11F41;
        Tue, 19 Sep 2023 08:56:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169511380173.1763.7237446626992929786.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 Sep 2023 08:56:41 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: zynqmp-gqspi: fix clock imbalance on probe failure (2023-09-19T08:34:01)
  Superseding: [v1] spi: zynqmp-gqspi: fix clock imbalance on probe failure (2023-06-22T08:24:35):
    spi: zynqmp-gqspi: fix clock imbalance on probe failure


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

