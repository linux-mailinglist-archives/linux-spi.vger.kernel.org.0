Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417DF6A1F07
	for <lists+linux-spi@lfdr.de>; Fri, 24 Feb 2023 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBXP4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Feb 2023 10:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBXP4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Feb 2023 10:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43C6ADE4
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 07:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973146191A
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 15:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA6BC433D2;
        Fri, 24 Feb 2023 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677254179;
        bh=YPw+JIsaE5sSeadLXcuzDTDru3lBqfKbaoIMDqFLtuA=;
        h=Subject:From:Date:To:From;
        b=dMPwhmr6e03M4k/VdUD+b0Hq/rrVDb5rCZ+m5xQ12GWs3E70NvM+LPfeDg8IPtvOQ
         uiEm4KhZL9yZAtT4RS2AAuKxK0cWYeK1xEKzdpJSPK4EXFOl0eVOQ3maesgsdzW5zI
         k5WNZuHuLJCsCAA1eMxmr/r4j5FBDxMSARZwF+4oDdMmtAcQG8u7h29OndLDfMm1Gc
         o/CKxFJUgb1tyl4JXYpSqGCaVLknRO6ylZhAhoV838WT3phZPbzokzPFbJced2OGwB
         GmCbu24FDYPTr5sJ1r7lU+X0xhl/2obPNVZK1jfoVbxpj8mFZvP367BsfXAhwOADlK
         eHCEpvgrFPIbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6F8EE68D37;
        Fri, 24 Feb 2023 15:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167725417887.9444.6065854778156547074.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Feb 2023 15:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Tegra TPM driver with HW flow control (2023-02-24T15:49:38)
  Superseding: [v3] Tegra TPM driver with HW flow control (2023-02-23T16:26:32):
    [V3,1/3] tpm_tis-spi: Support hardware wait polling
    [V3,2/3] spi: tegra210-quad: set half duplex flag
    [V3,3/3] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

