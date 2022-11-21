Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026EA632750
	for <lists+linux-spi@lfdr.de>; Mon, 21 Nov 2022 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKUPHO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Nov 2022 10:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKUPGv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Nov 2022 10:06:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7BCFEB0
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 06:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DCC361283
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 14:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BC7C433C1;
        Mon, 21 Nov 2022 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669042586;
        bh=lN3WiyCSFkx9bNH+75K9GqZBswWyTeYBY401AIUHo5Y=;
        h=Subject:From:Date:To:From;
        b=DgHCVsR77G1fKFL7m5DY5lUhKKdDIAdr/gYavhUDLygpU1aUaAuq0PWVWss87aWY1
         yuc+JEQ2TEceQTJiU21UESO4YyqN6nxVPjmNueJJpbYM6gDhyLIAqY2Uq0G7S5j4P4
         h9ZjGrdKTq9NuKeew0+VDkjDVhVsibXYrODfP7ifkIT2IOpeX2H2j2kY+iUBmqljHf
         StCKqcYpB/c1AaBDhLXGdxuIaYFlkn27VtF32Dlk8xJCE/ALFw/NG444Ee//SbCP3A
         fRYyhBkkwqRulm7n7a5uXer1WVECslUhPefHgJKskmkNUOECxN0BFdZQ/XBNv5w8UM
         GdFawAmrGSEPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69BDEE270C7;
        Mon, 21 Nov 2022 14:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166904258642.9970.6407564558034982283.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Nov 2022 14:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-geni-qcom: Add support for SE DMA mode (2022-11-21T14:19:33)
  Superseding: [v1] spi: spi-geni-qcom: Add support for SE DMA mode (2022-11-16T09:15:35):
    spi: spi-geni-qcom: Add support for SE DMA mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

