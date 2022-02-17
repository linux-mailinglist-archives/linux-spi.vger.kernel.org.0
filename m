Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AAB4BA3CD
	for <lists+linux-spi@lfdr.de>; Thu, 17 Feb 2022 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiBQO4n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Feb 2022 09:56:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiBQO4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Feb 2022 09:56:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57CF1017CB
        for <linux-spi@vger.kernel.org>; Thu, 17 Feb 2022 06:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2E661E50
        for <linux-spi@vger.kernel.org>; Thu, 17 Feb 2022 14:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F5CC340E8;
        Thu, 17 Feb 2022 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645109785;
        bh=rGNMg8IF/XrPNCqAJX0hc9UcrivvOnapuDUfVxMt2M0=;
        h=Subject:From:Date:To:From;
        b=TaCEoCMN8BXG4kh90pOVBuGiLWiIoWZyMCVkdSQDFqQ7DJNeQnF2xrDZCmbcY8dmZ
         V7+jESSxw0DB3UtRbvtvSvm+ejYejjW9Ia71EEgQ7cJTjlhazO/pKT2M4cqmlQsOI4
         bYXsQwwC9x2HfyFM2YPlY0yFj+alfRUi9g0U/2v41dAgkPeZCTQmYOcWTAHhHByypL
         Sov88+5zvgE+LCqLiYEdHN1cEGB9qrGmXFaFK024u+HaJedTwiYVIcL+Dmxj4VGdBO
         chjFMgu2QLTKQXI5gT3ZEw9lgw1x1oHax3r4LMyRQLL+szzMtvA6ru4QyGu7G98Zxi
         4bNJQDJgRaCJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE806E6D446;
        Thu, 17 Feb 2022 14:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164510978489.12727.5394164795579899695.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Feb 2022 14:56:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: use specific last_cs instead of last_cs_enable (2022-02-17T14:12:34)
  Superseding: [v1] spi: use specific last_cs instead of last_cs_enable (2022-02-17T13:35:08):
    spi: use specific last_cs instead of last_cs_enable


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

