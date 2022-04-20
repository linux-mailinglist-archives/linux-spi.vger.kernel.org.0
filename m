Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F7508302
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376541AbiDTH7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376567AbiDTH7R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 03:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12235625E
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 00:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCB961755
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 07:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D88FAC385A9;
        Wed, 20 Apr 2022 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650441391;
        bh=aIbvTaUWYpUVHhRAepWBYhJIKPf4e+HsD9kbDz1t/Sc=;
        h=Subject:From:Date:To:From;
        b=MK2n/+n6b5qhkRnQbX9dDA+iucmrXlaIVxTv/aoE3fgEentYNUy+/A9sLgq2Ma8zf
         xz81DtiUq2XnESaHnVj88wU0BsYhJhZkd3BWg3fHiieVX1jORe+yAvcCniOSsBja/3
         Gb/UBcpW1THmfLQAQBCDHedToTnycegV3ho7VD1g+vaT4bMK1POe6qqwvbiS6eiR8G
         n60Kb35qjwFKl3eLaZR8hbMDDmmQzenqhh/nC3ovCLq2Qm1S98tuiKK4BG1KaguW9A
         9xpo9BbOnsien8f6ou1siElUwGEjBwhit/rzS08u02FaoHs1z//BiuF5+j+Hp5lCwY
         WvVAIO12epawQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2FDCE85D90;
        Wed, 20 Apr 2022 07:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165044139179.26805.5174155674197030099.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Apr 2022 07:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] dt-bindings: dspi: added for semtech sx1301 (2022-04-20T07:31:45)
  Superseding: [v3] dt-bindings: dspi: added for semtech sx1301 (2022-04-20T03:50:44):
    [1/2,v3] dt-bindings: dspi: added for semtech sx1301
    [2/2,v3] arm64: dts: fsl-ls1028a: add dspi2 support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

