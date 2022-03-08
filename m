Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB24D1872
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 13:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCHM5e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 07:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiCHM5c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 07:57:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7447AD3
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 04:56:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24D6CB818B3
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 12:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C84AEC340EB;
        Tue,  8 Mar 2022 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646744193;
        bh=ZWcERKwtFng7Dj9BcSwW42OljclOsv7AbvXK75Dr3gE=;
        h=Subject:From:Date:To:From;
        b=X6lpjOojpqv5Y99NhXi6BvAXZy249YSsWFcUvz0aSLzMCyMUSGcR10H6bilCjaWHM
         nKOp5oaeFPsFtRlF1+VqQJLHNMZyxbHtUtovBcVtyyDyLQxNMJ0t/eFyBeriOqsmXM
         ycn9HWHrR7HcrufKEdoBltJfMdLbOSVqNQXalpUTSyX6TvJs1o+iEA4F9IW2NFyKqk
         a2jbn7P3xX6f6qRln9yS0OwJ5+jUtcn2fgf1JXT9w55aBl63ue/mvKWK/Po7HiiOdm
         1ONOg2mtbpNpfj7Y1yIG83jjxYG5zCkPuirfJTow3Zj8uTad1c0p0Qzd1XEgHX1klR
         L+6Fk9AU9pJ3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE383EAC081;
        Tue,  8 Mar 2022 12:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164674419370.16854.14747410248620050905.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Mar 2022 12:56:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: dt-bindings: samsung: Add fsd spi compatible (2022-03-08T12:16:39)
  Superseding: [v3] spi: dt-bindings: samsung: Add fsd spi compatible (2022-01-25T03:16:02):
    [v3,1/3] spi: dt-bindings: samsung: Add fsd spi compatible
    [v3,2/3] spi: s3c64xx: Add spi port configuration for Tesla FSD SoC
    [v3,3/3] arm64: dts: fsd: Add SPI device nodes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

