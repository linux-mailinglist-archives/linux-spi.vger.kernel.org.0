Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAF297490
	for <lists+linux-spi@lfdr.de>; Fri, 23 Oct 2020 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbgJWQhp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Oct 2020 12:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbgJWQdt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111952469C;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=Ify6hjJmLmH3/dY+Zjs+KW5ON5EvHvsN04EfiSRU+tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjI7bXZnCCjIXvwHbPoXtn79kE4t2/WqrbiWK/5UXkqnP9Cq6uhfWC3dn4/uKzjoN
         aNx0yqHr5/5bTRIrNjBqD8SlTApht4gbD43B8gH9SCVQK0avb9IhBd1A0ySQvr/6iO
         pslyU5Gv5lwp9+o5+kNmMEHcZvc/it2UoxRGeBwU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Awf-1e; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 29/56] spi: fix a typo inside a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:16 +0200
Message-Id: <a103f4f48735caa1a09fad94c5d76e73e2ce37b8.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_split_tranfers_maxsize -> spi_split_transfers_maxsize

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..22679c8645db 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3193,9 +3193,9 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 }
 
 /**
- * spi_split_tranfers_maxsize - split spi transfers into multiple transfers
- *                              when an individual transfer exceeds a
- *                              certain size
+ * spi_split_transfers_maxsize - split spi transfers into multiple transfers
+ *                               when an individual transfer exceeds a
+ *                               certain size
  * @ctlr:    the @spi_controller for this transfer
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
-- 
2.26.2

