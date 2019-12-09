Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62831168C8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 10:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLIJAK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 04:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLIJAK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 04:00:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575882010;
        bh=e/1CELafzFYgaYXPgOKanO4ijMVmI8jMp9MGWd9RmTQ=;
        h=Subject:From:Date:To:From;
        b=IR+l0diXxQG0qtazQpo9A2AlwsgCfyRiIsarCiItoNeG5yOITGvYbDoJLJSlwa8MI
         JdFuL4d+xkWdyoCZAyO5r8Ng+rJahfR2ZdbO2/F+41LORijB+2abiTRXc4+DbOS1BC
         LtX/lFPT/wLiJ9XNhKQV1elQdFJgt2Xqt2EK17sk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157588201035.17052.14171566110482942502.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Dec 2019 09:00:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-12-09T08:40:33)
  Superseding: [v2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2019-10-30T08:11:53):
    [v2,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v2,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
