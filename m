Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAA12F322
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2020 04:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgACDAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 22:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgACDAL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jan 2020 22:00:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578020411;
        bh=1YjwAGvORA/+q9+LY3ec7/KNN4cLyvBZV9T/bYoxHNY=;
        h=Subject:From:Date:To:From;
        b=iv8FtpaR23nfj7amiEikM7t6ns79HgHttjtuEzi+dVGJq+iyAnpJ2kGNaOZxLRcI0
         a3VMfmEbYmvsqehSgZfj9rnE9/G1PwKj60Bz3+q24v5FNvOPDzMVNxwAhLQeywH53B
         GcCigY/x0Ysb1gbO9wZ8YMJKy64e6b2GqiuA8uJM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157802041114.15615.3406770577314200989.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 03 Jan 2020 03:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: use "smp_mb()" to avoid sending spi data error (2020-01-03T02:52:10)
  Superseding: [v1] spi: dw: use "smp_mb()" to avoid sending spi data error (2019-12-26T09:21:28):
    spi: dw: use "smp_mb()" to avoid sending spi data error


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
