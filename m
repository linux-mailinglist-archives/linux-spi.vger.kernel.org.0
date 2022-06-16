Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4F54E131
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFPM4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 08:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiFPM4h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 08:56:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17403B573
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 05:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC42B823AC
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 12:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 031CBC34114;
        Thu, 16 Jun 2022 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655384193;
        bh=CjorRknsScYfpw/c1YZEGJuL4kN56uqg/Xj+x2NLo3w=;
        h=Subject:From:Date:To:From;
        b=MCyFBPh3acFlNOYoc320F6MbioXXzo8mctWdlTeYtBgubBukFgVYWDrZ3YDFE+C77
         lHQy4PYNPPkjzoxssWD/ZTvjq8mCz7VwKD6IN/ZdTIDrFu8Pkq1eeHJIsKpRvnZ08F
         yA2ESwU9aKZSeKJTSzAECkGV15ehQrdUgTIa92QBlzUUE9E6QN2wxB1GkvWIeACW+1
         vUGq+QTxax457s0kdKQpiXBH2sGpcZ8zG1iQ/fMUvpMy2V50NwPf11ElC5J/GzO/Qh
         GPkO/a1Ll3yCuWuuVUOlVArLBnO3AIwWbmqLIJ9RgOIF8KJrkenODSk6LAoXaNCw9W
         hOk+J/C9U1j5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8D47FD99FB;
        Thu, 16 Jun 2022 12:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165538419288.13268.17623481499850925510.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 16 Jun 2022 12:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] mtd: spi-nor: handle unsupported FSR opcodes properly (2022-06-16T12:14:45)
  Superseding: [v2] mtd: spi-nor: handle unsupported FSR opcodes properly (2022-06-15T19:11:53):
    [v2] mtd: spi-nor: handle unsupported FSR opcodes properly


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

