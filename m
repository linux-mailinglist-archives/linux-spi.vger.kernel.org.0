Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48FC1547DE
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBFPUO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 10:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBFPUO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Feb 2020 10:20:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581002414;
        bh=umMvR+pRo+rq7pxUWrms/fxVfhFPQaYHq/sSINMfplQ=;
        h=Subject:From:Date:To:From;
        b=TzydBcrJ7/9lGUR/xvh4xNEWqzWCSwwGNMBV79+jreJ5ecCyNdGSGQzuxZMPR6qLM
         l3eAvZ3G8vpO+5yBtTTAKqpQrDNkU9NkKkgrFYQ3mYkk8kuFVzo1Wbaa0Cu0KwAglm
         55DG2uxGGJMqGoBe104wDSW9gv3n/vaalcsY+auw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158100241427.6433.1497279210858216858.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Feb 2020 15:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: add driver for ar934x spi controller (2020-02-06T15:06:24)
  Superseding: [v1] spi: add driver for ar934x spi controller (2020-02-06T08:44:41):
    [resend,1/2] spi: add driver for ar934x spi controller
    [resend,2/2] dt-binding: spi: add bindings for spi-ar934x


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
