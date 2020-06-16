Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D609E1FA4DF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 02:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFPAJj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 20:09:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFPAJj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 20:09:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F40C1FB;
        Mon, 15 Jun 2020 17:09:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E768E3F73C;
        Mon, 15 Jun 2020 17:09:36 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     broonie@kernel.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@martin.sperl.org,
        lukas@wunner.de, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: bcm2835: Interrupt-handling optimisations
Date:   Tue, 16 Jun 2020 01:09:26 +0100
Message-Id: <cover.1592261248.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

Although Florian was concerned about a trivial inline check to deal with
shared IRQs adding overhead, the reality is that it would be so small as
to not be worth even thinking about unless the driver was already tuned
to squeeze out every last cycle. And a brief look over the code shows
that that clearly isn't the case.

This is an example of some of the easy low-hanging fruit that jumps out
just from code inspection. Based on disassembly and ARM1176 cycle
timings, patch #2 should save the equivalent of 2-3 shared interrupt
checks off the critical path in all cases, and patch #3 possibly up to
about 100x more. I don't have any means to test these patches, let alone
measure performance, so they're only backed by the principle that less
code - and in particular fewer memory accesses - is almost always
better.

There is almost certainly a *lot* more to be had from careful use of
relaxed I/O accessors, not doing a read-modify-write of CS at every
reset, tweaking the loops further to avoid unnecessary writebacks to
variables, and so on. However since I'm not invested in this personally
I'm not going to pursue it any further; I'm throwing these patches out
as more of a demonstration to back up my original drive-by review
comments, so if anyone want to pick them up and run with them then
please do so.

Robin.


Robin Murphy (3):
  spi: bcm3835: Tidy up bcm2835_spi_reset_hw()
  spi: bcm2835: Micro-optimise IRQ handler
  spi: bcm2835: Micro-optimise FIFO loops

 drivers/spi/spi-bcm2835.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

-- 
2.23.0.dirty

