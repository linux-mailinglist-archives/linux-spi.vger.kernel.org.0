Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E659C7F0035
	for <lists+linux-spi@lfdr.de>; Sat, 18 Nov 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKRO4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 18 Nov 2023 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjKRO43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 18 Nov 2023 09:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091312B
        for <linux-spi@vger.kernel.org>; Sat, 18 Nov 2023 06:56:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37A48C433C7;
        Sat, 18 Nov 2023 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700319386;
        bh=joC4wuBjAbiRGQ7eevFiXwib9ZyokCsFr+vvOBL4+OE=;
        h=Subject:From:Date:To:From;
        b=EIjHyXbFRnWdKUq54lNZY/5DQsbFp0I14ql+5xCWLJ8B8nBqknuVZJWZVL/6UQ0MG
         571OyAQ+m8bL/tB6YJcIoUd3IA1irMHHN7LmVh1Wbd9qw/PXDxNq0zpHr5YAEr21hw
         Qzmoer1TyBlEoS/h66u/87nJGAlPjK/xWDw1wVreiUO5LC3BhafeSaPTH2ZZHldKJD
         CpZL9gABMP6Nv/LW67tiQtFXSaKcMwOe16n24krST55tb/Aid5cakjZA48Uvoo7LPB
         FglqZrZO1w1cWECgoStU+LutktfdVs/45dLHsm8dTyhmwLB7wbUr649iZFqv3/V0DP
         CpWt9tCKZuZDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C572EA6303;
        Sat, 18 Nov 2023 14:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170031938594.32000.5104411985316426835.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 18 Nov 2023 14:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] spi: Add support for stacked/parallel memories (2023-11-18T13:54:38)
  Superseding: [v9] spi: Add support for stacked/parallel memories (2023-10-18T21:33:20):
    [v9,1/8] spi: Add multi-cs memories support in SPI core
    [v9,2/8] mtd: spi-nor: Convert macros with inline functions
    [v9,3/8] mtd: spi-nor: Add APIs to set/get nor->params
    [v9,4/8] mtd: spi-nor: Move write enable inside specific write & erase APIs
    [v9,5/8] mtd: spi-nor: Add stacked memories support in spi-nor
    [v9,6/8] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [v9,7/8] mtd: spi-nor: Add parallel memories support in spi-nor
    [v9,8/8] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

