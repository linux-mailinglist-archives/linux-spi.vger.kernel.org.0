Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8824C5829
	for <lists+linux-spi@lfdr.de>; Sat, 26 Feb 2022 21:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiBZU5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Feb 2022 15:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBZU47 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 26 Feb 2022 15:56:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1A1B0BD7
        for <linux-spi@vger.kernel.org>; Sat, 26 Feb 2022 12:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0F961022
        for <linux-spi@vger.kernel.org>; Sat, 26 Feb 2022 20:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F9AC340E8;
        Sat, 26 Feb 2022 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645908984;
        bh=SyN0+1IMowPIFJYvAYh/MFfFCtgLs+POJrcRB01SU/Q=;
        h=Subject:From:Date:To:From;
        b=QnxOpdeFp7WirQS5IHmJgb/6c+sbg42itkXhhL2Jbp4VZ7POXI6uTgPMiilNaxeA6
         f33glbe5kH3oTe/P2HCS18sj5FDzZZDh7UuPDwUdHw3jjq9uGRgar9kgW+X9Zu/HYG
         Ri7GLZugJOqiB0ED8483aWl/9cNF6eQRce51inC66qHnZ+Lpkfw1z6I4OpVxJijSyJ
         CUqVA43qPNOfOjqZuoJKZVYaLA37/SonQsjRQoMUEvuYqBtS8zHDgfb2+pInT4s7ST
         UwiGDXEm6CZja9Od2b+3DTMc/fmfsRMGdbLF61jPeu9Z8W+lplrGGJJcuMaA7WcYye
         vTk+uHdp+YhwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D46E9E6D3DE;
        Sat, 26 Feb 2022 20:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164590898378.31715.7074745808928484195.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 26 Feb 2022 20:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: use sysfs_emit() for printing statistics and add trailing newline (2022-02-18T13:58:35)
  Superseding: [v1] spi: use sysfs_emit() for printing statistics and add trailing newline (2022-02-18T12:22:20):
    spi: use sysfs_emit() for printing statistics and add trailing newline


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

