Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD846870C0
	for <lists+linux-spi@lfdr.de>; Wed,  1 Feb 2023 22:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBAV4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Feb 2023 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAV4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Feb 2023 16:56:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E969B39
        for <linux-spi@vger.kernel.org>; Wed,  1 Feb 2023 13:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E91CEB82234
        for <linux-spi@vger.kernel.org>; Wed,  1 Feb 2023 21:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AC06C433EF;
        Wed,  1 Feb 2023 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675288580;
        bh=bPaYixaZ6IXo3zp1IXcRv+lsWpztNxDBDiDGoixH6SQ=;
        h=Subject:From:Date:To:From;
        b=TPGz1uGdVgm45PAipmc0I69LAofobgEbAT13hda9mMpQ5SP5hlwpiwVNO5B1ShfGV
         7LbrdZPjF2qwRgZH0V/SviveM2QA4xeZnrxG1kUnAL4Q/iCshvDPphODS8Zb4NhU5J
         yv5MHd6DQ67qiBrYgN1lu0diE9i/Gvr8gVpsSG0IOQUYNnP9Gi6R8JqT8zsqQfLaB8
         kVRpVK9lmVgoqqzWXh6nvIvyLOAR9zPlRtD+WkdALkxc9aUn3mfwBWhKSLOSXN9z58
         L4/+Q/WCAzVEt93LrmwmiVoQ/f4VNRUr/N9OkQgPkA0UzIzeGaQwwGP1qjCm70Fxmt
         NfOBKHQhIuo5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ECF3E21ED2;
        Wed,  1 Feb 2023 21:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167528858044.13890.3842520007715656918.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 01 Feb 2023 21:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: intel: PCI driver housekeeping (2023-02-01T20:54:53)
  Superseding: [v1] spi: intel: PCI driver housekeeping (2023-02-01T05:04:53):
    [1/2] spi: intel: Fix device private data and PR_NUM for BXT
    [2/2] spi: intel: Add support for controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

