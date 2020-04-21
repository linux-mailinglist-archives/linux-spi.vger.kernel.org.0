Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013801B2B05
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDUPUQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 11:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgDUPUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 11:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482416;
        bh=GvE07Rj/8NYtoMGQEWKOUinpTI6UrEKLHgGDvqjhWNs=;
        h=Subject:From:Date:To:From;
        b=VDjWIxOH6A0JC4j1oZLWpbfiZhCjGTZtiGhXV4ZhtkxP/CobQvIWjJ1KL7Z0mGC2v
         eqBN6X9XKHo1QAz45WDiS8VSOsyOSLzDA7GIRdMXmSSGg/xj3vdMISFYHCti7j0NMh
         //rBn1uLVV8JgGZISGvd9e4E2+HgCa8MNr+M/ytk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158748241617.21401.3975572134236039405.git-patchwork-summary@kernel.org>
Date:   Tue, 21 Apr 2020 15:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: dt-bindings: Fix dtc warnings on reg and ranges in examples
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=268931
  Link: <20200409202458.24509-1-robh@kernel.org>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
