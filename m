Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152FC67405D
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjASR43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Jan 2023 12:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjASR41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Jan 2023 12:56:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F114875A3
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 09:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D040FCE24FE
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 17:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A038C433EF;
        Thu, 19 Jan 2023 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674150979;
        bh=oMkIr9rUmvWQpvifcu/1eRt+ALf4i5CvLn7o+Zlgmmk=;
        h=Subject:From:Date:To:From;
        b=H1/BOD3KH8vGXmsmVQkeW7ShSHZGnhvePv8LwoSLT4g0Hq9PHiXiEv/blgigkdJyk
         hBsRpXehpO4UbTjhvoNAsPGwVAcmf7whqPsxFDsW8WUPPRnmqZFeTX11iyxOyav/Ef
         rTgIgpIv4LYZZPCfZycQ/qQ+E3y2BQItQfn1A8Nnjxi7JLG7CAYYe5HyBur/UyEHLp
         XBSmDbU/Ui9B9mSmFDhqTbDArzS0G04I54Txyl80yOvH2l2LwUj/Rm/qqHabwIFzIw
         l8RyWR02KpCLxtKsLUC8AlTIEcbG7V/iFU1J83vGhB/A7pamaviTc1baDxu3sb9JtY
         rJdaeIoPX5oew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE359E54D27;
        Thu, 19 Jan 2023 17:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167415097897.12876.482947492688867257.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 19 Jan 2023 17:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add MediaTek MT8365 SPI support (2023-01-19T17:28:18)
  Superseding: [v1] Add MediaTek MT8365 SPI support (2023-01-19T16:28:48):
    [1/2] arm64: dts: mediatek: add spidev support for mt8365-evk board
    [2/2] spi: spidev: add new mediatek support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

