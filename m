Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27246544534
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiFIH4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiFIH4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 03:56:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8882F0
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 00:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC03DB82C43
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 07:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BAA8C34114;
        Thu,  9 Jun 2022 07:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654761388;
        bh=mzq6TwRjNHGZf1ppI3/K91RXmvXLmv/EPAWRtbvykNQ=;
        h=Subject:From:Date:To:From;
        b=lV82aE4D6+rrLYqCWQ9pVPEe4igOtZVA7aCGLpcDHPvGAZ5ZGuPeiVBqoSSGJWTNB
         eogYaRV/2hRhtAUr/0WArrLUFm+k1cifsEj6ckCpcqlYekErqQaX8CsB6rREd86w4F
         cfPtF0I4GjqYUzR8GkyL23rPWFwvNil9g7fFBSYoNk6B7qFTKFs9qLjjcGMAYa65mu
         PKympU9XJd3o4VYNkyPnmdjZ88ofVUxhPidIalFPEnmyQD5zreyG+KA73+Q59FSKOs
         Wz8L0nWeoDOX/7tTeIttmh1mwgp+VElrEqt3oHGpidLN6OrFgnwTbwFi/tKAkOBhWO
         uq7cHDhMfAvWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36558E737E8;
        Thu,  9 Jun 2022 07:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165476138816.13738.7332721142654316160.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Jun 2022 07:56:28 +0000
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

Latest series: [v2] spi: Return true/false (not 1/0) from bool function (2022-06-09T07:12:50)
  Superseding: [v1] spi: Return true/false (not 1/0) from bool function (2022-06-09T06:03:23):
    [-next] spi: Return true/false (not 1/0) from bool function


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

