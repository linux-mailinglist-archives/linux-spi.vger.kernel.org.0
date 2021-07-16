Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F43CBB0B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhGPRXA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 13:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhGPRXA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 13:23:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EF70B613D8;
        Fri, 16 Jul 2021 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626456005;
        bh=v3Ki9KkR82JgrzU93CeDYmQU0NF6Cbz6m3EbElqQjaE=;
        h=Subject:From:Date:To:From;
        b=iKRszPyTCVZ9QGEF4WNHN4i74RrhP0MXrcTP6WpwuodcQ55zaiLn8OjG0gqA2cc/W
         avh3+pM9chKEFRfAPTgc/XhBwnB78V1LbhP+BZ7aKxInjhPHoeoowjCeeNbumA7RIb
         bdLvuxbjPwM7BcPg1eaiDTMRk7MyK0TRBP09vO6viLQfS/drDd2CBuWoZkKAM+ooK0
         4iyeL2P4duq3a8zq6E27tCW33TMFGHKCKWuIvDc0N9AvTinK2iNfoeWOzYUdoG81zp
         9YqdNqrvfr2SP4fxoBioeAF1TNvFaEWL7mwd7a4AohLio3bVmf20ZldgEwc2LxZBNh
         F84AZj3B2ihKw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCBF7609A3;
        Fri, 16 Jul 2021 17:20:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162645600484.18050.3922350374740741148.git-patchwork-summary@kernel.org>
Date:   Fri, 16 Jul 2021 17:20:04 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: spi-cadence-quadspi: Fix division by zero warning
  Submitter: Yoshitaka Ikeda <ikeda@nskint.co.jp>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=516729
  Lore link: https://lore.kernel.org/r/bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp
    Patches: [v5,1/2] spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
             [v5,2/2] spi: spi-cadence-quadspi: Fix division by zero warning

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


