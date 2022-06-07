Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0D53FE12
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiFGL4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiFGL4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 07:56:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE1B5265
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 04:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E08B81F41
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 11:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DF90C385A5;
        Tue,  7 Jun 2022 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654602992;
        bh=0cWKmndAPw2SlQCL238Q2uA3/zbjr2Fzt+/GLq4eVbg=;
        h=Subject:From:Date:To:From;
        b=VN/jksjvzBIYbXCdwvObxRsw4q9xbhdvDHp2Hhkxs0KBRIwUsNlzarXBVqMcQsUDO
         bJ6V22p+74R4Yk+QUf36DEr/pc9u7ZiYEmLnHI86JrblIeZ2ZBX2fAi7lmD8tL1T61
         75q6p1ZFB9GqlyvA1B3fHir16yiFeSLB7eKiF1cHOOT/DWqyhTTr1sFIuKsdbySaWg
         lETatyFNI+/Nkvdrq0jcuR4YgnrUf407GhEx6ubkbJWLNqX5qkKl9mmW+EBz7stpR9
         aRX5d9Ls99qnP+glwZb02D11z+g23CisL6w01NR1UrK76W+jE8Rf6bVMdW/bcXZdRZ
         9nGZ0gt5riuvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E84C3E737E8;
        Tue,  7 Jun 2022 11:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165460299194.5961.5431094871922574323.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 07 Jun 2022 11:56:31 +0000
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

Latest series: [v3] spi: tegra quad: Add Tegra Grace features (2022-06-07T11:46:56)
  Superseding: [v2] spi: tegra quad: Add Tegra Grace features (2022-05-13T08:08:25):
    [V2,1/3] spi: tegra210-quad: Multi-cs support
    [V2,2/3] spi: dt-bindings: split peripheral prods
    [V2,3/3] spi: dt-bindings: Add compatible for Tegra241 QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

