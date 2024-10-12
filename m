Return-Path: <linux-spi+bounces-5208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00C99B2B4
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142F4B23113
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0506155757;
	Sat, 12 Oct 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc/abuOC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E29154C17;
	Sat, 12 Oct 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726870; cv=none; b=A6TlqZkJoIhzw4H62N0SWLhBFvPW2Febb5t5NRQOmVVfu/lXGx99q8ahOqwTsGnVO05XwpxK/scDEBBLtStGgpk/aXrybV9RB7Mk9lrJdiMSrwZb26JHEE7pZLFVNh4qrCW0k7xhGctuUTDe0+1vdHe8gfUL0TT21HX858hzTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726870; c=relaxed/simple;
	bh=8F4EAhMS7+CFB9fbxDKkef+lgknglgfHRwZSTghHyac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuU8TvmOT1VknoJls8atGxU2TEy5wj8hbKsJbYgMc4yf1oUGuWfaKjvSR9Gx5pf0m0oXkF0kyqss6DdhehBPJ9YnkYXd/yHdFNfU0VLoUpqeUhO3HxszbIiNGL1V3ZToEHGzHZj2NxsYIpOPg/mNDpklilELrZSucW5ClnWV3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc/abuOC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99422c796eso455891766b.3;
        Sat, 12 Oct 2024 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726867; x=1729331667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0+JljHLnekSSywTewBZ577k02mbpsj8v/vK0Vy1JgI=;
        b=Pc/abuOCGrOOmCSnDcBvhlEm6L9VsWQVcH3Yn0pHalXKVDCAiHILSulyTB0aGp6gCr
         LRKds09b7L8yK61uyJaKCrOZGjf7vowbSDdUnJo6+ehU3ye7p70Y3iDDONRZeHS4OnzF
         LkR3cTWp6AmOHE2xsNrYGQPcJDwKMNIGKISE4v5eHRKrVFhKXCSrn26GTI90DF/y0UmO
         ZLmJV9YroRFr0cj0Fw/1br9kJhyRnbX67eTMQTjBtDiv9o+f7OYUkTVf0CCgqfMLZXYI
         ydMMn5RVDpGop88uI8qu2e3aIwliDrqY505b3tCxWo4/HuFVnFKB7zKclzHu8+0QMLEZ
         wrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726867; x=1729331667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0+JljHLnekSSywTewBZ577k02mbpsj8v/vK0Vy1JgI=;
        b=qcR9xlxEauSPZrytxMdi58a/tFOhYhUgjg/dS1799YYIY0zyKDno+XxaJF9LNwVAix
         4hps4ekclwmSd9pAcaqqd3lV+6iP23fDQXel+T2J1x7X/NcClioafwp5HaVeqFhZx9NG
         81NaT+N/zOwjkBxg5kJp6XIRjA+ej6r6QCS2x8XkGrh4SqibEZ19lptmU09HWcOz2kF4
         2Swm9K8NPfePwgy5MRcD3/KfjDKrqBLI7pSQMuriLAc0wNcFsbxf3bUzeau+O4TOK6XN
         MU0tzkbmMC+Lje5k5lTvGCZ8ZOGBmtF81wiiWt1sQH4eXpLip8nDgRekEhhtTTB5dbp4
         72Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX9zj0GRKMV+86wc0C5CHr5e3Mh+K0GE2nZoXI3UsYIc6wnkYay6hzbnHX/Df44GNxIMz2miEUqlPXfwvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJ7uE66KAKC2QvC8+Aq1HjGPAnKNTlRwnLnY+CwFwvxaDd3/C
	vBHXd72YQjKFDuZNr6Aalx6jbAfSchqbD58h77ij2aYHqyUnPQsqlCRflGZFmsM=
X-Google-Smtp-Source: AGHT+IEK1IX3mMJ8J6tExuY2o4k7qTsPV8XSQbjjlQxUqeuwlfqZ1KIIBiCh3GfFPh+WpiWZTVN4vw==
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a99b930e9d1mr438252566b.13.1728726867324;
        Sat, 12 Oct 2024 02:54:27 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80cb013sm304462866b.131.2024.10.12.02.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:26 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:38 +0200
Subject: [PATCH 4/6] spi: don't check spi_controller::num_chipselect when
 parsing a dt device
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-4-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Do not validate spi_controller::num_chipselect against SPI_CS_CNT_MAX
when parsing an spi device firmware node.

Firstly this is the wrong place, and this should be done while
registering/validating the controller. Secondly, there is no reason for
that check, as SPI_CS_CNT_MAX controls the amount of chipselects a
device may have, not a controller may have.

So drop that check as it needlessly limits controllers to SPI_CS_CNT_MAX
number of chipselects.

Likewise, drop the check for number of device chipselects larger than
controller's number of chipselects, as __spi_add_device() will already
catch that as either one of the chip selects will be out of range, or
there is a duplicate one.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 495b391710d69a46beaa56c1a4332eb6677d2f45..ebf8bc9c2276a6f50ba6e9fded48c870c4bd5ff0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2430,11 +2430,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return 0;
 	}
 
-	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
-		dev_err(&ctlr->dev, "No. of CS is more than max. no. of supported CS\n");
-		return -EINVAL;
-	}
-
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
 						 SPI_CS_CNT_MAX);
@@ -2443,11 +2438,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			nc, rc);
 		return rc;
 	}
-	if (rc > ctlr->num_chipselect) {
-		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
-			nc, rc);
-		return -EINVAL;
-	}
+
 	if ((of_property_read_bool(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");

-- 
2.43.0


