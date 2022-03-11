Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6CA4D5DF3
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 09:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiCKI5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Mar 2022 03:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiCKI5e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Mar 2022 03:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA71BB708
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 00:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A9A61E91
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 08:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62A9DC340E9;
        Fri, 11 Mar 2022 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646988991;
        bh=7VVXPi+jmTWGizhIrdusAH4k4Wp3ypH8EjWKhE9udHg=;
        h=Subject:From:Date:To:From;
        b=QV/HoIH/wDmmd7uFpxnjZflXzcCDMBGYzHTKYI6EGEvNK1lFs3x+EyCSnW8vjJrgL
         6NG8j+fap9eG8ssewt8ZmhMT202mEQbRsf1l0PfRRTUSIcp+K3anszXvdS1wXrWbhy
         iEmqdUlyTr4vRNf21y+lyvaxNnM4bKLdi93ddk+27RDQ+ATvSMxocOmQY0ZEVKXxYC
         nZZNEYpjaSVUgNgNan6HtVGiVEOL2mYt6kLwHi7co4raHXtamQiKDTtR/rDvPPc4jh
         mXlZKfJCXpDQB+nD61Dxdam5MEmSANMUfkNxpqbqw17C82Q1gl2qReZGe04MtsaPNE
         ycK7cTyQ7AI2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 476BCE6D3DD;
        Fri, 11 Mar 2022 08:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164698899128.14005.13773709169561306551.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Mar 2022 08:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi-mem: Allow specifying the byte order in DTR mode (2022-03-11T08:01:41)
  Superseding: [v1] spi-mem: Allow specifying the byte order in DTR mode (2022-02-18T14:58:59):
    [1/4] spi: spi-mem: Allow specifying the byte order in DTR mode
    [2/4] mtd: spi-nor: core: Allow specifying the byte order in DTR mode
    [3/4] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
    [4/4] mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16 no_sfdp_flag


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

