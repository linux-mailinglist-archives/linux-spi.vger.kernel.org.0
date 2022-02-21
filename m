Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08A4BEC20
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiBUU4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:56:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiBUU4q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:56:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3EA237F1
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 12:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A416F60EAE
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 20:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09C80C340E9;
        Mon, 21 Feb 2022 20:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645476982;
        bh=Oem+DmFW7L3tinCQDP6YEXruBFxZWbJ5mkVgsUJwV60=;
        h=Subject:From:Date:To:From;
        b=OROuVRAtrKEa6tGtyPJmr82iyIU+jXT/mWh/IQmhnbrI3j+0tVEgQ+4SdUXFweWQ8
         +BKwrhpDbk5yuhfYxseWMeK4THVLaXN4X3lhqwSc7e9QEmzAl8A5B3JTiLqgG7nPQG
         5kZJk+UwHW8zJB321avTdEvE3zK7CEjqYYh8isjI48PT1DVvU++pyujjzcFDuVAWGR
         3ARi+FC6PrjCStNoLrpujpZ+0sF0QAXakVvFlJOMLUIeVP1yY64Ku/Br8ytYZRmZ3w
         gIN4MusZ31Ve1tO/+VYQ9qlb3wMKR4NcbcF46mhbP7JG/8YsPldVIXyW6JimKawfnR
         5d0ipEUkmoQEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA0F6E6D3E8;
        Mon, 21 Feb 2022 20:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164547698195.29769.6735813941451652342.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Feb 2022 20:56:21 +0000
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

Latest series: [v2] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-21T20:19:21)
  Superseding: [v1] auxdisplay: Add support for the Titanmec TM1628 7 segment display controller (2022-02-19T13:13:12):
    [1/6] spi: gpio: Implement LSB First bitbang support
    [2/6] dt-bindings: vendor-prefixes: Add Titan Micro Electronics
    [3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
    [4/6] docs: ABI: document tm1628 attribute display-text
    [5/6] auxdisplay: add support for Titanmec TM1628 7 segment display controller
    [6/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment display


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

