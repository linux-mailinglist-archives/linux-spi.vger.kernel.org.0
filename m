Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3F3F8021
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhHZB51 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 21:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235823AbhHZB51 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Aug 2021 21:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C5A4C6103E;
        Thu, 26 Aug 2021 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629943000;
        bh=unBJG/G6M9j9RFyfabSBg5DYTzqb5OHDgwpk0YqcJsw=;
        h=Subject:From:Date:To:From;
        b=jQ+gaf1XhhfRdpzWXhf8ta4VzlQHsgvOcTOQBQv1bhUz1xA/aGfZduxOctgOCOcvx
         +iT1xpSNoA76eRletxOo/j7YJSXjnPyQ/WxkTlc7U0mHViG2MTAXSpCXYMQKcbUltx
         iY733AXL/0lJXqXiSrLXRVfeFPqXwpGIAJfdUnPWt8TzHXK3GrlLT9QTD9PAB61nJN
         Zgs2LnOdm8tIjR91c05Ql05VJVZYLOI1RA7pOX8EwEMv2IMTiCBzYGP9FJVzL5Feci
         ryaBCUX8y0l1oF+z2euEqWCPCtaw79vzO+cHnV6QXrUVN+ApGUtGuE1yzAP9VU2gDE
         KeXqnxXJvA7nA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8DFC60972;
        Thu, 26 Aug 2021 01:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162994300074.30390.17080221110627531050.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 26 Aug 2021 01:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible (2021-08-26T00:59:30)
  Superseding: [v1] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible (2021-07-30T03:17:53):
    spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

