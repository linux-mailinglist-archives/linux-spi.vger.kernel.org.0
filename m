Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8C47D629
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhLVR5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 12:57:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48430 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbhLVR46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 12:56:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C0D661BB3
        for <linux-spi@vger.kernel.org>; Wed, 22 Dec 2021 17:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAF03C36AE8;
        Wed, 22 Dec 2021 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195817;
        bh=XTTG+wrzTFin2pafuxG1ZFhKGUVFnGRMUy3t98RpxwQ=;
        h=Subject:From:Date:To:From;
        b=AxFBnzD1XMrhEUSFleGAeGD9ETKfv15I5XojFnB4/ukfPS2pq+vfk05EJ6G+Cs6ne
         nJz6jRxXPusMCzKSDgr8c1nX/LQjACTU+CdUKXREZnRhyBjn3deLAcRinoNd5QlGLK
         8V1izHxlsXbB/2PLgysGFMoWaZ1o9e9LmxNBOzISSTxG6l6mHvwCmr2peio/JAasca
         ey//z+1ORUf2cN+GP01IFdSOvxOVCaFCBOYnEFU7+VOd4tcMBHRj7xtc9Jlr6Lu/Xf
         6jbtvtDp+JaDdHoKOFncy+dnh9XWbtCOhYs7N3dVnv4nV9BN/1zoJc5dw3VPygY+zQ
         5jrh6hFx96X6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98583FE95A1;
        Wed, 22 Dec 2021 17:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164019581762.12388.12195952794313556150.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Dec 2021 17:56:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dln2: Propagate firmware node (2021-12-22T15:57:39)
  Superseding: [v1] spi: dln2: Propagate firmware node (2021-12-22T13:54:23):
    [v1,1/3] spi: dln2: Propagate firmware node
    [v1,2/3] spi: dw: Propagate firmware node
    [v1,3/3] spi: pxa2xx: Propagate firmware node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

