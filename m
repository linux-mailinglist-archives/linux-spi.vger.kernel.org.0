Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F9188F27
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCQUkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 16:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQUkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Mar 2020 16:40:11 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584477611;
        bh=OsTFkvvYkFVqCPF/zY2knqSb9r9s2xbg4ryYEvK/CAc=;
        h=Subject:From:Date:To:From;
        b=FzpgGfkCz0ttJZ0soihyasmFigawhGWw8tZUjlhgFPMpS1tY55FkcmsU8CkFrZQd4
         LCd6jISK2hVE5oDvZYV2wrmJsVO1lkRPfjNZIiMfd38nhb6e7XEw6z5T/D28lFnWiQ
         mtCkFyYtuHjPNT4cTzf8ZyAaoUG5oJptlY419eOo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158447761138.19886.14565621810053971959.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 17 Mar 2020 20:40:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt (2020-03-17T20:37:06)
  Superseding: [v1] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt (2020-03-16T22:20:01):
    spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
