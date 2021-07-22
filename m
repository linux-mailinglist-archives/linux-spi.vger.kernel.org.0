Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0B3D2B8D
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGVRQE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 13:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhGVRQD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 13:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 761F361409;
        Thu, 22 Jul 2021 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626976598;
        bh=yRg8lq317PtISGZseG/PP682bCOwrcayRdM6HYNdvdk=;
        h=Subject:From:Date:To:From;
        b=GMKUFWMsoyhn0IXU3G+8cX6XY3Ogxb5/z0t4gMPYnqGQ4FqzZ4OiIOqX1y75PwhvU
         nikkVIcVY+zkFWzc4fG1WYuh/RbyB+eNzX1VUhJakpc8iCTsDjc2mKDV6HPjXF/zjp
         beJUbdBksjUiWU153c44PaTHvE3MF/VNnqryv4lQNYgVzui4NrRh/idG8EiDzWjCrX
         qmzNPUONRSrde3SRF+b1VkPJk22U7PrOgdC8qboB2l7o14MITLmjj72iUEACV3RaEd
         w8Qo4zIJ3pb7Rci3YLpYoiDgBaersxwBV7YIQl9gX6Ay1vCHXLtgHcLJWBXpmQ6L6N
         ah2CaWLz/g4hQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6A865600AB;
        Thu, 22 Jul 2021 17:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162697659842.3429.10358061976721283087.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Jul 2021 17:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: update modalias_show after of_device_uevent_modalias support (2021-07-22T17:07:29)
  Superseding: [v1] spi: update modalias_show after of_device_uevent_modalias support (2021-07-22T13:48:45):
    spi: update modalias_show after of_device_uevent_modalias support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

