Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B6615E7B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKBI5J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 04:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKBI5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 04:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5301D66F
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 01:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0DB6183D
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 08:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AC3C433D6;
        Wed,  2 Nov 2022 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667379416;
        bh=JuqeC9qtbaqeuFplPdotJjCKCjGh1i010CJhWhocG4U=;
        h=Subject:From:Date:To:From;
        b=SAUFZxj/dHTvDcdCeM8p5AIYS/NfqaItVajL1HmKEMJMHwO287GQa53GLM1OMRv7M
         IZOt+tVwUpLWrmQC9fRFlXzmwxH77RUNuvuogwvbssvFdViqgs1C+9ejXvnFB74cue
         Rqnt/3hveVzLk9UqukjRr6lFYWu7aqIt+qV1bNey9isypoWFW7ReDETuaX5ry3JKVP
         gf2ucTtTgwBi6qrV7wBYOg1zrMgiaK4cVNS4uyu4S9VQzx/EPm1TOfEU3ooaCook02
         CZNsi+ixjx7i++/Quy2wG2bdtJADsJqYpvspxGiXsCUGFqVaQKR+eDGAvByoQQavva
         1SiQiwPnlXp+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F90AC395FF;
        Wed,  2 Nov 2022 08:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166737941611.23852.4704726880256962724.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 02 Nov 2022 08:56:56 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: meson-spicc: fix do_div build error on non-arm64 (2022-11-02T08:46:01)
  Superseding: [v1] spi: meson-spicc: fix do_div build error on non-arm64 (2022-10-27T12:11:43):
    spi: meson-spicc: fix do_div build error on non-arm64


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

