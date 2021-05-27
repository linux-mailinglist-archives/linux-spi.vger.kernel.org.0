Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA98393874
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhE0V63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 17:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhE0V6Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 May 2021 17:58:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0576261176;
        Thu, 27 May 2021 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622152612;
        bh=CoCJQdTwopoNPMqlvwImUbdTixT9OCf7NUZ4GONwGhk=;
        h=Subject:From:Date:To:From;
        b=gHvB0nBogqChRAoT2/Dh1gBbZgVJi1ZIx8dw0OcIyUnYcGq+aX339QfPMR/45HH6/
         tdgM3/S97pAs999f7e4FgnwXXG9HfMXRLOQfcerP8kB+t6iQ8pFO/moQgPOIdWPW3z
         M4plC3lcg7XJh1wIhIOYujj3DrTbFpKOzkAEVZsV/roEW59GcuafIKGnwRQHVAyjdV
         v3oWzwj8qKOF7W7yKJtm8nVEY/majmNY57oqXtfVfcGzP1sywMjAxeRHbYiikJodZf
         HFzDdLSxhjdEpp0Kuza7GfdbwAMVnUmX/4g8964lB1nO9HDwk+8imil79ianooDC4h
         B7bLgmRMpAQmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E5B27609F5;
        Thu, 27 May 2021 21:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162215261188.23798.11837878200784297679.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 May 2021 21:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm2835: Allow arbitrary number of slaves (2021-05-27T21:32:00)
  Superseding: [v1] spi: bcm2835: Allow arbitrary number of slaves (2021-05-22T19:29:42):
    [for-5.14] spi: bcm2835: Allow arbitrary number of slaves


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

