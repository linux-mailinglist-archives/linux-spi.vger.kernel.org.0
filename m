Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6368821A2E6
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGIPAU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 11:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgGIPAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 11:00:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594306820;
        bh=w6vF5o45btek5BabCxCPGw68qHvD2b/lXsAHVNYchYA=;
        h=Subject:From:Date:To:From;
        b=O86g//YMNOhKk/nRfl08OtVPn8eDGLMwoY/WIQhynaNil59AwVtRTPdIA6zhUiEYV
         fgkOaHEVl4iegG3kODUkFG48vR8eSOkSIAp7ZijbmTUadF2AUfOzyYniWniHR612yz
         l3cnAAs8y2bVQ9oG9v785gFNRugsjutJoUQNPY0A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159430682026.15207.6097074180965313553.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Jul 2020 15:00:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-qcom-qspi: Avoid some per-transfer overhead (2020-07-09T14:51:44)
  Superseding: [v1] spi: spi-qcom-qspi: Avoid some per-transfer overhead (2020-07-07T20:16:39):
    [1/2] spi: spi-qcom-qspi: Avoid clock setting if not needed
    [2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

Latest series: [v2] spi: spi-geni-qcom: Set the clock properly at runtime resume (2020-07-09T14:40:49)
  Superseding: [v1] spi: spi-geni-qcom: Set the clock properly at runtime resume (2020-07-08T23:39:39):
    spi: spi-geni-qcom: Set the clock properly at runtime resume


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
