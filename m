Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39DB184D72
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCMRUH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 13:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgCMRUG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Mar 2020 13:20:06 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584120006;
        bh=MEEUWKmvRNfQ0GipU+aTYYoQMbRYDEZFj5kWRFjhXwE=;
        h=Subject:From:Date:References:To:From;
        b=g7KueBXEcssR88rPU5sbwKALuIAP3qjHwL3wnm9wZ2v5ITH3YRksTSVRf7VBJXRKK
         2mapCsDs7dbnGgIhTqpP/oiTWkxc+tpgf7+0nrgZTfRAtULtPMUYOm6nPtY69uSoJa
         mynzmxlAtYwfF/m7Dk8TQYVhdyJsZUU5mSYm8tOE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158412000631.9899.18348416005574637561.git-patchwork-summary@kernel.org>
Date:   Fri, 13 Mar 2020 17:20:06 +0000
References: <20200306085038.8111-1-geert+renesas@glider.be>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: dt-bindings: spi-controller: Slave mode fixes
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=252285
    Patches: [v3,1/2] spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
             [v3,2/2] spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave mode

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
