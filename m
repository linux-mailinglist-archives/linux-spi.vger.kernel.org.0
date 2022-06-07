Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877453FC22
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiFGKuv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiFGKuX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 06:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA5FE2
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 03:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E577B81EF1
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 10:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 063EDC34114;
        Tue,  7 Jun 2022 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599019;
        bh=8/VtgvqfFI45YCxtneyNR9C6svxBWev0YzgUZH6P5+k=;
        h=Subject:From:Date:To:From;
        b=Skswb4l0KqLDfCQ4YvsZ7IvzyE/x9IyawmhbCpS8akA9Lk1SI2IKeLVy1pKhzZaAH
         PL+iyLTohZtc9PIscKX2y3K/tFCrvMRJKaFULqgfNadvI06qvmionDb2NsYxYjQoeE
         G0reDFZy2qHmj1DoW8R3g77zInFPKdZJFSmDGuT6Ik8d/e61XH7Y5oYY7LsM5TmmsO
         vQ4EQ4BO0vmkGBNhpWjpsZtYarWDdnJdws/klL5v2KAPxuGrYwl3RxG9KhRxbvzCXo
         rwiLqpN/ylrZ6H4Bn7umVWGAqQ7onA5my2+Ec9kPsMe3R/mhFXk8JoIjIKEt6IezFT
         p8kqyhtTibj+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4330E737E8;
        Tue,  7 Jun 2022 10:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165459901881.32109.8004497514950938745.git-patchwork-summary@kernel.org>
Date:   Tue, 07 Jun 2022 10:50:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: stm32-qspi: Remove unused parameters
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=646821
  Lore link: https://lore.kernel.org/r/20220602092540.369604-1-patrice.chotard@foss.st.com
    Patches: [v2,1/3] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
             [v2,2/3] spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


