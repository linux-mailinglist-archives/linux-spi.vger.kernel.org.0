Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725E1A2E9D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 06:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfH3EkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 00:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfH3EkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Aug 2019 00:40:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567140007;
        bh=+EF0f9uf/7aFPBXginYJqK/CVhpaBVHGJuUMzeBeubA=;
        h=Subject:From:Date:To:From;
        b=FTMdishuU/ovs0xSVv4y2SIurc01JM9owznQACICndGncm9JC243xh7sVHlsihBVr
         5W47rlNlL/0UwvN92QmU92oqVXp8B9Bpa05/chTT9Ot/EY5qa98EHXl9sKdWxPSxYM
         D/LCmnCYxsR407TSu/TLc0bjE3CUq4DSeT6vHAcc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156714000708.32318.1999330083939988873.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 30 Aug 2019 04:40:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm-qspi: Make BSPI default mode (2019-08-30T04:28:45)
  Superseding: [v2] spi: bcm-qspi: Make BSPI default mode (2019-08-29T04:16:13):
    [V2,1/1] spi: bcm-qspi: Make BSPI default mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
