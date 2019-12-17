Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B8122779
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 10:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLQJUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 04:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfLQJUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Dec 2019 04:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576574410;
        bh=Px4i3kNPlYqQv2hd0uTe+WS/DN0jhG5LwS8/c0JX8Ic=;
        h=Subject:From:Date:To:From;
        b=qghyiVZXBkoiVpMuDOOmWZ9axMEAPtr0qSGckEgWOET0EMNI6QUApq8C1c9RIXM0l
         b0ze8Pxr6Pjp/xdMvGHnCHTRhMv6Of9rgVssDuLlF6fDwINVTaO0sV//7Of5TcNoig
         KWIph/RA73dNkKDa7DNJaVz8ORsodV6P1PnoPUl0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157657441052.31106.11211304489305455597.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 17 Dec 2019 09:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: Convert stm32 spi bindings to json-schema (2019-12-17T09:07:15)
  Superseding: [v1] dt-bindings: spi: Convert stm32 spi bindings to json-schema (2019-12-04T15:32:33):
    dt-bindings: spi: Convert stm32 spi bindings to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
