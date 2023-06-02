Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC371FCD4
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjFBI5q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjFBI5N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 04:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADAF10D9
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 01:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F87A64D8F
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 08:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2054C433D2;
        Fri,  2 Jun 2023 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685696206;
        bh=W8CLGflAO0FS2nlnKXu6/7kVMWha2sO1pJuPJefNh1s=;
        h=Subject:From:Date:To:From;
        b=DPceL373ZKrP/5n2TKcScs4dm74XRvULjdr1AeGA+fPvq684vvKm9Vz9v7Ks+LCa+
         MDz2NzkJkrHFdJkCCBc2B9X9oeadkXpUHwxRUA1PUMgbtGvuzGxa1YwJGMJ1PATGza
         5fV3PobEYqccOxYr2071VTXOJCYQyzDzV4g1/h0H5KaCexDopdX2WewU1jhDYFh+X2
         iZdDAmPLNwDnUHcWW3w2S6/TYPMvDnhvQgZ/qoc3IoHL3ghM5GRT/8scle7f5lJHvw
         6fYZ+E5lZcG6fOcHgOcztgcJhVk8pTvqvq5ZvmFhkW/0tX3KJT0rlRVhWRr5tnBRIR
         1Kp3OJTG8IgKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCBD8C395E0;
        Fri,  2 Jun 2023 08:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168569620683.32626.11855679106683423915.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 02 Jun 2023 08:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add initialization of clock for StarFive JH7110 SoC (2023-06-02T08:49:23)
  Superseding: [v1] Add initialization of clock for StarFive JH7110 SoC (2023-05-26T06:25:29):
    [v1,1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
    [v1,2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
    [v1,3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

