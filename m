Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582EF54D221
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiFOT4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiFOT4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 15:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACEE2ED78
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 12:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073DC6112B
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 19:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C482C34115;
        Wed, 15 Jun 2022 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322991;
        bh=5LnaxkwbpZ61TwwQOWKd6LNHkAAC67WM9gR7/aAqGSo=;
        h=Subject:From:Date:To:From;
        b=K0AzSmSFOk/LORzslV9jkUnalr4FLWurdjghQTrWDn/E5uFClxpggF8II0VoAQLvT
         guLcj9fmVGBfcargVGtEl20cMMHQUWMxF08v2lZr4sENJmkwzTxXUY8OU9g2VDInGH
         /9L1U236v4o/JQVERQg09ZNlX3Fti5Wpr9hhXvDdeqlIuXdQLAOZq3nMtoMDQEcDvy
         vlKj10jmRBAqXFM+tVcDaXLjOr8SVeTbMJEg/6ZSOT+0tLVt6ZbQnDgXrYMN27uAEm
         h1AClAWBxP3dWuYnL2Rehifnt2fsBoIuJfCwBxeDOb/7EYzQIk7D3CD35/scwKhmrU
         F8uS+os+xC1/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C4B6E6D466;
        Wed, 15 Jun 2022 19:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165532299125.4726.3428896129581226371.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 15 Jun 2022 19:56:31 +0000
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

Latest series: [v2] mtd: spi-nor: handle unsupported FSR opcodes properly (2022-06-15T19:11:53)
  Superseding: [v1] mtd: spi-nor: handle unsupported FSR opcodes properly (2022-06-10T19:15:48):
    mtd: spi-nor: handle unsupported FSR opcodes properly


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

