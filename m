Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13BE607F54
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUT4z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJUT4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 15:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266129B8A1
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 12:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CD861F70
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 19:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EA15C433C1;
        Fri, 21 Oct 2022 19:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666382210;
        bh=gyDBSqA0M1tC7Ap7kixsf7Ms6jO/iNwkTLKI43rekSg=;
        h=Subject:From:Date:To:From;
        b=PpH+Sc8gXAzYWM1FAFRvXzStBipDkbSWMZL52QMreSITQTNmomWr+ubyWtOltGi9t
         o86TxxbK7P1HwvBr50wA6bCHAQj5Q6t4y1Q9ZxnrxUPhJmZZbLJoIyzr+ZtR6Ff8uh
         BaT+kQi3K2lymr+/bUs7l3idcqyNfk+iIjPCX6pHwAmUfHxY6lFSxV/sSTjhQkwVpX
         2vRRJA3W8SYuyFDuZlk4J2SmHBFbb5ZyB85a7/G5dnmiBRsCPU0Q/gu7cNChBb08lQ
         HAL+1vCpOIAJ4JQPdn3b4JFXKBSQ8tIP1ojIaqrI0oYa37FieEYXmeJGavEWvtcBMo
         MX13yZhYOuE9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E13CDE270DF;
        Fri, 21 Oct 2022 19:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166638220991.26459.10475517295753260383.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Oct 2022 19:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: pxa2xx: Pass the SSP type via device property (2022-10-21T19:00:15)
  Superseding: [v4] spi: pxa2xx: Pass the SSP type via device property (2022-10-20T19:44:56):
    [v4,1/5] spi: pxa2xx: Respect Intel SSP type given by a property
    [v4,2/5] spi: pxa2xx: Remove no more needed PCI ID table
    [v4,3/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
    [v4,4/5] spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
    [v4,5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

