Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64953B6A9C
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhF1V7M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 17:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236820AbhF1V7K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Jun 2021 17:59:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CA3361CFC;
        Mon, 28 Jun 2021 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624917404;
        bh=X42gVPqeC8jkhD08s+cTz/RnChiyexKkf1RUQuGWK54=;
        h=Subject:From:Date:To:From;
        b=RwFDIDEZBRG3U04+qXI4YL0Yq6SeyCM+cwPTkdLDhQDV+7bxZxf+lCycl91NbsOgV
         8Y3sUawWR3ocuWZDOiss7kF0Pz2LCE/9owFaV4AF01KdUGT1u9jeHCt5oy5aotwq4i
         NAHrEWKZTeFhO4J+d08rOIxB0tod/8FmgiOSGDGToi6OrA+01leGv0VREjd4UGUgy1
         0w9FcRPbpHJLqgTz0fjSGznABELVfMO+hl5nUYgmPuPBwXDPLYU9clA9ZfsKQWq03K
         eZAGAOnBn6oY14Oaujb4LabbNlu8ApUgQjnR+0Gf7qYCn5uu3LaUC+Pb9xawTULZLi
         drNrm466cE9dw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88DFD60ACA;
        Mon, 28 Jun 2021 21:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162491740450.26935.3676045145727536064.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Jun 2021 21:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry (2021-06-28T21:05:20)
  Superseding: [v1] spi: <linux/spi/spi.h>: add missing struct kernel-doc entry (2021-06-28T00:40:23):
    spi: <linux/spi/spi.h>: add missing struct kernel-doc entry


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

