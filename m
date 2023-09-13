Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339179F427
	for <lists+linux-spi@lfdr.de>; Wed, 13 Sep 2023 23:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjIMV5C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Sep 2023 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMV5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Sep 2023 17:57:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC873173A
        for <linux-spi@vger.kernel.org>; Wed, 13 Sep 2023 14:56:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52CF1C433C7;
        Wed, 13 Sep 2023 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694642217;
        bh=D+tSWzlAChSs7XNyso+lUJ9tGBtQaHocbVKZJoBvaaE=;
        h=Subject:From:Date:To:From;
        b=K3mQIHrgD/8IQqPQrYf6VoPbS4hN33pYgn5ODZootcpTd0NADehmOOBEoxRdot01u
         dPM9SUq2X+GTgdFT9rdy/K8Rp3fjvtIT+e9YJb9oRN7l4oFzP7/eKQ0PF3LtZ8smDv
         HM/Ug4bOCA2zjVJ8ZBqPaDIWMQsDhrUY1STZeFT/ssEFlyYMxADB+A3uCTbcophddE
         N4VubvvDd/f9htSEr/coA1aGf3ni7rAbMHvVgoxWZNgXq92kDHMTpXPfxDFIyIbQaM
         ZdHMsx+71V0vlCBpUmavMiCQwRNw6PEjFD0mwLofJd+85thBlcFLQ+QUcVJ65dHUGJ
         7toSxE2CawoZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D2A4E1C281;
        Wed, 13 Sep 2023 21:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169464221713.12503.12465098501153582157.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 13 Sep 2023 21:56:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v16] Support AMD Pensando Elba SoC (2023-09-13T21:49:38)
  Superseding: [v15] Support AMD Pensando Elba SoC (2023-08-11T18:05:14):
    [v15,1/6] dt-bindings: arm: add AMD Pensando boards
    [v15,2/6] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
    [v15,3/6] MAINTAINERS: Add entry for AMD PENSANDO
    [v15,4/6] arm64: Add config for AMD Pensando SoC platforms
    [v15,5/6] arm64: dts: Add AMD Pensando Elba SoC support
    [v15,6/6] soc: amd: Add support for AMD Pensando SoC Controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

