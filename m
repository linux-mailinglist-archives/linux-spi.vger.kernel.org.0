Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC1163A55
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 03:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBSCkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 21:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgBSCkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 21:40:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582080012;
        bh=+w5h6L5hly1n4GrA86FxyDlpDYTnACk3XgPdlBxI7s0=;
        h=Subject:From:Date:To:From;
        b=w6t4EtKzUML5L9u+0m+UM6wDSwvdqAeMRdH/em3U+/OBm0ZERoyL1U/oycbDNwPgo
         zpIsOozUKHksEw4RPxns/8luBZcG5kiJk/4XLOOQfFRZEMEZdnAWP7xNqGw5Xzozcd
         jXyOcM0yt0oGxEj5biMM+H59IHv499EwisBRLDGA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158208001259.29139.7006425242136650530.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Feb 2020 02:40:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v10] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-02-19T02:28:50)
  Superseding: [v9] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-02-14T11:46:16):
    [v9,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v9,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
