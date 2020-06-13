Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43C1F84CC
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFMTAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 15:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgFMTAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 13 Jun 2020 15:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592074817;
        bh=Fb2hb4rni98F5+AjTUqIvnxxh3E2dox/HdcbIp/eywA=;
        h=Subject:From:Date:To:From;
        b=KYDPMb07LWaompnytWaCuVBnYfixW5RKP7aElMQIxVs+kv44vyW9s38/WufxNqGsZ
         q5jdYotnst4HD/xHuAwxCb7u/rkWEImbNLzqJq/9jvh7OTaMSBWoOMktoMbT2hR8+m
         EtxurVUXF2E5i6YZc69xEOjgn/roGNDwGR1RVrx4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159207481745.1893.9877733881026427009.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 13 Jun 2020 19:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add Renesas RPC-IF support (2020-06-13T18:37:47)
  Superseding: [v3] Add Renesas RPC-IF support (2020-05-18T20:31:50):
    [v3,1/2] dt-bindings: memory: document Renesas RPC-IF bindings
    [v3,2/2] memory: add Renesas RPC-IF driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
