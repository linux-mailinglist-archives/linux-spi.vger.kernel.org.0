Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D17C55F6
	for <lists+linux-spi@lfdr.de>; Wed, 11 Oct 2023 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjJKN41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Oct 2023 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjJKN40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Oct 2023 09:56:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9CBA
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 06:56:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F917C433C9;
        Wed, 11 Oct 2023 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032584;
        bh=nraQWSLhF6ytFodkFlUJW5/jjlKccx6PKvsuMNHqCGQ=;
        h=Subject:From:Date:To:From;
        b=XiUW8sxKMZuRps3cn/DffFpr4dFmQnbvRPLnaDzvvxV3F6qso73MyUH9sRFhOIaDj
         yfD1xs037RuI9GXCtYWAYeQT4ngDpTPKpLDYCHcKgol8v2RnjTH/JYuDo2X34i4ARr
         KVk+1lISIS5PssBR+WNXAsd4XPnBafuk/alAh07CkUKOyAVisTyQbJKDuPpaRrL5c8
         QrJ3ozINj7i8GSU+LZIcFYVfWwsdl6k9+RpdvYm4QBUsGhptTd4flrn1QE9gVmSWxl
         ZFq7UfG42HkBe+a/dxyrEjXBQUXRzWsYUjHG9Jfz96+5ab4TMymPn54SqHe92s+cUT
         R5zCSG3r7mpDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F4076E000BB;
        Wed, 11 Oct 2023 13:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169703258399.19843.5905056734703106395.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 11 Oct 2023 13:56:23 +0000
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

Latest series: [v8] ARM: pxa: GPIO descriptor conversions (2023-10-11T13:23:46)
  Superseding: [v7] ARM: pxa: GPIO descriptor conversions (2023-10-09T18:33:57):
    [RFT,v7,1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
    [RFT,v7,2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
    [RFT,v7,3/6] ARM: pxa: Convert Spitz CF power control to GPIO descriptors
    [RFT,v7,4/6] ARM: pxa: Convert reset driver to GPIO descriptors
    [RFT,v7,5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
    [RFT,v7,6/6] input: ads7846: Move wait_for_sync() logic to driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

