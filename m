Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A960665B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Oct 2022 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJTQ4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Oct 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJTQ4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Oct 2022 12:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C6019A23A
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 09:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D832461CA0
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 16:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 487B4C433C1;
        Thu, 20 Oct 2022 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285008;
        bh=OPMPKI/m6ks9ZqvFbG3+116U8C/MAT78RIZ+pmMJJ5w=;
        h=Subject:From:Date:To:From;
        b=A1vIhtiIhwAc635mRNGwNsbalQ+dOzKckXIwXssNsWhTMupSztpuziMwporUH+Kl4
         LhSmovA4ZNI79OxFeUEl6nGI65tg/xcSqnyZgokxQGLgdhZmRhXsky9kkwWgjYAC5Y
         6aXXSn0WrazxKX9u0Rn8narJKND+Jv82GsTUEEDCBokMwVHnj7ESgF+pgWUEvLa5oS
         +LvMnKVBCtvc599FHPokp1dLXS3LcXljs0qdwugihuCmwX0AOwnJeEwh07XeuJaPZ4
         Bn5wPQyBYODnQR+Had+bQO/FrUv5AuMbjK/QwLVvYcEFT6eOLElrgKx6kKJFVTGc6g
         nMjKJcgE4odBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D8E6E270E2;
        Thu, 20 Oct 2022 16:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166628500817.23167.17863306682796335064.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Oct 2022 16:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: pxa2xx: Pass the SSP type via device property (2022-10-20T16:26:27)
  Superseding: [v2] spi: pxa2xx: Pass the SSP type via device property (2022-10-19T15:04:25):
    [v2,1/5] spi: pxa2xx: Respect Intel SSP type given by a property
    [v2,2/5] spi: pxa2xx: Remove no more needed PCI ID table
    [v2,3/5] spi: pxa2xx: Remove no more needed driver data
    [v2,4/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
    [v2,5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

