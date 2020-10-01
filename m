Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34DC27FAE1
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJAH5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 03:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJAH5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 03:57:32 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601539052;
        bh=i/y/eqbwrBJsGrjJuefZOEXjj8c6YFv6ds1b6/v9zik=;
        h=Subject:From:Date:To:From;
        b=crFL64M9baBPWf4kkDDfkrQmB4I7W9Wqf/DjWpmNYgnUHSn7DjjomijAnNvat9jzi
         WjkMtQJ+Oa8ihNsZqq80gMrpPml6XeY1gT0RuJrMvfgMM5OR2f0kNhGN1EMzuuSQgO
         LjW7+BqPDtP+wlnT1BQX5UJP7SSMBu1SmhtylVh8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160153905204.23196.9184702581587824131.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 01 Oct 2020 07:57:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] serial: max310x: rework RX interrupt handling (2020-10-01T07:44:15)
  Superseding: [v1] serial: max310x: rework RX interrupt handling (2020-09-30T13:51:37):
    serial: max310x: rework RX interrupt handling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

