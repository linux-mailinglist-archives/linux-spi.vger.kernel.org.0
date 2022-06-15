Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06654CBF6
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbiFOO4h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiFOO4g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 10:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100B35279
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 07:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4FD7B81BEC
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 14:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8949BC34115;
        Wed, 15 Jun 2022 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655304992;
        bh=qqY6CF1XltAc7rs2FNjU81RW/Y6Lnu2l4+nJNtvdKac=;
        h=Subject:From:Date:To:From;
        b=JR/gJbvGf5fGZbACnnU0Q7ZK2KOzlQSaojHWZs7v+k7iYzRsEu6CVrJpSn+hHekB7
         B+t/hcpubLUsDwBLsSNY/Xaz3gJFgCQ7yN0fux1uMCh6nYqscCtc4o1C+bVRLIoLlh
         QLXANk3pgeW7Wdc3nfOsf1J6wxQ2A4Zw63BC2HbDXU0nUtRsB8ze8R1VWHyJ5Z+qm2
         l3Yl9OnPdSHHaFBMXsd0QkGbkfvC1oBitx3PBOTH/y4c7iF9kcOzWbMENDgim23r3G
         Qbw+UCjxTRlFfK/pnjOHKZe5yHA8YFPsBAL7LYuhz9dFhbfSJiYqG3W54VmUqZk7cV
         M3v2bfl73zCTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 725E0E6D466;
        Wed, 15 Jun 2022 14:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165530499246.6900.9652065120399777511.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 15 Jun 2022 14:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: microchip-core: fix passing zero to PTR_ERR warning (2022-06-15T14:20:29)
  Superseding: [v1] spi: microchip-core: fix passing zero to PTR_ERR warning (2022-06-15T11:30:22):
    spi: microchip-core: fix passing zero to PTR_ERR warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

