Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64355FDF8
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiF2K4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiF2K4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E083B00F
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 143F960C9B
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701B7C34114;
        Wed, 29 Jun 2022 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656500192;
        bh=4O82gqpKmkzJ3iQBKQJxuKZmmffRzXam+UjuSRiPEnk=;
        h=Subject:From:Date:To:From;
        b=EhZZjTklaevpNr1iWlnHDUlYoDx8xzG1LaikIfPGsMwG3PX18fY87fYw0uCcrk6FY
         KkFAefWelsSPdi8A6vf0QscaY35xoRtz6n1kZobesZc+ZXrI07Ki6UCWkvJgkyTmeQ
         /APcdmKb4DzXLeeOZ1cTBlBW92JEM+ed+Zb4sHiZj7ZuhHTLlOg1rEDvHDAf9UgjSX
         8hvFvflJ8jr/tK74WzN50hFvNkuzqdzQD/Pwf022rCci8pPE/i8h6spB+i5aZSV0Zu
         /P9/Z1/iZxgoTIKQoQWo7ppmymLvZD8XdQsO6UEMUf9wvTGKrc5Y/zwg6AW36cGksG
         3O7W3sA5EOvZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EA2EE49BBA;
        Wed, 29 Jun 2022 10:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165650019231.14674.13449786645277417791.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 29 Jun 2022 10:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: s3c64xx: support loopback mode (2022-06-29T10:23:03)
  Superseding: [v2] spi: s3c64xx: support loopback mode (2022-06-28T04:42:19):
    [v2,1/4] spi: s3c64xx: support loopback mode
    [v2,2/4] spi: s3c64xx: support custom value of internal clock divider
    [v2,3/4] dt-bindings: samsung,spi: define exynosautov9 compatible
    [v2,4/4] spi: s3c64xx: add spi port configuration for Exynos Auto v9 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

