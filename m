Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27E6E9663
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDTN4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDTN4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 09:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCA49DE
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 06:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6C1B64926
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 13:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 405C1C433D2;
        Thu, 20 Apr 2023 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681998997;
        bh=K4V8+vLGq70T5G3+kTZmQXvAmhIqwu/CVCQyabkj3QE=;
        h=Subject:From:Date:To:From;
        b=ck5X31VbhD5cBOSocINJpEtCbNc+Zi1zu0Cbx8Axz4g5HleHQmW9QkN5mED+sS32d
         dkGDT5qJUfVguBINwIQKltZgDQR1D0xz6G0gBu8t3Pt0PdvfgVlhi3T64Ft2J7dPkX
         btfj1DDNyLjHwfrCEWBIp2zYJIcN+LSPkNE3O0wFt/3SM4slqKl07i+nFtED4QpFC3
         TgSbaGyF2zeVYJGNXgbOKPxUd0q6rXEw2YwGRt34Q4RUakp7ksCvS4i9/GYD5s2VzZ
         tpXHeLYptjP+ihg74ukd4cL39ytcMZLaW7o/RhNkSqKjXIt6lMI8Rsk8OI4G+wExzL
         ooLQdKPDughcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2477FE3309F;
        Thu, 20 Apr 2023 13:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168199899714.15151.5491540453347910485.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Apr 2023 13:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: Add DMA mode support to spi-qcom-qspi (2023-04-20T13:13:09)
  Superseding: [v3] spi: Add DMA mode support to spi-qcom-qspi (2023-04-14T14:05:52):
    [v3,1/3] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
    [v3,2/3] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
    [v3,3/3] spi: spi-qcom-qspi: Add DMA mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

