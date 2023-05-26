Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11885712B0A
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjEZQu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbjEZQuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 12:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378731B0
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 09:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9158965184
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 16:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 040BCC433EF;
        Fri, 26 May 2023 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685119821;
        bh=eQqHz23UqExS2OR3tzFl+BFJeOvVxcqInwXor9hLpCQ=;
        h=Subject:From:Date:To:From;
        b=SFGTEhX08zl7Byszudjl3OiCbLIj8Juav/bHkoa3nkvV/OBO+WeOfY+fqQq+NqzNc
         KsLKzFcnlBa0z+1gp6WI1LwPTZ/sw8dMJUa+EvRdTewHWZdNLq9K0ysjC/Rt21ncOG
         8Nz+YRE9BduD9ThkSUw13CG9QqBxcEj2VlIir1/iK7TPFkh30hlv/PmAIroDmM+uWk
         9jqmFfXuHyfDXOqWHLwpzJsw+gRYhw5rWUiLyVdYhxlirxES9JgWnEpX/1hzlYHBt1
         1cJdnxLoCu8Qj439YkaOJcRyarKJJI9xa7ZJTLXy8D84zwc4AEcmGvwehmQZa7+ud7
         775Nqtg5FrBog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0AFEC4166F;
        Fri, 26 May 2023 16:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168511982077.14795.8428669067108077192.git-patchwork-summary@kernel.org>
Date:   Fri, 26 May 2023 16:50:20 +0000
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

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Switch i2c drivers back to use .probe()
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=751106
  Lore link: https://lore.kernel.org/r/20230525211047.735789-1-u.kleine-koenig@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


