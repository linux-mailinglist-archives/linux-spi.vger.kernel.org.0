Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3805B42BF4A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhJML7E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 07:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJML7D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 07:59:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6D8461040;
        Wed, 13 Oct 2021 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634126220;
        bh=GRPL9A9+Ao8fqih1Q0NhsHOS+ORCsxskEpxuUOzTEkk=;
        h=Subject:From:Date:To:From;
        b=lrZWz70VGyGanavEX2PWu5DAJCpVIQCsO8NBMO5KUAxDbWWW6r0LBNyUvShJIWXwN
         vPuLMG8Y3fkyoZl9VOh1GpFHbsLqy2SzcWW+h3M1YPiSb7kq54pDHYCypnF3f3Oeci
         NOUSNoD5Q373PwO/LEdSKWA0742KlGI7z3WbDChhUMssmC/31ycLvu+aRQ4vU/uFf+
         TJHnsoA43zc4dcHwpXhqKlBsEHA4NuYxwwbNlk+ABHatd9iezO2+Ly5ZrIozAldz7e
         3eWib7425Kqhy9kySXXTdUQHKUaZYdpsFGnXUcFQ1IgrTMq/2eq1wRvE3n4Gu1WNhm
         d6JTvVBDuyOXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B23A760173;
        Wed, 13 Oct 2021 11:57:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163412622067.11099.18222061443718730460.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 13 Oct 2021 11:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-10-13T11:44:32)
  Superseding: [v2] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-10-07T11:21:29):
    [v2,1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
    [v2,2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
    [v2,3/3] Documentation / MTD: Rename the intel-spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

