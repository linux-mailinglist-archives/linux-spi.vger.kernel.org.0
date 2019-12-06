Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0448B1152FC
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 15:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFOUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 09:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfLFOUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Dec 2019 09:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575642011;
        bh=0ZFet+ADBLO/jqPTs89Jq4AK4PDw0qGnXxp8HkUJNwE=;
        h=Subject:From:Date:To:From;
        b=MVhr2q1B/ZKSEGz3FKTLqjtq+g0G+uqCMP1U/DUPIodUHtdhba8w70ps9ZxjDgQcg
         od9qc/RCVi+Wi/cl5lpkTxoUXYYl+85FjY0qeQTYi7pBCe5UewaqvjRIh3j9Qq8Xat
         lV8Zxa/rSQj7KKrqHgsYLaNOgJ+uRN6PdaJDMOpU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157564201140.15259.1901722836028197577.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 06 Dec 2019 14:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Add Renesas SPIBSC controller (2019-12-06T13:41:56)
  Superseding: [v1] spi: Add Renesas SPIBSC controller (2019-12-03T03:45:15):
    [1/6] clk: renesas: mstp: Add critical clock from device tree support
    [2/6] ARM: dts: r7s72100: Add SPIBSC clocks
    [3/6] clk: renesas: r7s9210: Add SPIBSC clock
    [4/6] spi: Add SPIBSC driver
    [5/6] ARM: dts: r7s9210: Add SPIBSC Device support
    [6/6] dt-bindings: spi: Document Renesas SPIBSC bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
