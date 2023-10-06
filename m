Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F717BB9D8
	for <lists+linux-spi@lfdr.de>; Fri,  6 Oct 2023 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJFN42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Oct 2023 09:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJFN41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 09:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C3CF
        for <linux-spi@vger.kernel.org>; Fri,  6 Oct 2023 06:56:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6873C433C8;
        Fri,  6 Oct 2023 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696600585;
        bh=yexgRMp14lViPoCMxQlDQUcw04iJDYY82s41IsuU5e8=;
        h=Subject:From:Date:To:From;
        b=fECXa/f+9UK1/+IEC+Fx5t87XjqSY2MC6mDK3YBPNsvgpHD/q9Q/gWdYGJwfeWnZ8
         zkX0RIE2+2AXVEDlz31T+zYgdeI+jSvFXucFCNueHqyE45TxxR87ELqRyLDLjl9YDF
         9C2jEhvvR5r+SOgKZPtDh9P0sTFynr+B3yFTHewEO0cq2gZXU4ybess1TAZuNwhcE1
         58FxWofcUx4c1nApIE4xXwzlrnQR/Ls0UWSQvtDC0z/q6NMPbK0gcUN6s9MIo8t9H5
         GAYIl3+yeadFwVeaEi1PqmIpBq+C9VWjCH48GmDCMasoJXn2W5njzn7VgKO/UQqxju
         vB9OTa7Wu2Ing==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99ED2C41671;
        Fri,  6 Oct 2023 13:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169660058562.25010.18032964735665104999.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 06 Oct 2023 13:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] ARM: pxa: GPIO descriptor conversions (2023-10-06T13:44:26)
  Superseding: [v5] ARM: pxa: GPIO descriptor conversions (2023-10-04T14:56:24):
    [RFC,v5,1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
    [RFC,v5,2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
    [RFC,v5,3/6] ARM: pxa: Convert Spitz CF power control to GPIO descriptors
    [RFC,v5,4/6] ARM: pxa: Convert reset driver to GPIO descriptors
    [RFC,v5,5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
    [RFC,v5,6/6] input: ads7846: Move wait_for_sync() logic to driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

