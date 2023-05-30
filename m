Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C371592B
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE3I4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjE3I4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 04:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5ABE
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 01:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A3B62138
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 08:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 088E9C433EF;
        Tue, 30 May 2023 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685437008;
        bh=niCkOZ+zVzqk/Qj4U7tdiHC6xbYyHFD+g3vTErXCf2Q=;
        h=Subject:From:Date:To:From;
        b=FL6tSm/al0RwO58lKGZWE4M8AdOJiA4iYEwW0lhSv+/eJhl4E4Q037t3VfvwDUx7Y
         h/qTXJ1TVLrraSY85U+drkQgHD1fjF38seECEBXZlMTluBmB9fcwe4Pg3oDOD/Ldrd
         Rb7w/MMER21C1GOXQJTP8zx6Xife1U+RaiDF3yQ9otx6+ZUBQY7GUDYDK7+IPgLhg9
         cBvRWMCtx6ZfDZHBqj1OYv54S+zP56fXdsr4llmZvLeWY/ltABc9Qe5xC7b15SZk3p
         dVae9oPXA8nGYjuiA2YtaAVVIVFJ5TxDDYxjehaJsNjX9uSZUdbc7nydzZi6wbdkLI
         0MshSC8uNR+KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E28ADE52BFB;
        Tue, 30 May 2023 08:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168543700792.20434.12430501036316747155.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 30 May 2023 08:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: mt65xx: Convert to platform remove callback returning void (2023-05-30T08:16:45)
  Superseding: [v1] spi: mt65xx: Convert to platform remove callback returning void (2023-03-09T09:47:03):
    [1/3] spi: mt65xx: Properly handle failures in .remove()
    [2/3] spi: mt65xx: Convert to platform remove callback returning void
    [3/3] spi: mt65xx: Don't disguise a "return 0" as "return ret"


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

