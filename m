Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD649ABD0
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jan 2022 06:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiAYFij (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jan 2022 00:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiAYFge (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jan 2022 00:36:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79EC05A19F
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 19:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6380B815FC
        for <linux-spi@vger.kernel.org>; Tue, 25 Jan 2022 03:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6CDC340E0;
        Tue, 25 Jan 2022 03:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643082974;
        bh=bDrnNtosYL2MGdA1macY8Kmno4s24dJe+nuPVe1LthU=;
        h=Subject:From:Date:To:From;
        b=J9Eki7pulLiTy54tVYhmL0NaO7OwBA7ux+KtUs5wDRRkJF97BZJoaepwh8lAoOO/N
         B7O4tCYYAzfrPjS+KtDaoMaQrq6vhWw43/FRtvLoQOkmvnTtGxvqX0kon5SSzdz9sL
         oZYOWPVIn9LheCuLh8KcXtuQ5bHPm5q8RlA48zOjd3ZcJlAAu4rzCL/9aI7UwoS3cC
         +V78O90NnKIf99uYUHtC8EZcGJ09r6viWEc3NugYmUuKfq9OkgDT+VWgdRLpmF9CQT
         AoL9UGN35RgEHSAckCsgI//uXCE3nOOUIv8ZafVKls9NACI0Z30R/xdNtG9VFrKBHq
         4kwmBwP5yuBxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA9BF60799;
        Tue, 25 Jan 2022 03:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164308297436.31130.12120591290549515417.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 25 Jan 2022 03:56:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add compatible for Mediatek MT8186 (2022-01-25T01:23:30)
  Superseding: [v2] Add compatible for Mediatek MT8186 (2022-01-12T10:36:06):
    [V2,1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
    [V2,2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
    [V2,3/3] dt-bindings: spi: Add compatible for Mediatek MT8186
  Superseding: [v3] Add compatible for Mediatek MT8186 (2022-01-24T06:12:36):
    [V3,1/2] dt-bindings: spi: Convert spi-mt65xx to json-schema
    [V3,2/2] dt-bindings: spi: Add compatible for Mediatek MT8186

Latest series: [v3] spi: dt-bindings: samsung: Add fsd spi compatible (2022-01-25T03:16:02)
  Superseding: [v2] spi: dt-bindings: samsung: Add fsd spi compatible (2022-01-20T19:24:36):
    [v2,1/3] spi: dt-bindings: samsung: Add fsd spi compatible
    [v2,2/3] spi: s3c64xx: Add spi port configuration for Tesla FSD SoC
    [v2,3/3] arm64: dts: fsd: Add SPI device nodes

Latest series: [v2] spi: pxa2xx_spi: Convert to use GPIO descriptors (2022-01-25T00:58:36)
  Superseding: [v1] spi: pxa2xx_spi: Convert to use GPIO descriptors (2022-01-21T01:20:14):
    spi: pxa2xx_spi: Convert to use GPIO descriptors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

