Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B06CB111
	for <lists+linux-spi@lfdr.de>; Mon, 27 Mar 2023 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjC0V4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Mar 2023 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0V4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 17:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742512E
        for <linux-spi@vger.kernel.org>; Mon, 27 Mar 2023 14:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F373B819A6
        for <linux-spi@vger.kernel.org>; Mon, 27 Mar 2023 21:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A77D7C4339B;
        Mon, 27 Mar 2023 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679954205;
        bh=ItN9iEj137PItTTzY3/G9Jxmb190UziwUs+2EcDZw3w=;
        h=Subject:From:Date:To:From;
        b=iQxF9T39BzangCplymc6ZpyXcuhRtFl4T5atzpl7G36PAtZWsm9TB3Q2Vhqm3D6rB
         /l647gLD3kLROpUgQJNnfZ9URsZa25wX4avonKlDr4nphrgi9o23GuLhYxSFjslAVe
         QGf3KwQC/O11mpkNHwVbHpzMWOnT/pfEEc5RZBPVakGJPSOu+gl3z9e9wP2BL5N0zT
         4j6GHSzqhyCdDlFJ+xDU/ixNFNuCL87kKFiXPmtrqqVG8wa0EIQNvFMvqNzxQHp2MA
         ubjQozTrd6oeHTsJxbu/bxqDCsDzrNZjfufhpe3KWtrPm7AvqHy3DePgKiO134nG7h
         1vJteGDYohJYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9370CC41612;
        Mon, 27 Mar 2023 21:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167995420559.17843.2976790831474893342.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Mar 2023 21:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] add support for Meson A1 SPI Flash Controller (2023-03-27T21:13:49)
  Superseding: [v1] add support for Meson A1 SPI Flash Controller (2023-03-22T15:04:57):
    [v1,1/2] dt-bindings: spi: add binding for meson-spifc-a1
    [v1,2/2] spi: add support for Meson A1 SPI Flash Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

