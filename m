Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1879508679
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiDTK7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiDTK7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 06:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE227FF8
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 03:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06F66187A
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 10:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52E5EC385A0;
        Wed, 20 Apr 2022 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650452189;
        bh=REIyfKDJ3OB0qeyM9WkXWsRuDpa1mFxnd4MpT4syZas=;
        h=Subject:From:Date:To:From;
        b=nHhsAcEkCUvGCGpXAw2ecDcyfwuxM4iXPUtyE6Ivy3GNwQhVAZkujxGXBSOpeAFlb
         K5huVijKxnUI26iLXbp4yZMeHRaaFyVrC/ypOUK/RVrWdg18B/TvmBjFpIYdatOrYf
         qJFIUVapoduVZPMfwT2YWfWFYkWTepmPdnhlJ3gnDbZQTvxZMiB2rqBk5MZr53y+td
         svdIEsIu4eet0Nv6Gkv58pX8/Goqz2QViws+enFEfYtT5Azu4tcjm4a5XwaMIv+A42
         fdhshsoMIEF+G8QGDTKojktxDd4x1rTZ9sKgEyuA73LwoLHnepqkFf/fiphinBTXss
         TBFJ+3zAoR5Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 280E2E7399D;
        Wed, 20 Apr 2022 10:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165045218910.31851.2692861662862587952.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Apr 2022 10:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mem: check if data buffers are on stack (2022-04-20T10:20:22)
  Superseding: [v1] spi: spi-mem: check if data buffers are on stack (2022-01-31T11:45:08):
    spi: spi-mem: check if data buffers are on stack


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

