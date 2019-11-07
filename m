Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7596F26A4
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 05:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfKGEmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Nov 2019 23:42:40 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49725 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733202AbfKGEmk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Nov 2019 23:42:40 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 03A128365A;
        Thu,  7 Nov 2019 17:42:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1573101758;
        bh=Cp3+ygrkI2TUFwvD/ZbjEdvVyk+ISy2hrJqm52dAiZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=edDyucAtvLEYc9JvD0X2b/mHsDWEOQxDtE0BUmvknX3TvmLiQF4WvURmrgOAfZ0ti
         SVL3znnNOvnz8aW80lYnvrwY7VAhtmIunq/FogoeJmILoFF+ABwvMDr0Bsy/jo3y7h
         /K0UEGi1p8B326Yecppr0D06qeimkOSfAkFVg/f/k33Ed36DqUeWQr8EIpDXkhB6yf
         UWvCsjO+2FPQVVL2Fxm7fka8vAFeMpjTGZL4HlWu/AaTPSiXrdKskMsD8NP61SBYg1
         t7RTIRZdWSqMoza06ZuKGkDyOZ2HyTUkA+3soHfVjfCliGAjRRwYV+Sg7XukYJfCsL
         3hxB56vORrG1A==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc3a0be0001>; Thu, 07 Nov 2019 17:42:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 49FFD13EEEB;
        Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C48EE28005F; Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] spi: bcm-qspi: Convert to use CS GPIO descriptors
Date:   Thu,  7 Nov 2019 17:42:34 +1300
Message-Id: <20191107044235.4864-2-chris.packham@alliedtelesis.co.nz>
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

Set use_gpio_descriptors to true and avoid asserting the native chip
select if the spi core has done it for us.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 7a3531856491..85bad70f59e3 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -803,7 +803,8 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_devic=
e *spi,
 			return -EIO;
=20
 	from =3D op->addr.val;
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
=20
 	/*
@@ -882,7 +883,8 @@ static int bcm_qspi_transfer_one(struct spi_master *m=
aster,
 	int slots;
 	unsigned long timeo =3D msecs_to_jiffies(100);
=20
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	qspi->trans_pos.trans =3D trans;
 	qspi->trans_pos.byte =3D 0;
=20
@@ -1234,6 +1236,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->cleanup =3D bcm_qspi_cleanup;
 	master->dev.of_node =3D dev->of_node;
 	master->num_chipselect =3D NUM_CHIPSELECT;
+	master->use_gpio_descriptors =3D true;
=20
 	qspi->big_endian =3D of_device_is_big_endian(dev->of_node);
=20
--=20
2.24.0

