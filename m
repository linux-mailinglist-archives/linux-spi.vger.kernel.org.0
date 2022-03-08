Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554124D2244
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 21:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiCHULM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 15:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiCHULM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 15:11:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BF3BFAE
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 12:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035A8617A0
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C6F2C340EB;
        Tue,  8 Mar 2022 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646770214;
        bh=sGuV5NtZ8szg8dL/Dy9IcB0rlkCLnjgIo3LUKrjZncI=;
        h=Subject:From:Date:To:From;
        b=T0g17/Ft+Tao7k+zcH/Jrf65dsIoRaCowUX6Bib23bhhRtut9nk4B5V/a5xl4s+0J
         xCLgG7MbWhx4b1j7vskqi4uoGzS0YDfPr7fVJ4XxaskDHgylxESZPoIFg1p9gHePvH
         WIWGldBeex2bhAQ3E7y338zQFnoSu31jWS/Dffp6RVpXJGw2Q5LMxcfdd0+yrJBGWI
         08AiW6p1tiBss0dvlplirofpvoB3LGAEMUj9N29XZlsTHgsVeAsM0YdJ2EE6ENqDBf
         v/Pulwlv8CN1xAgfAfT+8DtetMVdQhHZ5hpNuvJEWXqtUJdLLUJdurdx17d0A84Eyp
         P259lYtshLgrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52752E6D3DE;
        Tue,  8 Mar 2022 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164677021428.8983.8436225988230824788.git-patchwork-summary@kernel.org>
Date:   Tue, 08 Mar 2022 20:10:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: dt-bindings: samsung: convert to dtschema
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
  Committer: Lee Jones <lee.jones@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=607751
  Lore link: https://lore.kernel.org/r/20220124082347.32747-1-krzysztof.kozlowski@canonical.com
    Patches: [v6,1/4] spi: dt-bindings: samsung: convert to dtschema
             [v6,4/4] spi: s3c64xx: allow controller-data to be optional

Patch: None
  Submitter: Alim Akhtar <alim.akhtar@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=605199
  Lore link: https://lore.kernel.org/r/20220113121143.22280-19-alim.akhtar@samsung.com

Series: [RESEND,v3,1/2] spi: dt-bindings: samsung: Add fsd spi compatible
  Submitter: Alim Akhtar <alim.akhtar@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=621466
  Lore link: https://lore.kernel.org/r/20220308121640.27344-1-alim.akhtar@samsung.com
    Patches: [RESEND,v3,1/2] spi: dt-bindings: samsung: Add fsd spi compatible
             [RESEND,v3,2/2] spi: s3c64xx: Add spi port configuration for Tesla FSD SoC


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


