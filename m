Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94335412FD4
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhIUH6H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 03:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhIUH6H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 03:58:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 115F860EE7;
        Tue, 21 Sep 2021 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632210999;
        bh=0Dvs72fI+Ex7B1L3/HuJgKXMYat9KXf/eMceVkWZIk8=;
        h=Subject:From:Date:To:From;
        b=QpY5cOAhv4SY1nnw3VHZTuVPJgPPX9LcpBKqLb/stghktAXLNzeM3Gu1Rx69UI3F4
         3Eutw6NHk/a3sFR7aCL4kthj6NFgHg171hyEk2XDnp6JuYX5obvAFKy/KjPGIraPUG
         D5ntMZvFhJbNn/kLbfRph3oaTmJHVQhMX3bih+MzDTYhQMARQs/t0ittdNQ9PpWT3r
         udI/y/XXhVyohgbIVkb0gx2YZTusDBYTVooc0SRXGmSYp6vAmVyvDKMDmmeyfolva2
         S2RGipUMnwWTfEaQLj1m5lBaapd/w5RC8eHMl0lL+0rvhxdbmBHKU3HrUHO5247/FV
         5Gbv7syYaMb2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0139B609E2;
        Tue, 21 Sep 2021 07:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163221099899.7022.8107184760168665366.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Sep 2021 07:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: atmel: Fix PDC transfer setup bug (2021-09-21T07:21:32)
  Superseding: [v2] spi: atmel: Fix PDC transfer setup bug (2021-09-17T07:46:11):
    [v2] spi: atmel: Fix PDC transfer setup bug


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

