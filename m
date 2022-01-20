Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B949547D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377357AbiATS4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 13:56:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36056 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377374AbiATS4Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 13:56:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5912DB81E28
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 18:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC56C340E0;
        Thu, 20 Jan 2022 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642704974;
        bh=DcYa8XDS6orcWfCAUCqZf5Jljz4pxXTaBGgKAEmaTQo=;
        h=Subject:From:Date:To:From;
        b=plyfui58rZCiiYpplElymw9nnTSA4oCGOpOl5mgB8KNLxV8Xh1Q0A/KwIYI2XFaBl
         RofHryYNKcqcQt5MmDsyfPHjH2HOEmty+rzlfxC5Uu7fiWKH/tKkD5tv4/ItlDQ6OH
         fb9AlV3SFWCYoS9gEbjcZhTRpRUFk1Fuzb5DBa4iwH44HSpU0RmOJda/RBbLLf04yG
         iv177fWoxF5c0EXU1iCDy+/TKJjs5XhlUXHY9f0ScjJZnEapTQfSOvmL35nhYPP8sD
         bjym8RHRjIU5YirAwx66JcYJJ7c3ESBiGYZDXdc+bxZW6u+x3Ium+tE5Zy1o0ahC0O
         //qy2YoVDZG2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8B3FF60796;
        Thu, 20 Jan 2022 18:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164270497365.25930.7429697423670669163.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 Jan 2022 18:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: dt-bindings: samsung: convert to dtschema (2022-01-20T17:57:43)
  Superseding: [v4] spi: dt-bindings: samsung: convert to dtschema (2022-01-19T20:10:00):
    [v4,1/5] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
    [v4,2/5] spi: dt-bindings: samsung: convert to dtschema
    [v4,3/5] spi: dt-bindings: samsung: allow controller-data to be optional
    [v4,4/5] mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
    [v4,5/5] spi: s3c64xx: allow controller-data to be optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

