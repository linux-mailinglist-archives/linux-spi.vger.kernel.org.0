Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088957C966
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiGUK4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 06:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGUK4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 06:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5E51A3F
        for <linux-spi@vger.kernel.org>; Thu, 21 Jul 2022 03:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE58615C9
        for <linux-spi@vger.kernel.org>; Thu, 21 Jul 2022 10:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C81FC3411E;
        Thu, 21 Jul 2022 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658400999;
        bh=zjfCFeSKbbrOufqs7xvsTMFSYZSWnTAoS8eXW21MdEo=;
        h=Subject:From:Date:To:From;
        b=dAyBnTat3OTxvzYvgud4Rl9eMxb2lHEw8oOAR/s8H9oaRsh7Wpto76Wd5kYNYqz4f
         GtAjSTugS8sic87DEXTRjVaITtpFAMHpw/uaF0nESrq+NR1fF7gnxNJOAtDEkrAg5z
         9KI7skst9sybS4NiiiUL3BUV1NFZE9AyoPrGCKQ9PQSkK70KW9putSkEq/b3tYpBvr
         qMqQ0Kk6g8S9gftzIkB4dq8rWfFAxgbCE/gLoGjJBxqgIYKkVAv4Y+Mq/px6e6F28o
         xdyQNmlgvZKq8ok6bjrpRqIhx82X/E5u42fFA2houwSInWaSvAy38sktNSb6IStiSr
         u+chd+vdzHacg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7E66D9DDDD;
        Thu, 21 Jul 2022 10:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165840099882.13837.18018554405170950901.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 21 Jul 2022 10:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: npcm-pspi: add Arbel NPCM8XX and full duplex support (2022-07-21T10:15:54)
  Superseding: [v1] spi: npcm-pspi: add Arbel NPCM8XX and full duplex support (2022-07-21T10:15:26):
    [v1,1/2] spi: npcm-pspi: add full duplex support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

