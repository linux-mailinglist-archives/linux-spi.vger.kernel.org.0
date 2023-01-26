Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242E67C1AB
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 01:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjAZAap (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 19:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjAZAao (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 19:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B328166F4
        for <linux-spi@vger.kernel.org>; Wed, 25 Jan 2023 16:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECE5616E4
        for <linux-spi@vger.kernel.org>; Thu, 26 Jan 2023 00:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02ACC433EF;
        Thu, 26 Jan 2023 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674693017;
        bh=c3mhzc87OH1ooZw7OulHC4CmHvP55u6e5hJEfLVf62w=;
        h=Subject:From:Date:To:From;
        b=N2AN+Mb43Lwzgjjv5oavD2dawdq4M3p8sfvUcP5ZmEvSNzAE+vBaBdTyVCkCjYnwf
         QrlxEF7JnHJC2yYjCJBfJW4X/abltB25ii6XV9A29KzNXklALwMdmCSp0SqMczZvcD
         qJSqXX5rCDJEiqJT5lvu0UZX5DVncXMQeOmtGs+r9eM7Sbiq9Y92XBBuZryougdw/e
         yukbNRCXZwHy95uynuazhQM52IpaafOoLb9J96Dc2JbMO9Vql8fYm2Se9p1mQC5XF0
         uG3hiUbSXCt6Rws+6WfnOwS3JQnIL8OxHhI/FeF1MHZIOC3eCG9x3QOLJ0MFfrcYPA
         5AJV+oDTs881A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7984E52507;
        Thu, 26 Jan 2023 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167469301768.25981.15005694572251601492.git-patchwork-summary@kernel.org>
Date:   Thu, 26 Jan 2023 00:30:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: dt-bindings: drop unneeded quotes
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=715031
  Lore link: https://lore.kernel.org/r/20230124083342.34869-1-krzysztof.kozlowski@linaro.org
    Patches: [v2,1/2] spi: dt-bindings: drop unneeded quotes


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


