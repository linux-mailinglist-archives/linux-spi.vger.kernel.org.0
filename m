Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE39584477
	for <lists+linux-spi@lfdr.de>; Thu, 28 Jul 2022 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiG1Q4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Jul 2022 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiG1Q4i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Jul 2022 12:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1D5F134
        for <linux-spi@vger.kernel.org>; Thu, 28 Jul 2022 09:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B47A961D09
        for <linux-spi@vger.kernel.org>; Thu, 28 Jul 2022 16:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 211CFC433D6;
        Thu, 28 Jul 2022 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659027396;
        bh=OsA47yLT+rLNYYVYgGWGsxGE/1aPrDGO0Eh1HEfX6YQ=;
        h=Subject:From:Date:To:From;
        b=YMckn0aDSC3f6D+bPj1Q0W3fqN1LHXbwmD4UAZSSudNH1r7p3m0YwKG7DWaf0O6+u
         WlBAYMKBIcmTIEJ+BP0h5VPKI+TdwJiAsQ5sX4wwBlIPpIm4HsnwtNChefOkWjqXfi
         h0T1jj3fSJHA/0CkL1oETCmD6OZ6oTfYTyAKCUeHtrgYL7tPUq9CNOoIjP236Y3ojy
         BDpXtbBZgZhr9ylb6OCyq97xfhEMakQ0IvUqmnZRQmUIEyh6gFXxf82WkFpdy1ckER
         C+By24dgnNrnrfptowv35ZcQVYc8naDcUC3W/Cet3Z7OQQ7GJCyQI1jrc2e2Iz6kXP
         FNWGGYSwrOPBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05B8CC43140;
        Thu, 28 Jul 2022 16:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165902739601.26769.15562388490951960385.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 28 Jul 2022 16:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Add SPI Driver to HPE GXP Architecture (2022-07-28T16:14:57)
  Superseding: [v5] Add SPI Driver to HPE GXP Architecture (2022-07-27T16:47:33):
    [v5,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
    [v5,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
    [v5,3/5] ARM: dts: hpe: Add spi driver node
    [v5,4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
    [v5,5/5] MAINTAINERS: add spi support to GXP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

