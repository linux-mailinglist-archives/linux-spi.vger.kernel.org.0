Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F748C293
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiALK4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 05:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiALK4Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 05:56:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E8C06173F
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 02:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BBF61722
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 10:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AA6EC36AEA;
        Wed, 12 Jan 2022 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641984973;
        bh=DLmrbhUjrJ96ey6BRWMsxsj+hC6xtwkMhtTazhIHqCQ=;
        h=Subject:From:Date:To:From;
        b=ZECvPfrUpVGRBFutIK9g+HrrAg/D5WFyMVMmbTXmnNnsXYAxO5KsfGCK4oM6SZbrM
         tprD20iY3E9yodj1dSFKUasWMxJuYSwlc5i4mjhTEJ5UVToyAJaswVPLVHzm7EcVnH
         od7NtJBNEWeWfpw1XgroEGz56zyWO363QZ98gBq2jBiFQ7amDPNtfmlNMLo8B3+hvA
         cAMsnDP1G8xJTIJIdgtfeVF0b1CV62QSnHkHOmQt4rLoDnWK1bJe2UqRtMADX4gWip
         K9EN8gdywWmM9AKpk1P38NuMMF3r+lG7SgSd3s3hNjvXbaVkdhj1LcEi2r8m8lLMz5
         8Y+mZH1Aei9JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7463DF6078B;
        Wed, 12 Jan 2022 10:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164198497347.19709.17014403398913242581.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 12 Jan 2022 10:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: dt-bindings: samsung: convert to dtschema (2022-01-12T10:00:42)
  Superseding: [v2] spi: dt-bindings: samsung: convert to dtschema (2022-01-11T10:13:35):
    [v2,1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
    [v2,2/4] spi: dt-bindings: samsung: convert to dtschema
    [v2,3/4] spi: dt-bindings: samsung: allow controller-data to be optional
    [v2,4/4] spi: s3c64xx: allow controller-data to be optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

