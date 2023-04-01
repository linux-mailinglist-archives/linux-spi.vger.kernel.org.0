Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4464D6D2FC3
	for <lists+linux-spi@lfdr.de>; Sat,  1 Apr 2023 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDAK4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 1 Apr 2023 06:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDAK4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 1 Apr 2023 06:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F8DA24B
        for <linux-spi@vger.kernel.org>; Sat,  1 Apr 2023 03:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129AB60CF5
        for <linux-spi@vger.kernel.org>; Sat,  1 Apr 2023 10:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 584F4C433D2;
        Sat,  1 Apr 2023 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680346597;
        bh=efLsr6qXjj1AbPs6dXdE1LrFiBkhVjSUMCYxPKtsUiU=;
        h=Subject:From:Date:To:From;
        b=ekOa1p/2dVRfcpN8C5NIRnvbEz7NNQo5zQAcRLZO+zuHwmhNaXuf3490EHqd7W8R2
         5lBDmrGa7aPKlx2Yp67Ac/JS30nnETab7S+HT2xJDGbu8WI6v6tEZOxrQweRqRjTXV
         ngV0GYcBHzleqZnkmfrEKiF3dm8NMRrBEoHOcFY4q4Pe4i2n8UZRogDeT4jn+19zjc
         4r+OC3OGGvI814kiPK2JiUUJ591BC2EEo3WMu3jD7kfYyfrR8dY2rQnqUMX5/pMLSv
         z06TcgJDXyyDDimeApnm+CtRKzfWGx3DDsBfu2qj+47UtUnpLWOvqngxoYVDzVS2Xc
         tMNyeBHDyVPHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 352F7C395C3;
        Sat,  1 Apr 2023 10:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168034659713.12358.14655765483476519568.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 01 Apr 2023 10:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: loongson: add bus driver for the loongson spi (2023-04-01T09:56:51)
  Superseding: [v5] spi: loongson: add bus driver for the loongson spi (2023-03-31T03:29:07):
    [v5,1/2] dt-bindings: spi: add loongson spi
    [v5,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

