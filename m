Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6551B494223
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbiASU4U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 15:56:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbiASU4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 15:56:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 281CFB81BFB
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 20:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C15C3C004E1;
        Wed, 19 Jan 2022 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642625776;
        bh=ZVCRuE+Yz8v4YOrFQAAWKethC4JlpmaqtGfZKKiCGGA=;
        h=Subject:From:Date:To:From;
        b=NbeC1xzE84qxKaGfM+SXIL7FBy++gg8O+5JWKCTdU4y+K1g3QewnxwNXwf0m+WZ0u
         v/Bw9SlZ02MtYH291H0mObBD03cMqCkHr1TfASQdIdBbOgX5+Fh0NErkTgC6ReO89D
         zpQl/C3gZUBaBZ4KtL6Upg/DnBBxypt+5HMjLxhCzLs67jjiN0LOfJUyY5GZmIV/dJ
         ylp1g4MxKdG/dWLaRIdH5BVBNLZ6G0wa6EKRnVvMfqJGR2Ay7MADGWs97BlHDa5nnv
         7q6lzIrfYC/Vl6sOThyRstJmoaRv64FNG35FE61PuUINfb9tIBLUyZBoYvxiHiiaXh
         P51WGA4JNZyMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFB16F60795;
        Wed, 19 Jan 2022 20:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164262577671.20433.14197135121778912547.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Jan 2022 20:56:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: dt-bindings: samsung: convert to dtschema (2022-01-19T20:10:00)
  Superseding: [v3] spi: dt-bindings: samsung: convert to dtschema (2022-01-12T10:00:42):
    [v3,1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
    [v3,2/4] spi: dt-bindings: samsung: convert to dtschema
    [v3,3/4] spi: dt-bindings: samsung: allow controller-data to be optional
    [v3,4/4] spi: s3c64xx: allow controller-data to be optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

