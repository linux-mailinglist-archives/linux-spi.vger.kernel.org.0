Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89C583287
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jul 2022 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiG0S4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jul 2022 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiG0S4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jul 2022 14:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97C68DC9
        for <linux-spi@vger.kernel.org>; Wed, 27 Jul 2022 10:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9906192D
        for <linux-spi@vger.kernel.org>; Wed, 27 Jul 2022 17:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 232D0C433C1;
        Wed, 27 Jul 2022 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658944595;
        bh=ib0+EZ5QpwYzLNOSAJm1U1MZ8oEQFbMfnPTFDL+TG80=;
        h=Subject:From:Date:To:From;
        b=aovfcDRzbsQqhpnwQB9MwjQjl77Uc4wukIiBhfeXLXd2UbBINELuQs1zDW0u6t8q1
         U9RnKNoe57syOzZqdeOJ2mHSpI1R0SW295ahiTcLAwNFHVxOK9B8AZm9nNWTV5YyB3
         EOHTFg6Pv3f2nlfWvo3NF3bYK14UocGaYDhgp4AX/+9OwXHCt42OtMKqDUXkW2+PUV
         mqS4elsNe0CPVPC3LkRog5hGUytYZKCC9LObpU0XArnieoGluEHhBF/eVkQ2pJsuOd
         PiBrOhqUuLU/fIYI5dhDs9WnLP4e8ZcvMd8KoC/SqpAZNtJhaYOF/Q3qmW+YmUElvX
         EveeM/A9JCA2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 045CCC43140;
        Wed, 27 Jul 2022 17:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165894459496.26825.13471281439728303145.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 27 Jul 2022 17:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add SPI Driver to HPE GXP Architecture (2022-07-27T16:47:33)
  Superseding: [v4] Add SPI Driver to HPE GXP Architecture (2022-07-25T20:13:21):
    [v4,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
    [v4,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
    [v4,3/5] ARM: dts: hpe: Add spi driver node
    [v4,4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
    [v4,5/5] MAINTAINERS: add spi support to GXP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

