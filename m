Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35D5F5139
	for <lists+linux-spi@lfdr.de>; Wed,  5 Oct 2022 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJEI5C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Oct 2022 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEI5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Oct 2022 04:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C959A5817B
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 01:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C58615C4
        for <linux-spi@vger.kernel.org>; Wed,  5 Oct 2022 08:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9C55C433D6;
        Wed,  5 Oct 2022 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664960219;
        bh=D5XJbLKqOJnCkNIBSesyRb3mIcXgsrTeHkOYWa4tAuE=;
        h=Subject:From:Date:To:From;
        b=K1RgnrGKggWscJ7z5x5BbvgJ5iahNfuQX00xficP9C4mipOzmgWOBZrW1oZHdk4w3
         nzlI0AfZPoeZQO3tI4AaLdAmnkKYABkQSUT1eoDFYpK1+J0JGgCIPUHnP+wEaJHOYy
         hLcfpShN0OswJtF42r51jVcePv27kY0zLZNuabih8umCmjdPXVXzk09ebbB2d8FL1R
         m9YBI7FTWplbwEEzLjSN2pJixmJtp5c2SCUl52rUBXALo7mTuLc6bcrG0uP6Bc1jle
         J3Qi/CcDqrOXlAvdwBf9/8RQTxL2CYk+uFP3aCE4znU/+QEH/6mx1/qhjRouguHFaN
         +EH9ZrgUORqgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4CF5E21EC2;
        Wed,  5 Oct 2022 08:56:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166496021973.20964.11121148335940303257.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 05 Oct 2022 08:56:59 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600 platform (2022-10-05T08:32:09)
  Superseding: [v1] spi: aspeed: Fix typo in mode_bits field for AST2600 platform (2022-10-05T08:01:04):
    spi: aspeed: Fix typo in mode_bits field for AST2600 platform


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

