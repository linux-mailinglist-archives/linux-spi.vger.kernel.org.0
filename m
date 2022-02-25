Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9776C4C5115
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiBYV5B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiBYV5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:57:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC8218CCF
        for <linux-spi@vger.kernel.org>; Fri, 25 Feb 2022 13:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 943ECB83348
        for <linux-spi@vger.kernel.org>; Fri, 25 Feb 2022 21:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33079C340E7;
        Fri, 25 Feb 2022 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645826185;
        bh=muxUvIqyq0ZQMt+B+hLhBPk4UTVuDkChTecxlX5cPQ4=;
        h=Subject:From:Date:To:From;
        b=GyBcXp/PdpkyYoO9LKN/kERedb6GHOVmi6+dFdTqSiKIw8FQ/hrQ0vhGcYg1fEt2h
         w6NYKoyH4qyBiaeZ68uJaY53yyWtRFJEAcba7K7kChUveMG1C2OXKM7UdNDQ7Xvm8o
         29m1jmqyCRkrJICBdMGVfPzYUkirPUFzRx5uND75O97AEvtSxhE5CCxGm4h3GtfgDr
         vDpektZl4SS9CObsvrgAzJzQ0bsTJ3A+bYYBOvzXNvwEa3BZvf2vaPIXRvRqecU1Zk
         M8Js/cq6yuAk1CrQqtZtS9GOaQjHzhm/qcGk3Y/WYUlYajFgzDrKCm6Aij8RUwaPrV
         ujNpTBbNOTFdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A0EAE6D453;
        Fri, 25 Feb 2022 21:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164582618510.725.7926059204479086989.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 25 Feb 2022 21:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-25T21:09:10)
  Superseding: [v4] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-24T20:00:38):
    [v4,1/6] dt-bindings: vendor-prefixes: Add Titan Micro Electronics
    [v4,2/6] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
    [v4,3/6] docs: ABI: document tm1628 attribute display_text
    [v4,4/6] auxdisplay: add support for Titanmec TM1628 7 segment display controller
    [v4,5/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment display
    [v4,6/6] MAINTAINERS: Add entry for tm1628 auxdisplay driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

