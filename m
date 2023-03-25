Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C506C904E
	for <lists+linux-spi@lfdr.de>; Sat, 25 Mar 2023 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCYS6Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Mar 2023 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYS6X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Mar 2023 14:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF4AF3B
        for <linux-spi@vger.kernel.org>; Sat, 25 Mar 2023 11:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2ACAB802BE
        for <linux-spi@vger.kernel.org>; Sat, 25 Mar 2023 18:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56CF3C433D2;
        Sat, 25 Mar 2023 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679770607;
        bh=fB1DnQsDkiuwdihwpqb4p3bhLSrBavtH7dvRLMUlUM8=;
        h=Subject:From:Date:To:From;
        b=szoeJXAkPPLotOekP8Ybc6wPhRVMhs5HiBuKhRfXI6odSkiU7qk8zPujfUdXTXO26
         +t0o60MvGWzLsU8tQ6YOm8KYHTwoYiFqDgK8+d7aAYn2tYoS3gcY4uuLV7QjHXNMyh
         AVNS/V52px6lmOeU7ijqm48QnHS0RDlT4q/OLUAQzU7VJzzP9SfVf4GTy8S1r2qKCR
         Hg3Pa31SOXxIj1JoKTI+jdksl28KY02FxiM34QgR3qE/nJ/FfCT2wXMGUouQtK9/Yz
         zGOX5twemz+gRdOKhwEFU+4gTeMuJgoX3Pti3lmGWtmYxL1XPyDCAqjpKiQl3tWhvf
         Qod6KXxFZPYlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28C77E4D021;
        Sat, 25 Mar 2023 18:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167977060698.2260.738219082361718758.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 25 Mar 2023 18:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] Tegra TPM driver with HW flow control (2023-03-25T18:34:06)
  Superseding: [v8] Tegra TPM driver with HW flow control (2023-03-02T04:18:02):
    [V8,1/3] spi: Add TPM HW flow flag
    [V8,2/3] tpm_tis-spi: Add hardware wait polling
    [V8,3/3] spi: tegra210-quad: Enable TPM wait polling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

