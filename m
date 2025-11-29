Return-Path: <linux-spi+bounces-11670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F6DC944BB
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56C6A4E371B
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6430F95B;
	Sat, 29 Nov 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p1ExRqDj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9943112D0
	for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435533; cv=none; b=b2HICr4pBp7HWzG2CRoZnntBHpAdU0HLDJ1Su08zUB3Ni7d+CvrHiKxrHp/k6A5tLxdHCCFN4IhYC5JTHDgPX1++eaAhfQCZViH9yiGsmlW5UCdDTPWDX0+xFsC13oLHfwML+nh9ZdL5etBez5GJI6qnlkBQadJnVPkIDIkDdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435533; c=relaxed/simple;
	bh=ZZbGTkMYTIgTc2HHYCAxYn2mLQnWvUECVJl5MHLWpEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1RSZ6HUj+1FZDWemI8i341v2yAQ5f2M2mNbdjXJWAcum/jdP3V0XE/U60W4u0RtmhcBM2sTD+sFJqPQ+/x+hFobrmAesxpWxGvRelutfs++oX3DlvMwzLijEQmi2QLqRvoV+DMHYISEAcyfuWAqFVUOgMjSKE+PlZYehlHdkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p1ExRqDj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso5421884a12.2
        for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764435527; x=1765040327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFG57/lAXGfcsZdp8Xv+tkRcXlQVV5XT9qmsBMmgDeQ=;
        b=p1ExRqDjd4wDbEXgcUtmYM71zIOnMDZGn/Bv4LzNZ0seM4VCuaZ+FVyEtWmjfRyE3y
         Yw1j+SKfygreR8cVy8tP6ugbD9JDZduSOcICyxViVWCbPNaVUyRJ8rF+bv39IWlVgJBj
         f4I5KhxKLmSEqEOKNUD5nPcf//mTPxzYiL8SxLWe3imc6iVLbmgun3u4ZhYJcXPbsGaG
         NeBlL+NMZ4NTZzr8M0FCSsg3by2iubvZ/Wd+/oMM5upCRRBuzmLz8GCGmJLhsMshpWmY
         rGJwV9KASDuCJjeV21W9KZQvHvnLhaSxVqzo/GeZyT66IfnelBkXbvVbV+Lpgt597/uD
         +Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435527; x=1765040327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFG57/lAXGfcsZdp8Xv+tkRcXlQVV5XT9qmsBMmgDeQ=;
        b=HKXKv7SfYdOPDyBmCnAtIAN1V9yE7q7iNffjFpOHj8qHuBccQl7G23Z8d82TnDVaFL
         5ou+KMByrmCgETLjMM+Qjen4Sd5f7lq1bRWV2CCVYCKDQQ1UNxdtEmGH/uqLgwa9F/Oj
         obpzO12ml7lSlOyxTOAYG3UsZAHpZbT6qD+rc4lZZ+NY+leKjotp0DLW4fyyXkA5DSU1
         mlQ59bKpcHEubIbAGMmfSsD2Glhdv9WxN1NF8BwUV2RhxDOMHYv9KXFtf8dt7T8XWELE
         pwRXcSovG6FA+zPA6qx9ep8alleBAekcWQ4M/shp7IVuHDOyw0l2Cpa8L9vJzSeuAaDg
         cnIw==
X-Forwarded-Encrypted: i=1; AJvYcCXxP8dqiroOqn/Ig41fgMMz+vf8DO7ZmZgNae7SyYk/NBd9P+T5I9dXrUxyXdSX65IfbzZB+AxreIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXrKrOpvuPvA8mUtWNMRqHugyV1B72ZhFZKsVXvN005mTEGwm
	2HHHbNOmsLrjdQihO9IL0xNVTjsw4TnCNxR3Gih+ktxsBViVew97rlyY3Ze8/Vd9Puc=
X-Gm-Gg: ASbGncsn0He48pg9AkGpVJfPoD856sgruX8q7MOxPJs7h6nTzSewQKvYL+2VswlZuF0
	9bSd/aV4bDPrdKZiqpaDW7n7bZ+VPW0GZAUcHQ0kGac+vDfzCVGc23Vx+3AP4J79cKKwX6vC++Y
	22lHIJyrInYwFHqNKZy/NLN+7AJ1FvzN1vqFPXRRudI5iGq6mee/K5T02zMBxG3AJvwut+FQ4l/
	NZXAxAsRvIBsn0B+qG7TvHhP8ycN8IHT5EHE+fitppaEF5IEKnvHcajHUSKcHiTiMH5cR99O+R4
	O6XW1JM+DJC7CdJzdxSfmp0j7U/L2EFMvMm2N5T9dhisLoAaAGbMop5VqAhRvUI/0RUOTGnF20v
	9O6jBQsT9XytfHT7fjryqbfDODqb6/iBWzD9bBNk7OCUxz0/X56D5/gT7fuckyquMAikrtuqPRv
	RiouzsoJVoMNTrHmlk
X-Google-Smtp-Source: AGHT+IFy0NAudSDXw7I2Aiji0fj/sV9rIW0nafD3DGEIhNthc68dpKGwVJNpVb+V2jIju6zOK1WZEw==
X-Received: by 2002:a17:906:fa0c:b0:b76:8077:4eaa with SMTP id a640c23a62f3a-b7680774fecmr2224282766b.6.1764435526719;
        Sat, 29 Nov 2025 08:58:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f5a4860fsm726556066b.63.2025.11.29.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:58:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/12] spi: fsi: Convert to fsi bus probe mechanism
Date: Sat, 29 Nov 2025 17:57:48 +0100
Message-ID:  <a64cde17039056d71a1bd14ecc36bcb67305b31e.1764434226.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764434226.git.ukleinek@kernel.org>
References: <cover.1764434226.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ZZbGTkMYTIgTc2HHYCAxYn2mLQnWvUECVJl5MHLWpEc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpKyYgROy12cesDmV48VbWJFTWfD4pX9V5tIPFq WBU7MaAQ++JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaSsmIAAKCRCPgPtYfRL+ TmrzB/44PL/fVctVmXmkwM8vtKDKp/RzmiAggaYZ030mB5tEwnTSlzpcfa8mRjCT1atCQwmPOd1 xYtsux2go6zkiWQXhfzOUo5TdWMdkgfUGf33ElWK8+Amyx1JWixrJnH/cc34uKi7N0+SnskX44R WBPJ+6/uwH1PD6Q/vmH33P4TuPFn3M5nK+Xy5IDKeFFe+QJvvwxRdzrGaFaBfjc/kDKNzuHZ3O3 w2RDycLVKPsIxITkTlCzPB32NIrAKY7O6eFTkEDWxNb/AvT1giay9DwgQhnqWogZaRFtf0s4XwE 9iQZNr0On/KbEjfKdsf/p9iNPFfEPU4uCuUu7qjndz6M2lJ/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The fsi bus got a dedicated probe function. Make use of that. This fixes
a runtime warning about the driver needing to be converted to the bus
probe method.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/spi/spi-fsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index f9c15b99dba5..07dc3d24f2c9 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -528,13 +528,13 @@ static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
 	return SPI_FSI_MAX_RX_SIZE;
 }
 
-static int fsi_spi_probe(struct device *dev)
+static int fsi_spi_probe(struct fsi_device *fsi)
 {
 	int rc;
 	struct device_node *np;
 	int num_controllers_registered = 0;
 	struct fsi2spi *bridge;
-	struct fsi_device *fsi = to_fsi_dev(dev);
+	struct device *dev = &fsi->dev;
 
 	rc = fsi_spi_check_mux(fsi, dev);
 	if (rc)
@@ -593,9 +593,9 @@ MODULE_DEVICE_TABLE(fsi, fsi_spi_ids);
 
 static struct fsi_driver fsi_spi_driver = {
 	.id_table = fsi_spi_ids,
+	.probe = fsi_spi_probe,
 	.drv = {
 		.name = "spi-fsi",
-		.probe = fsi_spi_probe,
 	},
 };
 module_fsi_driver(fsi_spi_driver);
-- 
2.47.3


