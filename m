Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F3747599
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jul 2023 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGDPuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jul 2023 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDPuW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 11:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14ACE75
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 08:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8BA61267
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADBD4C433C8;
        Tue,  4 Jul 2023 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688485820;
        bh=ra2p5qtagbsR+SRZ7COptG0oGkrx+W2IlTbcIXoB//M=;
        h=Subject:From:Date:To:From;
        b=sLXGHYyLBG0YQlzrO2LitdkF72LzppQfONZC8bcO3eYFLUBjEgwu1qhGaTSCZiVP7
         3DEqONaFdp6texbDT9OE9oCJ7MHlff3rxOHoQDNohyqiOzmJcP8L69UPh/RBHuVRI3
         TaNkT2gyqF5PvH4Ek8sz73wwcK6mR/6jIdEPf5isalqDYcFvXOIp/ytweyfbrUq9W2
         J55sinVTgluCCgmmOsH5+QLiRpLcHllN02Ci0uzpvbYp5BKPcA5QyyzrBtk5W2YN0b
         7hNhI4SF97AoADIfk2QwV6xW6fOKZKoY4q0Jl2TJWgHaZiBVZt6UATRpVaCsPeUpwK
         9bKkWsTTwue6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87F92E5381B;
        Tue,  4 Jul 2023 15:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168848582050.21267.3688226414823239355.git-patchwork-summary@kernel.org>
Date:   Tue, 04 Jul 2023 15:50:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: None
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761671
  Lore link: https://lore.kernel.org/r/20230630202257.8449-2-jonas.gorski@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


