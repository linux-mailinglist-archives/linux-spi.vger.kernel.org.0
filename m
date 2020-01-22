Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C14144E89
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 10:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVJUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 04:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jan 2020 04:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579684811;
        bh=S9X5sF+ZntSdUIQ1MfxsZcO6HPth2L2bSUYer0OGpEU=;
        h=Subject:From:Date:To:From;
        b=Q2kIQk8znfVupmFU/5jbl0AnYPE8mAK1qqNKaIX3qJD6hLSUGkHK/tFyD+kB3rWbS
         q3gAQCZsnixctV5zlWKIDgY4baKI76CPesR7KIxGyeQCHiu1HPPgMAZfA/UTJcUmgK
         r2Pn3PdIxN6mdpnl+D0tmuy71qlRfYokpWEokdUM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157968481107.16220.3281911288022401210.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Jan 2020 09:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-01-22T09:18:07)
  Superseding: [v6] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-30T07:41:00):
    [v6,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v6,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller
  Superseding: [v7] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-01-22T09:13:38):
    [v7,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v7,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
