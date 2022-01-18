Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4D49317C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 00:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346581AbiARX4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 18:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiARX4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 18:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C61C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:56:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B346761486
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 23:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29183C340E0;
        Tue, 18 Jan 2022 23:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642550171;
        bh=VyqY6VG7YI6QmXgslbZcD164sXLalU3c7A3uwz/bud0=;
        h=Subject:From:Date:To:From;
        b=jyfRG9Co8V6sSIOh7HaVqyY1WXOCY/Dxi4jTOE3L50dEs9E25iJoU35rOrw8LpgB3
         Dv/gqiF7zE4FkDfqXAuvdvRdX17sldXpk92G3RB0k9S5HGMSNFNyDXK40s769tl8jO
         LUbGjngw1QlQkBV/PvfBbJ0kc5fWfSywyNllKmbJfnCXtZ6mCItGUja22HtzQ9iqMc
         0aoEegbHgY6w1ZVhTWLSdHNDrV5V5ua6+beNAG+hLCal2oMit0nm+XOf0Vjf+uoAA/
         pJfIjbPwXRh0dNTdzNuF+kRyw4Y5Rgo5aRxtbsQiBd0GhuGJsWF91KeDcE9fzdYnpY
         Kep9FHQFliqKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 104C6F60796;
        Tue, 18 Jan 2022 23:56:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164255017105.14779.3676569047335920439.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Jan 2022 23:56:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: s3c64xx: Delete unused boardfile helpers (2022-01-18T23:09:13)
  Superseding: [v2] spi: s3c64xx: Delete unused boardfile helpers (2022-01-18T11:09:26):
    [1/3,v2] spi: s3c64xx: Delete unused boardfile helpers
    [2/3,v2] spi: s3c64xx: Drop custom gpio setup argument
    [3/3,v2] spi: s3c64xx: Convert to use GPIO descriptors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

