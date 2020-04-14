Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2D1A8617
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440805AbgDNQxx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 12:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439740AbgDNQtO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D198C21841;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=2dtxiXcqpLlxzQY41glPzfxzzobbNtue35byn94ocz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTcUVYT35Bif541OWFBjhRZVaczzSVCp/TLrRGiS4EnMeiYgLfYgyso427WtnNRZ8
         CxgcFeDZrtiUdWrEnsWCRmmSesDtNpmgiPhn/ChY5oiAWEnzmlqw5Q9KbnNsqE4GTq
         zG8bwaaGcc+RQV6XJI5S7iodrRD1buFn/CF8eMcc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068mK-45; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH v2 18/33] docs: spi: spi.h: fix a doc building warning
Date:   Tue, 14 Apr 2020 18:48:44 +0200
Message-Id: <1c701b3ac903dc0bc304dca958fbdee53bd38dc3.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We need to add a blank line to avoid this warning:

	./include/linux/spi/spi.h:401: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/spi/spi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38286de779e3..aac57b5b7c21 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -394,6 +394,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                   for example doing DMA mapping.  Called from threaded
  *                   context.
  * @transfer_one: transfer a single spi_transfer.
+ *
  *                  - return 0 if the transfer is finished,
  *                  - return 1 if the transfer is still in progress. When
  *                    the driver is finished with this transfer it must
-- 
2.25.2

