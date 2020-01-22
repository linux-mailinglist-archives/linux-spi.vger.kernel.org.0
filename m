Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D8145EE4
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 00:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVXAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 18:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgAVXAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jan 2020 18:00:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579734012;
        bh=FCYXUmQBI54ebmRWyzAxdcTYq1rlnjd2kXv4pjylXro=;
        h=Subject:From:Date:To:From;
        b=TLnyuFrEPJrE0Fuy7BypdHiMQgqFVYWeNFUf3pDsiuFb4Li4b5b4LbrWcGzKDOXEW
         plPRLq2G1Xkc2yg+RM4AvcYJ9296jUADG15UuEhef+sNFJ9GrGi6tUyTB+MswlOPjd
         FnE08DVh5em0egI8utgmT7BNYEko4aG9BViFPR7s=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157973401211.21053.4337557708112394617.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Jan 2020 23:00:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: convert rockchip spi bindings to yaml (2020-01-22T22:45:54)
  Superseding: [v1] dt-bindings: spi: convert rockchip spi bindings to yaml (2020-01-18T23:08:47):
    [RFC,v1,1/3] dt-bindings: spi: convert rockchip spi bindings to yaml
    [RFC,v1,2/3] dt-bindings: spi: spi-rockchip: add description for rk3308
    [RFC,v1,3/3] dt-bindings: spi: spi-rockchip: add description for rk3328


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
