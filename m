Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF71FBD35
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFPRkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgFPRkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 13:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592329216;
        bh=wLhvK+4JmDWFlWbb4ky/F6FLE8WF8KOkSgtfa6zOZqY=;
        h=Subject:From:Date:To:From;
        b=rqaSYEhXGe0ovyc5iEvOzIaI+qGqFL6a+AbUwXuK54Id4aCnGLsvvQZpi5OhR3+XZ
         HtSguLwhDpKlmvNm0QM6dp5EmqTQaEsgUHoZfpiF7KU78fFRhpHjbhOT+sA9sJ1DkX
         uKlpacY7ER0kOBV0KSnTnLSC3Gb9PVkHONREs7X0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159232921675.9829.5108395471889771264.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 17:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: bcm63xx: add BMIPS support (2020-06-16T17:32:33)
  Superseding: [v3] spi: bcm63xx: add BMIPS support (2020-06-16T07:02:19):
    [v3,1/4] spi: bcm63xx-spi: add reset support
    [v3,2/4] spi: bcm63xx-spi: allow building for BMIPS
    [v3,3/4] spi: bcm63xx-hsspi: add reset support
    [v3,4/4] spi: bcm63xx-hsspi: allow building for BMIPS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
