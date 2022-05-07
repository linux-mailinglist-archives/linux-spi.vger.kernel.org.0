Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE051E68D
	for <lists+linux-spi@lfdr.de>; Sat,  7 May 2022 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbiEGLAX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 May 2022 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiEGLAX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 May 2022 07:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A432EE3
        for <linux-spi@vger.kernel.org>; Sat,  7 May 2022 03:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009C76113C
        for <linux-spi@vger.kernel.org>; Sat,  7 May 2022 10:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FC7CC385A5;
        Sat,  7 May 2022 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651920996;
        bh=OpNOENCmhHiQw+KUcgfneSvBNOZ6Q16r6P19bzIoC2Y=;
        h=Subject:From:Date:To:From;
        b=YgbP7M7uPjnpbJlsA80SXYUNG+XNz86hw1QXAnbjrsKrA8pj0OqFpe/iNfQklUYLz
         /A2DbS6FsPub9nNS9/sZKdXcn7zAZ+z5VeswTR0ujNeR6P9p9YrYMQN9BKDyho0XFJ
         MyvvDX9vQAdJuLMHM8uTSnSTQZMKkKOGbBS/HGL6vrw2u+3vU7C0kgkSCiDsN+4FGv
         hhboJLeVK2CDq8357vjjCqwD5XJseANc3Db50f5HE1zYoWM63soR21jn2lS7XRrJUm
         5d/CyjZV82rpDgfsLtzT91aWyZcrhAxrWkHuCHnHGhQbwGBF7AFlcpPdCzycBC1jQ7
         Rjwru+scsoGjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43813E5D087;
        Sat,  7 May 2022 10:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165192099626.22413.12134101970553117866.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 07 May 2022 10:56:36 +0000
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

Latest series: [v2] powerpc/52xx: Remove dead code, i.e. mpc52xx_get_xtal_freq() (2022-05-07T10:01:47)
  Superseding: [v1] powerpc/52xx: Remove dead code, i.e. mpc52xx_get_xtal_freq() (2022-05-04T13:44:46):
    [v1,1/4] powerpc/52xx: Remove dead code, i.e. mpc52xx_get_xtal_freq()
    [v1,2/4] powerpc/mpc5xxx: Switch mpc5xxx_get_bus_frequency() to use fwnode
    [v1,3/4] powerpc/52xx: Get rid of of_node assignment
    [v1,4/4] powerpc/52xx: Convert to use fwnode API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

