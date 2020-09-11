Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5C2664EF
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIKQsc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 12:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIKPHt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:07:49 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599835215;
        bh=UEtB4jsoJR0dQ5jwP0mVULkK12WZD+SmyMHFkwMhHT0=;
        h=Subject:From:Date:To:From;
        b=oOoratufl/gNQR5sMT7cvp45n4Syyi5P4QBw5ky7Y0cMNpPiWFUuX2bpLjA5Fjj5J
         MDjV1fLO4NGPZywfm4i8uh4/PUWwkRG7801UuVs5SQf5XGDH9AyQGjJBkNagQy0YB4
         o6hzEzRbtLCPEc9AdFvII1wQi3m6jKJxbWc1jpUo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159983521553.21508.8749859794785791080.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Sep 2020 14:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T13:03:31)
  Superseding: [v2] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T08:28:06):
    [v2] spi: spi-nxp-fspi: Add ACPI support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
