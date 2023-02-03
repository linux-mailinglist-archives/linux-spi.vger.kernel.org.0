Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EC689AC9
	for <lists+linux-spi@lfdr.de>; Fri,  3 Feb 2023 15:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjBCOBJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Feb 2023 09:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjBCOAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Feb 2023 09:00:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB0293AF4
        for <linux-spi@vger.kernel.org>; Fri,  3 Feb 2023 05:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813A161F20
        for <linux-spi@vger.kernel.org>; Fri,  3 Feb 2023 13:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC556C433D2;
        Fri,  3 Feb 2023 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675432583;
        bh=hdZd/xoQ9biC08ASMyDZYahpmMUwz0NZAzj/sQ1r0wE=;
        h=Subject:From:Date:To:From;
        b=fdqIYdgCl/pMQGl9+xJOa9tHTSaKCtkTKUcjTHcg/FZSrR2UVWw0i++ePyg6LkgTa
         MKp+mNlRdk7xvyHIls0tFk5MOPqx7fiwt/e6Z0mREPFEwEkeUBqWhLILNDn5wJflcs
         riU27vjsE+ZWygCtR6GMk9ZBhV8tm6j6PvrNyvx5xTjhxE5ASoTONzM324do6DHMV4
         jxpSRaf3WdRguSdnbF4EGUqC+mNoU97GOLP7wLpf2bWCM34nWkz/EImMHi6xd8btwO
         KTl9TgoEUv3FG7hzE3XEkWNovHxJH+jBtfFC04Ex+poYLC/6B8NUbj9Tkv1L3m5852
         suCDcmJJubIYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBF5CE21ED0;
        Fri,  3 Feb 2023 13:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167543258376.27883.15600818386952127367.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 03 Feb 2023 13:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Tegra TPM driver with hw flow control (2023-02-03T13:01:29)
  Superseding: [v1] Tegra TPM driver with hw flow control (2023-02-02T16:17:46):
    [1/4] dt-bindings: tpm: Add compatible for Tegra TPM
    [2/4] tpm: tegra: Support SPI tpm wait state detect
    [3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
    [4/4] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

