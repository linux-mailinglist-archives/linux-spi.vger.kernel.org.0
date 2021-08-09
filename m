Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE63E444B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHIK6h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 06:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhHIK6h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 06:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E745D60EE9;
        Mon,  9 Aug 2021 10:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628506694;
        bh=4k7CbORLBKYqFoqbm6RQ5/RTrZkVyNZ3szVI7lRIuOo=;
        h=Subject:From:Date:To:From;
        b=WnQVlVR3bCAZ3Em73qcZGqj0foZAYBUojs+/VApCxZGbUslnjz6zBvXXbK1UdVNuf
         yIgn7brFcATLyrs+8Uull23BiqaQ+8xEarHwmx4+/mSz2IxfinBY8FrXMTneZpluea
         cln4xBou4hMKGHw1XzwBTrzBou4itYUINSayCddIQUAgjmlCfGb7H+6dpUhixnbE8W
         ehslthXLpQOmdWr4a4FhV4BrtmscgLTlyzh1fso4MlfDU7B4ZMPgE7jFHAFrLAveRl
         nbUmSot5adBDprC2ywykzL9Jpfi1Qhr+Gb21Cblb5yeCk8T877HZ2khxpbsrvsFqqH
         EzTJ9EZR3j4Xg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D810B60A24;
        Mon,  9 Aug 2021 10:58:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162850669482.27636.2413163522026903489.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Aug 2021 10:58:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: mxic: patch for octal DTR mode support (2021-08-09T09:39:23)
  Superseding: [v6] spi: mxic: patch for octal DTR mode support (2021-08-04T05:27:07):
    [v6] spi: mxic: patch for octal DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

