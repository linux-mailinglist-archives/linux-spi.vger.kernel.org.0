Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE34AA1087
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2019 06:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfH2EkI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Aug 2019 00:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfH2EkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Aug 2019 00:40:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567053607;
        bh=DW8+x+CPh2rXmjrIeiAa7Ei1lIUdstg0p5FzjK7Qszg=;
        h=Subject:From:Date:To:From;
        b=XNP01JMGiPU/Mw+5XMhqWoflWf9bP3cF4eXU5fB7fmM/SonRWUId6JOAHWvKgwj/Y
         Azzb1sMX0+jianCJ1JnAKds3Y5EWooDpbQaYWIf2M97jV2rdK0mkL/HtRx/sOimPba
         XG1NEc76gJ+lB5Unizd7sJvJdbDV4tvc37NjA1TM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156705360748.1842.10397830129614198392.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 29 Aug 2019 04:40:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm-qspi: Make BSPI default mode (2019-08-29T04:16:13)
  Superseding: [v1] spi: bcm-qspi: Make BSPI default mode (2019-08-06T10:14:34):
    [v1,1/1] spi: bcm-qspi: Make BSPI default mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
