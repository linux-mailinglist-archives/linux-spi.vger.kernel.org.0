Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949AC3A0A58
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 04:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhFIC6k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 22:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhFIC6j (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 22:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AB2E361182;
        Wed,  9 Jun 2021 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623207405;
        bh=LjCx/H6qh6Df6mkhy4nie+vovpue2NoR06HYwA/OxB0=;
        h=Subject:From:Date:To:From;
        b=Pq3LQF0PCRl+dPNYz3JZ0QbOAyNAb0m1Kp9znpDsCAJPCHvaYpX3ekssuAtUGDqDf
         nzSh7PFLe2Nq8OaC+U5Q28dlPxL1Ktf+Te6vmTNxEic7E+qDbc98G4RGoIAUMzG4tB
         6OBepJ6Tz4+NW6KM7KZRl8s9Ioj1xv186CbTjV3VmyVXCUheEz/m9S8PsoEGX6CIlg
         3Nm/Stf6IAFU4kKZdEkNRnS9am8r43bJd45q2KhOweYtfc1TaQy9Xov3UFsofcfD6K
         pPFC903iHIMdXGQ/5G4f3y7kP/FbyDJk1Wswb6VNNh+gOLGrW5K8bIMxHHSuK2A11M
         SoZOM7I+tyxmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A193360A0E;
        Wed,  9 Jun 2021 02:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162320740565.15309.13200399279318630380.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Jun 2021 02:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-at91-usart: Fix wrong goto jump label when spi_alloc_master() returns error. (2021-06-09T02:48:14)
  Superseding: [v1] spi: spi-at91-usart: Fix wrong goto jump label when spi_alloc_master() returns error. (2021-06-08T15:14:07):
    spi: spi-at91-usart: Fix wrong goto jump label when spi_alloc_master() returns error.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

