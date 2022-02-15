Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA574B613D
	for <lists+linux-spi@lfdr.de>; Tue, 15 Feb 2022 03:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiBOC4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 21:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBOC4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 21:56:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C263A7
        for <linux-spi@vger.kernel.org>; Mon, 14 Feb 2022 18:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B8DB80E27
        for <linux-spi@vger.kernel.org>; Tue, 15 Feb 2022 02:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0469C340E9;
        Tue, 15 Feb 2022 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644893778;
        bh=EoxWJKKvvzmipku8mYL8JUPOW8Bu9m7qcxfQ1lCfSRU=;
        h=Subject:From:Date:To:From;
        b=X0xqGDAMv/orJNveLfLLJq+lwPM196LZ/LePHCbiFXBPE26z6BAf3gawz3ObVDq3E
         wiTZbeSuZev7DZhCoD2glx+B2GBI/MMCHd5lD8d2W8gOHXAJ48o+ZizLm4iJwyI5/u
         tXvyYC+Xtb2dXondxC1lKRSR3HmBvL2wVW/R3LhyHuSTXqJJH2cXsbbGDvaY7P/fzA
         hqriKLvmfhA8xVYfhnBMuAFl5UFV3BTvM+8H12raH2qxHrq6NRVYDYa9/0yR4uL4BT
         zNNloMVDM/I1SBwJpeUgn1ZCbu+OoqXK5LgtQlHwjqd/yoaXWBxZyXrB7/wXVYOmxB
         Gk0MigCSMMbUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE8DEE5D09D;
        Tue, 15 Feb 2022 02:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164489377871.29778.2106565738041806152.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 15 Feb 2022 02:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: add missing pci_dev_put() before return (2022-02-15T02:00:07)
  Superseding: [v1] spi: add missing pci_dev_put() before return (2022-02-15T01:59:46):
    spi: add missing pci_dev_put() before return


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

