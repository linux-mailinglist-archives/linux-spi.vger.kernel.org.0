Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC318893
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfEIKzx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 06:55:53 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36350
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 06:55:53 -0400
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764487; Thu, 09 May 2019 10:55:45 +0000
From:   kernel@martin.sperl.org
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
Cc:     Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH V1 0/3] spi: core: correct ordering of unprepare and resources
Date:   Thu,  9 May 2019 10:55:30 +0000
Message-Id: <20190509105533.24275-1-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

There was a bug detected with the place where  spi_res_release is
executed, which was solved by commit c9ba7a16d0f1 ("spi: Release spi_res
after finalizing message") but then reverted because of a race condition.

During the investigation it became also apparent that there are also
error cases that are not propperly handled with the correct sequence.

So this patchset tries to solve of the issues:
* fix the root problem codifying the "sequence" more explicitly
* give a warning about possible inconsistent behaviour
* make the "sequencing" better enforced by using spi_res to guarantee
  ordering.

In the future spi_unmap_dma can also get converted to use spi_res for
unmapping.

For most practical purposes it may be recommended to apply patch 1+2 now
to avoid having to revert commit 8b7bd10eb00d ("spi/spi-bcm2835: Split
transfers that exceed DLEN").

Patch 3 can go into a later release if preferred.

Martin Sperl (3):
  spi: core: resource: fix memory leak on error and place in "correct"
    sequence
  spi: core: add a warning when prepare_message uses spi_res and is
    unprepared
  spi: core: make unprepare_message part of spi_message.resource process

 drivers/spi/spi.c | 53 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

--
2.11.0
