Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428AA12CD74
	for <lists+linux-spi@lfdr.de>; Mon, 30 Dec 2019 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfL3IAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Dec 2019 03:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfL3IAL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Dec 2019 03:00:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577692810;
        bh=TCWuZnil5I+XvqRNVArXQOx0FoCF9FhHlvvJMIakG2g=;
        h=Subject:From:Date:To:From;
        b=iJEJ4Sx3iZHeznWYJotx73Lvr2rSgm27Wx5x9ZY6yXCr1GHdFV8uq8B2MC00jpdxg
         74zc5ewSJEQHsXDMa1zf43auHc4t6syxrDF9XsQH/3yJwYDvMjNxJFrXsjV5sk5taH
         /mq0qKa6/qjQOxBtOFK38GDlxSdtabGUgqid+7g4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157769281092.28481.1618070117459873971.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 30 Dec 2019 08:00:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-30T07:41:00)
  Superseding: [v5] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-26T07:10:56):
    [v5,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v5,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
