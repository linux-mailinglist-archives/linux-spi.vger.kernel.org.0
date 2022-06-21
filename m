Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150B552B5A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiFUG4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUG4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087B91CFCF
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C62C60B7D
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0619FC3411D;
        Tue, 21 Jun 2022 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655794591;
        bh=Ytm6Ke3QiUMQEdIrRuvWvFkqe6b0vTz/GaQaFKlTk40=;
        h=Subject:From:Date:To:From;
        b=GRNEbzEaaixZKMuEPyFQIg5gqY+mLwpLVD3ALqcUcD9MWkYDPD964ibuP5VvmyS/T
         LeGavSBDsdP9VGlgwqdNbMzE2N+VAVFG12AGKyrrTgrTYrlQQXZFMD2F8GEpIwogRZ
         2uebdnRDD+ITNLGOJJk7sWDHj3eS24agTXKpN0nlXYr9O8lob+Y8eSn6uf+x6LwhZk
         dFWa0gg9F8DCY6kRFnncxYoNzXHdtYwtB9B6qNFFiTYke5sOeO1kDlp6eEXou5Ueok
         sVrLXoVc3emauJVV5Sak9AOwwJnVjmVM+0FhNflbUBZ87jwOA+M/6MrxhNFfHqviJe
         7aastSaqCeGhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4A79E73856;
        Tue, 21 Jun 2022 06:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165579459081.25801.7986346731425103128.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Jun 2022 06:56:30 +0000
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

Latest series: [v3] Optimize spi_sync path (2022-06-21T06:12:27)
  Superseding: [v2] Optimize spi_sync path (2022-06-15T12:46:29):
    [RFC,v2,01/11] spi: Move ctlr->cur_msg_prepared to struct spi_message
    [FRC,v2,02/11] spi: Don't use the message queue if possible in spi_sync
    [RFC,v2,03/11] spi: Lock controller idling transition inside the io_mutex
    [RFC,v2,04/11] spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
    [RFC,v2,05/11] spi: Remove check for controller idling in spi sync path
    [RFC,v2,06/11] spi: Remove check for idling in __spi_pump_messages()
    [RFC,v2,07/11] spi: Remove the now unused ctlr->idling flag
    [RFC,08/11] spi: Remove unneeded READ_ONCE for ctlr->busy flag
    [RFC,v2,09/11] spi: Set ctlr->cur_msg also in the sync transfer case
    [RFC,v2,10/11] spi: Ensure the io_mutex is held until spi_finalize_current_message()
    [RFC,v2,11/11] spi: opportunistically skip ctlr->cur_msg_completion


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

