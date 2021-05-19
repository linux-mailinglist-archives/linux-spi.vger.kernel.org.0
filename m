Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D9388930
	for <lists+linux-spi@lfdr.de>; Wed, 19 May 2021 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbhESIRI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 May 2021 04:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhESIRG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 May 2021 04:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4801F60FE9;
        Wed, 19 May 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621412147;
        bh=iByNIEQj2t/WJu0c9rZYiDTureTp+s2p5iQh1hmOyuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br+rRdANJfa+ke6BSR8C4TOcPfrDR59qb+Sm2nHHJ6BfsKaWvmdA0y72UzziekOHj
         E+1r7DTkw71Yh8Mm7Ypcbgn5n6WNyRmuw8SmOubm8PGOJR5PTkl0C/yDSzJc34E75k
         tRaUK4I19S2tSSKNKPEvDMRTucv21eA1vttXHL2gX7+fW4IcKn5c8IKXtTOeAu/A66
         VQxwmUVmzTr/ll2MUCatVyXteLzMnfYK1MbRJxxPoRLRDXavl0Fv+n3LqVOgDOa2lA
         dj0hesEV+H74EDzbg/6nxB/XRj1Cr2hBrzepblqoQNutWVU/sN+2rCPkkrz9zGa520
         /9H2zcOZKeEhA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHMm-007fBA-Vu; Wed, 19 May 2021 10:15:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/3] spi: fix some invalid char occurrences
Date:   Wed, 19 May 2021 10:15:36 +0200
Message-Id: <ff8d296e1fdcc4f1c6df94434a5720bcedcd0ecf.1621412009.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

One of the author names got an invalid char, probably due to
a bad charset conversion, being replaced by the
REPLACEMENT CHARACTER U+fffd ('�').

Use the author's e-mail has the characters without accents,
as also used at the .mailmap file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spi/spi-omap-100k.c   | 2 +-
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 7062f2902253..ffa132d40146 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -6,7 +6,7 @@
  *
  * Copyright (C) 2005, 2006 Nokia Corporation
  * Author:      Samuel Ortiz <samuel.ortiz@nokia.com> and
- *              Juha Yrj�l� <juha.yrjola@nokia.com>
+ *              Juha Yrjola <juha.yrjola@nokia.com>
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 999c22736416..e24520e87cff 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2005, 2006 Nokia Corporation
  * Author:	Samuel Ortiz <samuel.ortiz@nokia.com> and
- *		Juha Yrj�l� <juha.yrjola@nokia.com>
+ *		Juha Yrjola <juha.yrjola@nokia.com>
  */
 
 #include <linux/kernel.h>
-- 
2.31.1

