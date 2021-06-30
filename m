Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACB33B8293
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhF3M7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhF3M7Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:59:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 65969613F3;
        Wed, 30 Jun 2021 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625057807;
        bh=xy4BF7fGcgP/wKfHrVrmld9OYQuItbVZZcXfvatL0rw=;
        h=Subject:From:Date:To:From;
        b=om+tMiHXkFKHmH0f0CFh4Mj/immS0QVH8FOzarZQb7LT9dydsqZ0NB56ToLQbTiTB
         vDQlYnX/LX2FJTUWS3AshaxK4AIxE1Ug44X2Zwgip/klU8ik0jt3EaX0K7YZdoyJSE
         F1b5/+1pD7fybWKwsH7BOhhHwHaNaVQyLvLpYjH2DU6jPDhJ3A4MQWlCJ3kqVURPnF
         qkIg1C9kRSQzL8bTafzqJ1p1uKOHsT/s4tSLL3+uRrDDtbcpYIWydOeHAxbBwSH9so
         wKKrQkE/LjWijBagZKqUrfPhXRi2M+9Ff7NOouWWurtu1fRc8gcUCduTty/+84MCNG
         snoQBE1H2bjmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5600960A3A;
        Wed, 30 Jun 2021 12:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162505780729.31386.2731904933150359357.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 30 Jun 2021 12:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi:amd:Support for new generation of AMD SOCs. (2021-06-30T12:04:22)
  Superseding: [v2] spi:amd:Support for new generation of AMD SOCs. (2021-06-29T16:38:32):
    [RESEND,v2,1/2] spi:amd: Add support for latest platform
    [RESEND,v2,2/2] spi:amd: Fix for transfer large size of data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

