Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDD2DD6A6
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgLQR5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgLQR5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 12:57:32 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608227812;
        bh=YGwhc187CDjxiT3xpAuFDHLqiY4RY9zZkFYG/OEn9lM=;
        h=Subject:From:Date:To:From;
        b=OUzHEKkCmpaIi9OVakFuA/MvQfizx6RkeB5SswvHqUVc7IMZpV8g+2K0EfWU/fjl5
         1uDq3hDTdLjDHFi5P5YYd82Nxyv5ywwSd29eiKuJ887ySw0C3soEKfmmd5A1TBG1Zy
         o5Pmsv4+iO9AfScj6GCBRPAYFaEK6oeSzo9x1XT5xhAHf0xf2gZRL+iNXRvMAV6Rr5
         AHmdbRr0M1RC1JzkUzAGkv6QH6+lCb6frHTXtYdkxbyorkgR0S5JP8qUt2LwTQkMeu
         nPHG7vdfaxou63tB55tKIVjGXSygQeC4AsMrOTyLiKQw/tQ9g9Ng/U1iAwtAEgFerP
         J+/qRQqYIG00A==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160822781187.5318.2971247797090387496.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Dec 2020 17:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: new feature and fix for Marvell Orion driver (2020-12-17T17:09:30)
  Superseding: [v1] spi: new feature and fix for Marvell Orion driver (2020-12-17T11:27:05):
    [1/3] spi: orion: enable clocks before spi_setup
    [2/3] spi: orion: enable support for switching CS every transferred byte
    [3/3] dt-bindings: spi: add support for spi-1byte-cs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

