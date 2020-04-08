Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB101A25D0
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgDHPqe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 11:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgDHPqd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B2B21D79;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=2dtxiXcqpLlxzQY41glPzfxzzobbNtue35byn94ocz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj8MextYAoIKsWvztzjCGcKAsGVM1/9pAq2gRfDT/NqG2fUo8IAcqV441T/vNl56C
         9j4AscDetciOP4kRZGj/DcYvPvFhwG9zEusuROZCQJqbTf4AKV89pn+KzOJfzz6K7y
         b33++rZUEOu+m8Yo1q1U9vVZTrdgUcaCXvab2CXo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBv-SA; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Date:   Wed,  8 Apr 2020 17:46:13 +0200
Message-Id: <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
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

