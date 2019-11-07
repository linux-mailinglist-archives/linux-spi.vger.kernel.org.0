Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDCF26A8
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 05:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbfKGEmm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Nov 2019 23:42:42 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49733 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbfKGEmk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Nov 2019 23:42:40 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 19B92891A9;
        Thu,  7 Nov 2019 17:42:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1573101758;
        bh=bMEIysSL7qRIOgZGjWsFx8QD9K67pjzCBj+QK0a/HWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dbefTGbw+fXQD9rqtgvhApUhfVAxItBd+GI0QGybJkuVJOtg4ZVZ0Tsgna9JcVVpi
         tIFXGVoOkOKhQ+sGbRjo8ZlOUJKB+rOFmaQafm3gL09kvJw79kYzcfOXAur5jYqHEJ
         P8LMXnFjQOgIisCcHBsQijf8WqPbYIhjD+iJRZTaz5tJ+W00Oq1BqbrWBPe0QCoqpG
         BjwSE18/gwTqCHhE+nxeiEipMX4UyAqUXR1VGwlU/z6tiGwU76RkMe38TMr/EXdJ0S
         1Oyxb0Ba2+csSc81FWoNs9HoYsR5zVnLyeoGRKevIRrpm7dvFEYcdM7KWQYXYn7AEa
         roaRxhoBh+Zbg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc3a0be0002>; Thu, 07 Nov 2019 17:42:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 68AEC13EEEB;
        Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E331E28005F; Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS gpios are used
Date:   Thu,  7 Nov 2019 17:42:35 +1300
Message-Id: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Devices with chip selects driven via GPIO are not compatible with the
spi-mem operations. Fallback to using standard spi transfers when the
device is connected with a gpio CS.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f3116d..e5a46f0eb93b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct=
 spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
=20
-	if (ctlr->mem_ops) {
+	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
 		ret =3D spi_mem_access_start(mem);
 		if (ret)
 			return ret;
--=20
2.24.0

