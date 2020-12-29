Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B32E6DD4
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 05:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgL2E5Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 23:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2E5Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 23:57:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 613D9207C5;
        Tue, 29 Dec 2020 04:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609217804;
        bh=Q5rcjBQ2c3CTE+U2GoSAaNQudmeRU3zHEDkW2H+WGgA=;
        h=Subject:From:Date:To:From;
        b=AeY+GgcwMGqNd2UrEzBxj/vTgqKjYPE9mAHe8qv6xrzuorSvwxo25PkXWsk0Obtq7
         cXBPV3T02KuZjEeR71Hd6z5TTxPM8QWxoV+xb0f2Qvvm3+GuiTeaJs8Gl/ppD7WZZY
         GYoD6QVnD4YgGI8ZNahf9u1Z7rW0c5wyeaUfjTv7PnhwJ9iBiLK/iSxV1YLS3KMHGh
         uefjy9mJKo/y8YgzHommSnPOr/4INbcWSJG2YHxYFEDCMgOyd74EA2BNxP2dx059p0
         siWAVmzfR0VibBJpaVqfRlNtwB0FskCvpFiCaNV3M3/MBsk3fk8pkLykBvUBqAXnu0
         fYom6MrK/1qTQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 48E78600D9;
        Tue, 29 Dec 2020 04:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160921780423.8991.9506677216553492492.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Dec 2020 04:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix regression when the SPI controller does not pass max_speed_hz (2020-12-29T04:04:50)
  Superseding: [v1] spi: Fix regression when the SPI controller does not pass max_speed_hz (2020-12-28T19:32:50):
    spi: Fix regression when the SPI controller does not pass max_speed_hz


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

