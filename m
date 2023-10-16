Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9057CB137
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjJPRUZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJPRUY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 13:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE27E6
        for <linux-spi@vger.kernel.org>; Mon, 16 Oct 2023 10:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 517E6C433C9;
        Mon, 16 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697476823;
        bh=A6EeY1hpRYDcpZfvJ0+mHX4x0FBQz73Yv9BOzK5CySc=;
        h=Subject:From:Date:To:From;
        b=OnL5SPXVsIjNSl7CAkYome3Ss11vNHfhCcCCjDz9pgWXx499HSxDX4mGydnW+8bHf
         8yBsKLy/oCr7rKFr/y9mJIJq9FdDviQlgnR0hMrVC6GYq2DHwRwMY8Z4GAKZJ07GHV
         6kylFvO3EVglKUX5wps3l+wHoZu0Wdh0n58ZIeJJpcGPheSxvsMpTY5vlv21qlswCp
         1mID2w8cL5lJMBnzov/Z7Yyij1T/ryFMq1zXTHIjCGVADU6UEufdljnuQsL9Mcy/BT
         4SxneaMoUeET3prQL2HKQQBOrkZOMkTt+2YspT73PY1R2puR/eSryS6YxFO8/Bh5Hz
         NfSyuvuIvTQzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B47CC41671;
        Mon, 16 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169747682310.11157.1029128264364427338.git-patchwork-summary@kernel.org>
Date:   Mon, 16 Oct 2023 17:20:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi/ACPI: Add support for SPI WM5102 coded on Lenovo YT3-X90
  Submitter: Hans de Goede <hdegoede@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=793250
  Lore link: https://lore.kernel.org/r/20231014205314.59333-1-hdegoede@redhat.com
    Patches: [1/4] spi: Export acpi_spi_find_controller_by_adev()


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


