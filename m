Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DC57BD74
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiGTSKX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiGTSKS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 14:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83AE0F0
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 11:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C73AB821A3
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 984EAC3411E;
        Wed, 20 Jul 2022 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658340614;
        bh=RMGF6ANZA8sLAapscbx7a9xYepvPz9az/C3v3CuT3Dc=;
        h=Subject:From:Date:To:From;
        b=HsDu51/rODFz4aCeY4g3ojCu96JaHGLx8blkl/26cco5scE+NXAlmEc2m2aNVWOqu
         DYqtCnlVHl0v5zZMMx5a9ry+Awpi5Gx3dSt47dJnoWcMP9eWz/EPGuhqBvePMcIyqA
         DTY0VtE8SX+SNowyckVVTAOR7oupyQE3bN4ATFrzWBe1RkhpsBMHX3PSZi8cCRbaQ+
         sypHd6e/Fl4ysQ0XrnKkGKB4CMJLnVTn9cpol0DhdokrYUxBwUJL9Fs/O4n5oLH7hU
         P1TCztIvUV+Y3l/kO2ID0ZRzz5NfT5B0LiybIRbRRbgliGnPfCb0qoU6cs8t+a8HpL
         fwkwqYfhvBguQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75BB9D9DDDD;
        Wed, 20 Jul 2022 18:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165834061447.3445.14457735708059982224.git-patchwork-summary@kernel.org>
Date:   Wed, 20 Jul 2022 18:10:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [RESEND,v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=661531
  Lore link: https://lore.kernel.org/r/20220720163841.7283-1-krzysztof.kozlowski@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


