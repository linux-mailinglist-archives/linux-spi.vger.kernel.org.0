Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105426E4EB
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIQTA2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 15:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgIQTAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 15:00:12 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369211;
        bh=tODsZyJ10X/3wsBOdW9RbDI0OhinwasoFgyKOZjbgZo=;
        h=Subject:From:Date:To:From;
        b=rk/VQktxxEl2giWK6nJ+ydCqzK9XOOEjinTN7u+P4HtcCl6qUbrBF69lNC8uNBs3r
         DXwoOWTz6/+iPxHfU7nx1zZzl5uV4zcse2uETKavh1VvOa0cYwu7IDt1smQnBecEWr
         mccDmTh3ANOgOlEB7RZ0Fqx0m45VigogoQvH9ZY4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160036921101.10349.2310086069492752110.git-patchwork-summary@kernel.org>
Date:   Thu, 17 Sep 2020 19:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: Fixes for FSI-attached controller
  Submitter: Eddie James <eajames@linux.ibm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=346185
  Link: <20200909222857.28653-1-eajames@linux.ibm.com>
    Patches: [v2,1/6] spi: fsi: Handle 9 to 15 byte transfers lengths
             [v2,2/6] spi: fsi: Fix clock running too fast
             [v2,3/6] spi: fsi: Fix use of the bneq+ sequencer instruction
             [v2,4/6] dt-bindings: fsi: fsi2spi: Add compatible string for restricted version
             [v2,5/6] spi: fsi: Implement restricted size for certain controllers
             [v2,6/6] spi: fsi: Check mux status before transfers

Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
