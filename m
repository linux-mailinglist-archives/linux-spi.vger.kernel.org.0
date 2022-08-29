Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C545A574C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Aug 2022 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH2W4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Aug 2022 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiH2W4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Aug 2022 18:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5248672C
        for <linux-spi@vger.kernel.org>; Mon, 29 Aug 2022 15:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD00961320
        for <linux-spi@vger.kernel.org>; Mon, 29 Aug 2022 22:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46D5BC433C1;
        Mon, 29 Aug 2022 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661813806;
        bh=W0omjILV698wJyTxBnjlCcUHqNTqlb9z3oyngZnjLMU=;
        h=Subject:From:Date:To:From;
        b=PB6csv55cvbZ3Yy39RBJvIZukLmaHIZC/LAzw4sHbWNCBIpevEj3QhrT10oQVB7Do
         2n89NUgqnlPY0XequGyQVlJLVxDie/RIar9To6xVwJWcIAZi0Yb53LUIWbiV0vITeV
         deBJweiLIj30NCFjTPr5rRjFUQ4w7J6xER5ejpNhH5q1K62Guwug8dMVkRqxlY91jF
         oBpxg0qkBNI5O70zCuNU6PvgWWZJHHFws0Tq+brQ5xSi9ENnOHvVRPrW/yvNFmAt0c
         5nRGo3Y74DOh3iQPvr4QZoLp3h3gg4axVy5RoS1KGh9qHa+Ih7ZQlQfpN4Hdt+K6Dc
         qgE9/N3IqJxzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AC08C4166F;
        Mon, 29 Aug 2022 22:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166181380616.12295.2447825628618468471.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 29 Aug 2022 22:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings (2022-08-29T22:03:34)
  Superseding: [v1] dt-bindings: spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings (2022-08-16T08:38:42):
    dt-bindings: spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

