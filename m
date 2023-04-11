Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3D6DDD16
	for <lists+linux-spi@lfdr.de>; Tue, 11 Apr 2023 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDKOA0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Apr 2023 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDKOAZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Apr 2023 10:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6019C
        for <linux-spi@vger.kernel.org>; Tue, 11 Apr 2023 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA1E626EB
        for <linux-spi@vger.kernel.org>; Tue, 11 Apr 2023 14:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F348CC433EF;
        Tue, 11 Apr 2023 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681221618;
        bh=EygYVu2+06PCyZEwDpIXwdPw7W3jXftko0cZcjk1+8g=;
        h=Subject:From:Date:To:From;
        b=l8/qT9M2I3PmESpgwBIMeT4PcThEYhqXAUxZdlp8jYBGyQ9Fh9zbhxx5hxeZLAw3T
         Crh9sZiPigIbpkXh+C/g3ci8PoHWaE4iw/nMt0nVTySJZV5RRUVmsMdEA5aPePuyT6
         /RiWCVLy2hprBY2JaT9wVoyHmJe7eA38tgh4I/kwOk22e96YHT65jMKoChvW50/Zit
         9vxPtE1iK2BrIie0IF/OIEUfOy+ymA86hSZUtllyH5YLHu9OscDYdq0ySDpW9l5Xke
         eVzObEC5XLluuc/7WPeO+bWYe6jBtC6FIt2t3kuv8yfEji6KHVVcSJyItoE7R/AdLo
         i0ip34r1SWKgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0901E52441;
        Tue, 11 Apr 2023 14:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168122161778.29778.17623951332462790650.git-patchwork-summary@kernel.org>
Date:   Tue, 11 Apr 2023 14:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: add support for Amlogic A1 SPI Flash Controller
  Submitter: Martin Kurbanov <mmkurbanov@sberdevices.ru>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=736499
  Lore link: https://lore.kernel.org/r/20230403183217.13280-1-mmkurbanov@sberdevices.ru
    Patches: [v3,1/2] dt-bindings: spi: add Amlogic A1 SPI controller
             [v3,2/2] spi: add support for Amlogic A1 SPI Flash Controller


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


