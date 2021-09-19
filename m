Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D659E410AD0
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhISI6M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 04:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhISI6L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 19 Sep 2021 04:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9F4CB60FF2;
        Sun, 19 Sep 2021 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632041806;
        bh=wZZ2iJ9AWgOtbGgnHDuUudQSb1wnqP9UHPzgrzDOJEs=;
        h=Subject:From:Date:To:From;
        b=heqIAGRW/Ul+R48CxMFjvlRhZfcHTKlKPjbeyLqzW8dOYGuMqHHEiyTe3/HLcRlee
         h6nZXqnkyscgy2o6O3IpumoFOlfQCVnDEwU+hIwVRDlyKTZN9fgzIKaGwGPEWIHOoC
         OjAO5sMZ1oeCXFINWINwPdRaaQHMmiTYNrpUvLU45Qkne8Q7tneDSYoFkq4nT8nO2B
         xyVQi26kUYBNhus1t9fTLcEuyun9mU2hXjC3fwkBEy60/l1z7ysW4LJXL1QZNYkXnW
         OOhLpxRhnUeK9ePQcreG53xqJU+/BhP+4XDEwpJXwQPv85No8x70ldcJnY5fT3Aao/
         HRrw8bgALkg5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91F73609E9;
        Sun, 19 Sep 2021 08:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163204180658.2668.10451430437261513946.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 19 Sep 2021 08:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] add support for Cadence's XSPI controller (2021-09-19T08:04:28)
  Superseding: [v6] add support for Cadence's XSPI controller (2021-09-19T07:38:41):
    [v6,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v6,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

