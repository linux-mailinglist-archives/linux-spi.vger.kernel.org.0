Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13BF6C7856
	for <lists+linux-spi@lfdr.de>; Fri, 24 Mar 2023 07:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXG4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Mar 2023 02:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXG4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Mar 2023 02:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120631352D
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 23:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D5F62925
        for <linux-spi@vger.kernel.org>; Fri, 24 Mar 2023 06:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EA2DC4339B;
        Fri, 24 Mar 2023 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679641006;
        bh=rngXIfyZ+j3QWRPUWPvDRV01Uw+BIHoXBjo5Rvmoqfw=;
        h=Subject:From:Date:To:From;
        b=g8VTPlSybYLMUTng8sbjtmrFPwvFIKVpk33gO/qpm4qL4MRqjuNoHUmhpea14H/nZ
         cSKSEGO7b6Xx7JjMs4VPFNrCPVffVjKfvfKZjY7MT4Nhl0kO8NpkgCvla+VrCAsidF
         9XtMVeKtvKsJ5Ngv7o2XGAb7ddssQhgNaZA8r4F/jMBx6k4x88gwqvcExc2398Wr2x
         AT0Egj0L+J+lABdEj8MVD0P4ZJWKsVKgLN1OLXxlb3aYNfwuCnj3wm/DmeFQBAim+T
         Jz6ub+2gRJIzyjteaS46PvdC431b17eQA7GYhRE45wt/Hiz93Z7Wf5H0300fTH22kI
         9oKFLaRBiBfyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2D53E2A039;
        Fri, 24 Mar 2023 06:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167964100592.3885.13236574388837763409.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Mar 2023 06:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: loongson: add bus driver for the loongson spi (2023-03-24T06:33:15)
  Superseding: [v2] spi: loongson: add bus driver for the loongson spi (2023-03-17T08:29:49):
    [v2,1/2] dt-bindings: spi: add loongson spi
    [v2,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

