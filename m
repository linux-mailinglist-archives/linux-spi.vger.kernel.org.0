Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84C204FC3
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 13:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgFWLAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 07:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgFWLAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910008;
        bh=gWXEp9lmL2MYEbbcra5C7UFVCy70ePksHRFcy3u19hw=;
        h=Subject:From:Date:To:From;
        b=GuVr7VV2E/zPpsZmXo4pPmmVsK2gcU7bPJAURSBTN33H7MESamCcmD83YKPp2XuCm
         5gnKAoCxJa5iaOh64uI4wN7hN0ZFmvpu4bZlFyEVD77ivuVQakgcCfP0wXU7TOSzyH
         yGJQVrEjTsLuShme3GAzQ1MPbX0hO4PWH12reFIU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159291000862.29556.11678514589815795425.git-patchwork-summary@kernel.org>
Date:   Tue, 23 Jun 2020 11:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Some small spi geni cleanups
  Submitter: Stephen Boyd <swboyd@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=305923
  Link: <20200620022233.64716-1-swboyd@chromium.org>
    Patches: [v1,1/2] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
             [v1,2/2] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
