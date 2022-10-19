Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764B604A5E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJSPEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Oct 2022 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJSPDm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Oct 2022 11:03:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20421057EC
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 07:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1DDECCE20F3
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 14:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 638FEC433C1;
        Wed, 19 Oct 2022 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666191410;
        bh=sCCKLhxTFWEjcW+tnoGF+pGUXeWNWdzIyyVF/5egTeI=;
        h=Subject:From:Date:To:From;
        b=WydAnycG08NW86ut0WAFkG4hDyQ9oWuKmabT5dbHkSBi2E3pk7OaiuMNhyw19F2Cx
         9boUc/zK3WAc2BhWFyQ39TzRysnLPTM2ZLzAYcTUwx3ed/H3by/EO7OsaDen7XVttU
         X5C9EZvjKkfnzTlkUuBEnd6/xVTbf5ZX9IC0Hp1EwRWk+Bq6Q/8MuWSG5r/CAPrlmC
         GIcu/IkcDZYCw3okWc42+9tnGqQJ6WKcq+1opTf4xwQBf/sHqH7qVrPJ1J+eqXzYym
         VWCNcqB4HK8nGWbSiH9WeBSgqn/JB1JIVnq9BE28ALBin+lCd2wRGDuu/FaWoWQrzS
         RzQip0McVn3uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C35FE270EA;
        Wed, 19 Oct 2022 14:56:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166619141030.21918.3391833425337424154.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Oct 2022 14:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-10-19T14:01:03)
  Superseding: [v2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle (2022-10-04T11:10:36):
    [v2,1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
    [v2,2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

