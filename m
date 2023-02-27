Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9251C6A4C8D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Feb 2023 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjB0U4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Feb 2023 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjB0U4U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Feb 2023 15:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A625E01
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 12:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D455D60E8E
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 20:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44FD7C433EF;
        Mon, 27 Feb 2023 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677531376;
        bh=ZYX/2y8rrgmsRt4jm1auu95IwEFvNF8yvMuELj4pULU=;
        h=Subject:From:Date:To:From;
        b=S/+gwT+xxD6inNBXRKp8GMzDpjizNoYCCNRXDuynOJ3teY7kUTaoNuB3Nf8SIN3AR
         tpmP+j1YtYvYKCzPc0TE9B0CPTMVlW4aCdBFa0dHKRT5/5fnA0qFUZzZLMkm3yCRll
         DN1+Bck/HHNvlIQFngPzBjbOGRUMWh8b5ja3ZfGpQdCtqQyc93i3vndimp7NvCLWOF
         nWzMBbVyB80SGnP2qZHxlrv5l6s09xyf1JwikDQhLL5N2v1oo31dZJXAexCTYlRIT1
         jO4iiNKOj+5tEQamdRhiuZL8oOKqKdO5bZxSaFLTDKi0PWVGLPOQnpiprrSEyCPon2
         UZ2112nL3lQ9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A869E1CF31;
        Mon, 27 Feb 2023 20:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167753137617.19630.7926673449693011961.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Feb 2023 20:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra210-quad: Fix iterator outside loop (2023-02-27T20:04:28)
  Superseding: [v1] spi: tegra210-quad: Fix iterator outside loop (2023-02-24T16:35:13):
    spi: tegra210-quad: Fix iterator outside loop


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

